-- Flick App Database Schema for Supabase
-- Run this in Supabase SQL Editor

-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Enable PostGIS for location data (optional but recommended)
CREATE EXTENSION IF NOT EXISTS "postgis";

-- ============================================
-- USERS TABLE
-- ============================================
CREATE TABLE IF NOT EXISTS users (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    email TEXT UNIQUE NOT NULL,
    username TEXT UNIQUE NOT NULL,
    avatar_url TEXT,
    bio TEXT,
    location TEXT,
    points INTEGER DEFAULT 0,
    level TEXT DEFAULT 'Bronze' CHECK (level IN ('Bronze', 'Silver', 'Gold', 'Platinum')),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create index on email for fast lookups
CREATE INDEX IF NOT EXISTS idx_users_email ON users(email);
CREATE INDEX IF NOT EXISTS idx_users_username ON users(username);

-- ============================================
-- LIGHTERS TABLE
-- ============================================
CREATE TABLE IF NOT EXISTS lighters (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    qr_code TEXT UNIQUE NOT NULL,
    owner_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    brand TEXT,
    color TEXT,
    photo_url TEXT,
    status TEXT NOT NULL DEFAULT 'owned' CHECK (status IN ('owned', 'lost', 'trading', 'found')),
    registered_at TIMESTAMPTZ DEFAULT NOW(),
    latitude DOUBLE PRECISION,
    longitude DOUBLE PRECISION,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create indexes for performance
CREATE INDEX IF NOT EXISTS idx_lighters_owner_id ON lighters(owner_id);
CREATE INDEX IF NOT EXISTS idx_lighters_qr_code ON lighters(qr_code);
CREATE INDEX IF NOT EXISTS idx_lighters_status ON lighters(status);
CREATE INDEX IF NOT EXISTS idx_lighters_location ON lighters(latitude, longitude) WHERE latitude IS NOT NULL AND longitude IS NOT NULL;

-- ============================================
-- ACHIEVEMENTS TABLE
-- ============================================
CREATE TABLE IF NOT EXISTS achievements (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    badge_type TEXT NOT NULL,
    title TEXT NOT NULL,
    description TEXT NOT NULL,
    icon TEXT NOT NULL,
    earned_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_achievements_user_id ON achievements(user_id);

-- ============================================
-- TRADES TABLE
-- ============================================
CREATE TABLE IF NOT EXISTS trades (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    requester_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    owner_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    lighter_offered_id UUID NOT NULL REFERENCES lighters(id) ON DELETE CASCADE,
    lighter_requested_id UUID NOT NULL REFERENCES lighters(id) ON DELETE CASCADE,
    status TEXT NOT NULL DEFAULT 'pending' CHECK (status IN ('pending', 'accepted', 'rejected', 'completed')),
    comment TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    CHECK (requester_id != owner_id),
    CHECK (lighter_offered_id != lighter_requested_id)
);

CREATE INDEX IF NOT EXISTS idx_trades_requester_id ON trades(requester_id);
CREATE INDEX IF NOT EXISTS idx_trades_owner_id ON trades(owner_id);
CREATE INDEX IF NOT EXISTS idx_trades_status ON trades(status);

-- ============================================
-- LOST_FOUND TABLE
-- ============================================
CREATE TABLE IF NOT EXISTS lost_found (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    lighter_id UUID NOT NULL REFERENCES lighters(id) ON DELETE CASCADE,
    reporter_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    status TEXT NOT NULL CHECK (status IN ('lost', 'found', 'returned')),
    description TEXT,
    latitude DOUBLE PRECISION,
    longitude DOUBLE PRECISION,
    reported_at TIMESTAMPTZ DEFAULT NOW(),
    created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_lost_found_lighter_id ON lost_found(lighter_id);
CREATE INDEX IF NOT EXISTS idx_lost_found_reporter_id ON lost_found(reporter_id);
CREATE INDEX IF NOT EXISTS idx_lost_found_status ON lost_found(status);

-- ============================================
-- OWNERSHIP_HISTORY TABLE (for tracking lighter ownership changes)
-- ============================================
CREATE TABLE IF NOT EXISTS ownership_history (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    lighter_id UUID NOT NULL REFERENCES lighters(id) ON DELETE CASCADE,
    previous_owner_id UUID REFERENCES users(id) ON DELETE SET NULL,
    new_owner_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    transfer_type TEXT NOT NULL CHECK (transfer_type IN ('trade', 'transfer', 'found', 'returned')),
    transferred_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_ownership_history_lighter_id ON ownership_history(lighter_id);
CREATE INDEX IF NOT EXISTS idx_ownership_history_new_owner_id ON ownership_history(new_owner_id);

-- ============================================
-- ROW LEVEL SECURITY (RLS) POLICIES
-- ============================================

-- Enable RLS on all tables
ALTER TABLE users ENABLE ROW LEVEL SECURITY;
ALTER TABLE lighters ENABLE ROW LEVEL SECURITY;
ALTER TABLE achievements ENABLE ROW LEVEL SECURITY;
ALTER TABLE trades ENABLE ROW LEVEL SECURITY;
ALTER TABLE lost_found ENABLE ROW LEVEL SECURITY;
ALTER TABLE ownership_history ENABLE ROW LEVEL SECURITY;

-- Users policies
CREATE POLICY "Users can view their own profile" ON users
    FOR SELECT USING (auth.uid() = id);

CREATE POLICY "Users can update their own profile" ON users
    FOR UPDATE USING (auth.uid() = id);

CREATE POLICY "Users can view other users' public profiles" ON users
    FOR SELECT USING (true);

-- Lighters policies
CREATE POLICY "Users can view all lighters" ON lighters
    FOR SELECT USING (true);

CREATE POLICY "Users can insert their own lighters" ON lighters
    FOR INSERT WITH CHECK (auth.uid() = owner_id);

CREATE POLICY "Users can update their own lighters" ON lighters
    FOR UPDATE USING (auth.uid() = owner_id);

CREATE POLICY "Users can delete their own lighters" ON lighters
    FOR DELETE USING (auth.uid() = owner_id);

-- Achievements policies
CREATE POLICY "Users can view all achievements" ON achievements
    FOR SELECT USING (true);

CREATE POLICY "Users can view their own achievements" ON achievements
    FOR SELECT USING (auth.uid() = user_id);

-- Trades policies
CREATE POLICY "Users can view trades they're involved in" ON trades
    FOR SELECT USING (auth.uid() = requester_id OR auth.uid() = owner_id);

CREATE POLICY "Users can create trade requests" ON trades
    FOR INSERT WITH CHECK (auth.uid() = requester_id);

CREATE POLICY "Owners can update their trade requests" ON trades
    FOR UPDATE USING (auth.uid() = owner_id);

-- Lost Found policies
CREATE POLICY "Users can view all lost/found items" ON lost_found
    FOR SELECT USING (true);

CREATE POLICY "Users can report lost/found items" ON lost_found
    FOR INSERT WITH CHECK (auth.uid() = reporter_id);

CREATE POLICY "Users can update their own reports" ON lost_found
    FOR UPDATE USING (auth.uid() = reporter_id);

-- Ownership History policies
CREATE POLICY "Users can view ownership history for lighters they own" ON ownership_history
    FOR SELECT USING (
        EXISTS (
            SELECT 1 FROM lighters 
            WHERE lighters.id = ownership_history.lighter_id 
            AND lighters.owner_id = auth.uid()
        )
    );

-- ============================================
-- FUNCTIONS AND TRIGGERS
-- ============================================

-- Function to update updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Triggers for updated_at
CREATE TRIGGER update_users_updated_at BEFORE UPDATE ON users
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_lighters_updated_at BEFORE UPDATE ON lighters
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_trades_updated_at BEFORE UPDATE ON trades
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- Function to create user profile after signup
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO public.users (id, email, username)
    VALUES (
        NEW.id,
        NEW.email,
        COALESCE(NEW.raw_user_meta_data->>'username', split_part(NEW.email, '@', 1))
    );
    RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Trigger to create user profile on signup
CREATE TRIGGER on_auth_user_created
    AFTER INSERT ON auth.users
    FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();

-- Function to log ownership changes
CREATE OR REPLACE FUNCTION log_ownership_change()
RETURNS TRIGGER AS $$
BEGIN
    IF OLD.owner_id IS DISTINCT FROM NEW.owner_id THEN
        INSERT INTO ownership_history (lighter_id, previous_owner_id, new_owner_id, transfer_type)
        VALUES (NEW.id, OLD.owner_id, NEW.owner_id, 'transfer');
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger to log ownership changes
CREATE TRIGGER on_lighter_ownership_change
    AFTER UPDATE OF owner_id ON lighters
    FOR EACH ROW
    WHEN (OLD.owner_id IS DISTINCT FROM NEW.owner_id)
    EXECUTE FUNCTION log_ownership_change();

-- ============================================
-- VIEWS FOR COMMON QUERIES
-- ============================================

-- View for marketplace lighters (lighters marked for trading)
CREATE OR REPLACE VIEW marketplace_lighters AS
SELECT 
    l.*,
    u.username as owner_username,
    u.avatar_url as owner_avatar_url
FROM lighters l
JOIN users u ON l.owner_id = u.id
WHERE l.status = 'trading';

-- View for user statistics
CREATE OR REPLACE VIEW user_stats AS
SELECT 
    u.id,
    u.username,
    u.points,
    u.level,
    COUNT(DISTINCT l.id) as lighter_count,
    COUNT(DISTINCT a.id) as achievement_count,
    COUNT(DISTINCT t.id) as trade_count
FROM users u
LEFT JOIN lighters l ON u.id = l.owner_id
LEFT JOIN achievements a ON u.id = a.user_id
LEFT JOIN trades t ON (u.id = t.requester_id OR u.id = t.owner_id)
GROUP BY u.id, u.username, u.points, u.level;

-- ============================================
-- SAMPLE DATA (Optional - for testing)
-- ============================================
-- Uncomment below to insert sample data

/*
-- Sample user (if not created via auth)
INSERT INTO users (id, email, username, points, level) 
VALUES ('00000000-0000-0000-0000-000000000001', 'demo@flick.app', 'DemoUser', 1250, 'Silver')
ON CONFLICT (id) DO NOTHING;
*/

