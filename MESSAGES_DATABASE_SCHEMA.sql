-- ============================================
-- FLICK APP - MESSAGING TABLES
-- Add these tables to your Supabase database
-- ============================================

-- Conversations table
CREATE TABLE IF NOT EXISTS conversations (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    participant1_id UUID REFERENCES users(id) ON DELETE CASCADE,
    participant2_id UUID REFERENCES users(id) ON DELETE CASCADE,
    last_message TEXT,
    last_message_at TIMESTAMPTZ,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    
    -- Ensure unique conversation between two users
    CONSTRAINT unique_conversation UNIQUE (participant1_id, participant2_id)
);

-- Messages table
CREATE TABLE IF NOT EXISTS messages (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    conversation_id UUID REFERENCES conversations(id) ON DELETE CASCADE,
    sender_id UUID REFERENCES users(id) ON DELETE CASCADE,
    content TEXT NOT NULL,
    is_read BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Indexes for performance
CREATE INDEX IF NOT EXISTS idx_messages_conversation ON messages(conversation_id);
CREATE INDEX IF NOT EXISTS idx_messages_sender ON messages(sender_id);
CREATE INDEX IF NOT EXISTS idx_messages_created ON messages(created_at DESC);
CREATE INDEX IF NOT EXISTS idx_conversations_participant1 ON conversations(participant1_id);
CREATE INDEX IF NOT EXISTS idx_conversations_participant2 ON conversations(participant2_id);

-- Enable RLS
ALTER TABLE conversations ENABLE ROW LEVEL SECURITY;
ALTER TABLE messages ENABLE ROW LEVEL SECURITY;

-- Conversation policies (users can only see their own conversations)
CREATE POLICY "Users can view own conversations" ON conversations
    FOR SELECT USING (
        auth.uid() = participant1_id OR auth.uid() = participant2_id
    );

CREATE POLICY "Users can create conversations" ON conversations
    FOR INSERT WITH CHECK (
        auth.uid() = participant1_id OR auth.uid() = participant2_id
    );

CREATE POLICY "Users can update own conversations" ON conversations
    FOR UPDATE USING (
        auth.uid() = participant1_id OR auth.uid() = participant2_id
    );

-- Message policies (users can only see messages in their conversations)
CREATE POLICY "Users can view messages in their conversations" ON messages
    FOR SELECT USING (
        conversation_id IN (
            SELECT id FROM conversations 
            WHERE participant1_id = auth.uid() OR participant2_id = auth.uid()
        )
    );

CREATE POLICY "Users can send messages" ON messages
    FOR INSERT WITH CHECK (
        auth.uid() = sender_id AND
        conversation_id IN (
            SELECT id FROM conversations 
            WHERE participant1_id = auth.uid() OR participant2_id = auth.uid()
        )
    );

CREATE POLICY "Users can mark messages as read" ON messages
    FOR UPDATE USING (
        conversation_id IN (
            SELECT id FROM conversations 
            WHERE participant1_id = auth.uid() OR participant2_id = auth.uid()
        )
    );

-- Function to update conversation last_message when new message is sent
CREATE OR REPLACE FUNCTION update_conversation_last_message()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE conversations
    SET last_message = NEW.content,
        last_message_at = NEW.created_at
    WHERE id = NEW.conversation_id;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger to auto-update conversation
DROP TRIGGER IF EXISTS update_conversation_on_message ON messages;
CREATE TRIGGER update_conversation_on_message
    AFTER INSERT ON messages
    FOR EACH ROW
    EXECUTE FUNCTION update_conversation_last_message();

-- ============================================
-- SAMPLE DATA FOR TESTING
-- ============================================

-- Note: Replace UUIDs with actual user IDs from your users table

-- Example: Create sample conversations (uncomment and modify as needed)
-- INSERT INTO conversations (participant1_id, participant2_id, last_message, last_message_at)
-- VALUES 
--     ('user-uuid-1', 'user-uuid-2', 'Hey! Nice collection!', NOW()),
--     ('user-uuid-1', 'user-uuid-3', 'Interested in trading?', NOW() - INTERVAL '1 hour');

-- Example: Create sample messages
-- INSERT INTO messages (conversation_id, sender_id, content, is_read)
-- VALUES
--     ('conv-uuid-1', 'user-uuid-2', 'Hey! Nice collection!', true),
--     ('conv-uuid-1', 'user-uuid-1', 'Thanks! Ive been collecting for a while', true);
