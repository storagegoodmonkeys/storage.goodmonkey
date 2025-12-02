-- ============================================
-- SAMPLE DATA FOR FLICK APP
-- Run this in Supabase SQL Editor
-- ============================================

-- First, let's get the UUIDs we'll need
-- We'll create users first, then use their IDs

-- ============================================
-- SAMPLE USER 1: "Sample 1"
-- ============================================
INSERT INTO users (email, username, bio, location, points, level)
VALUES (
    'sample1@flick.app',
    'Sample 1',
    'Lighter collector since 2020. Love vintage designs!',
    'New York, NY',
    1250,
    'Silver'
) ON CONFLICT (email) DO NOTHING
RETURNING id;

-- Get the user ID for Sample 1 (you'll need to run these separately or use CTEs)
-- For now, I'll use a subquery approach

-- Lighters for Sample 1
INSERT INTO lighters (qr_code, owner_id, brand, color, status, latitude, longitude)
SELECT 
    'FLICK-SAMPLE1-001',
    (SELECT id FROM users WHERE username = 'Sample 1'),
    'Clipper Ocean',
    'Blue',
    'owned',
    40.7128,
    -74.0060
ON CONFLICT (qr_code) DO NOTHING;

INSERT INTO lighters (qr_code, owner_id, brand, color, status, latitude, longitude)
SELECT 
    'FLICK-SAMPLE1-002',
    (SELECT id FROM users WHERE username = 'Sample 1'),
    'Clipper Dreams',
    'Purple',
    'owned',
    40.7580,
    -73.9855
ON CONFLICT (qr_code) DO NOTHING;

INSERT INTO lighters (qr_code, owner_id, brand, color, status, latitude, longitude)
SELECT 
    'FLICK-SAMPLE1-003',
    (SELECT id FROM users WHERE username = 'Sample 1'),
    'Clipper Vintage',
    'Gold',
    'trading',
    40.7505,
    -73.9934
ON CONFLICT (qr_code) DO NOTHING;

-- Achievements for Sample 1
INSERT INTO achievements (user_id, badge_type, title, description, icon)
SELECT 
    (SELECT id FROM users WHERE username = 'Sample 1'),
    'First Scan',
    'First Lighter',
    'Registered your first lighter',
    'flame.fill'
ON CONFLICT DO NOTHING;

INSERT INTO achievements (user_id, badge_type, title, description, icon)
SELECT 
    (SELECT id FROM users WHERE username = 'Sample 1'),
    'Collector',
    'Collector',
    'Added 3 lighters to your collection',
    'square.stack.3d.up.fill'
ON CONFLICT DO NOTHING;

-- ============================================
-- SAMPLE USER 2: "Sample 2"
-- ============================================
INSERT INTO users (email, username, bio, location, points, level)
VALUES (
    'sample2@flick.app',
    'Sample 2',
    'Trading enthusiast. Always looking for unique pieces!',
    'Los Angeles, CA',
    890,
    'Bronze'
) ON CONFLICT (email) DO NOTHING;

-- Lighters for Sample 2
INSERT INTO lighters (qr_code, owner_id, brand, color, status, latitude, longitude)
SELECT 
    'FLICK-SAMPLE2-001',
    (SELECT id FROM users WHERE username = 'Sample 2'),
    'Clipper Graffiti',
    'Multi-color',
    'owned',
    34.0522,
    -118.2437
ON CONFLICT (qr_code) DO NOTHING;

INSERT INTO lighters (qr_code, owner_id, brand, color, status, latitude, longitude)
SELECT 
    'FLICK-SAMPLE2-002',
    (SELECT id FROM users WHERE username = 'Sample 2'),
    'Clipper Fantasy',
    'Pink',
    'trading',
    34.0689,
    -118.4452
ON CONFLICT (qr_code) DO NOTHING;

-- Achievements for Sample 2
INSERT INTO achievements (user_id, badge_type, title, description, icon)
SELECT 
    (SELECT id FROM users WHERE username = 'Sample 2'),
    'First Scan',
    'First Lighter',
    'Registered your first lighter',
    'flame.fill'
ON CONFLICT DO NOTHING;

INSERT INTO achievements (user_id, badge_type, title, description, icon)
SELECT 
    (SELECT id FROM users WHERE username = 'Sample 2'),
    'Trader',
    'Trader',
    'Completed your first trade',
    'handshake.fill'
ON CONFLICT DO NOTHING;

-- ============================================
-- SAMPLE USER 3: "Sample 3"
-- ============================================
INSERT INTO users (email, username, bio, location, points, level)
VALUES (
    'sample3@flick.app',
    'Sample 3',
    'Lost & Found helper. Helping reconnect lighters with owners!',
    'Chicago, IL',
    2100,
    'Gold'
) ON CONFLICT (email) DO NOTHING;

-- Lighters for Sample 3
INSERT INTO lighters (qr_code, owner_id, brand, color, status, latitude, longitude)
SELECT 
    'FLICK-SAMPLE3-001',
    (SELECT id FROM users WHERE username = 'Sample 3'),
    'Clipper Classic',
    'Red',
    'owned',
    41.8781,
    -87.6298
ON CONFLICT (qr_code) DO NOTHING;

INSERT INTO lighters (qr_code, owner_id, brand, color, status, latitude, longitude)
SELECT 
    'FLICK-SAMPLE3-002',
    (SELECT id FROM users WHERE username = 'Sample 3'),
    'Clipper Neon',
    'Neon Green',
    'owned',
    41.8819,
    -87.6278
ON CONFLICT (qr_code) DO NOTHING;

INSERT INTO lighters (qr_code, owner_id, brand, color, status, latitude, longitude)
SELECT 
    'FLICK-SAMPLE3-003',
    (SELECT id FROM users WHERE username = 'Sample 3'),
    'Clipper Metal',
    'Silver',
    'found',
    41.8881,
    -87.6236
ON CONFLICT (qr_code) DO NOTHING;

-- Achievements for Sample 3
INSERT INTO achievements (user_id, badge_type, title, description, icon)
SELECT 
    (SELECT id FROM users WHERE username = 'Sample 3'),
    'First Scan',
    'First Lighter',
    'Registered your first lighter',
    'flame.fill'
ON CONFLICT DO NOTHING;

INSERT INTO achievements (user_id, badge_type, title, description, icon)
SELECT 
    (SELECT id FROM users WHERE username = 'Sample 3'),
    'Helper',
    'Good Samaritan',
    'Reported a found lighter',
    'heart.fill'
ON CONFLICT DO NOTHING;

-- ============================================
-- TRADES (between Sample users)
-- ============================================

-- Trade: Sample 1 wants to trade with Sample 2
INSERT INTO trades (requester_id, owner_id, lighter_offered_id, lighter_requested_id, status, comment)
SELECT 
    (SELECT id FROM users WHERE username = 'Sample 1'),
    (SELECT id FROM users WHERE username = 'Sample 2'),
    (SELECT id FROM lighters WHERE qr_code = 'FLICK-SAMPLE1-003'),
    (SELECT id FROM lighters WHERE qr_code = 'FLICK-SAMPLE2-002'),
    'pending',
    'Love this design! Would you be interested in trading?'
WHERE EXISTS (SELECT 1 FROM users WHERE username = 'Sample 1')
  AND EXISTS (SELECT 1 FROM users WHERE username = 'Sample 2')
  AND EXISTS (SELECT 1 FROM lighters WHERE qr_code = 'FLICK-SAMPLE1-003')
  AND EXISTS (SELECT 1 FROM lighters WHERE qr_code = 'FLICK-SAMPLE2-002');

-- ============================================
-- LOST & FOUND
-- ============================================

-- Sample 3 found a lighter
INSERT INTO lost_found (lighter_id, reporter_id, status, description, latitude, longitude)
SELECT 
    (SELECT id FROM lighters WHERE qr_code = 'FLICK-SAMPLE3-003'),
    (SELECT id FROM users WHERE username = 'Sample 3'),
    'found',
    'Found this lighter at Millennium Park. Looks like a Clipper Metal in silver.',
    41.8825,
    -87.6244
WHERE EXISTS (SELECT 1 FROM lighters WHERE qr_code = 'FLICK-SAMPLE3-003')
  AND EXISTS (SELECT 1 FROM users WHERE username = 'Sample 3');

-- ============================================
-- VERIFICATION QUERY
-- ============================================

-- Run this to verify all data was inserted:
-- SELECT 'Users' as table_name, COUNT(*) as count FROM users WHERE username IN ('Sample 1', 'Sample 2', 'Sample 3')
-- UNION ALL
-- SELECT 'Lighters', COUNT(*) FROM lighters WHERE owner_id IN (SELECT id FROM users WHERE username IN ('Sample 1', 'Sample 2', 'Sample 3'))
-- UNION ALL
-- SELECT 'Achievements', COUNT(*) FROM achievements WHERE user_id IN (SELECT id FROM users WHERE username IN ('Sample 1', 'Sample 2', 'Sample 3'))
-- UNION ALL
-- SELECT 'Trades', COUNT(*) FROM trades WHERE requester_id IN (SELECT id FROM users WHERE username IN ('Sample 1', 'Sample 2', 'Sample 3'))
-- UNION ALL
-- SELECT 'Lost Found', COUNT(*) FROM lost_found WHERE reporter_id IN (SELECT id FROM users WHERE username IN ('Sample 1', 'Sample 2', 'Sample 3'));

