
-- Journal API database schema

-- Create entries table
CREATE TABLE IF NOT EXISTS entries (
    id VARCHAR PRIMARY KEY,
    data JSONB NOT NULL,
    created_at TIMESTAMPTZ NOT NULL,
    updated_at TIMESTAMPTZ NOT NULL
);

-- Index for queries sorted or filtered by creation date
CREATE INDEX IF NOT EXISTS idx_entries_created_at
    ON entries (created_at);

-- GIN index for searching JSONB data
CREATE INDEX IF NOT EXISTS idx_entries_data_gin
    ON entries USING GIN (data);
