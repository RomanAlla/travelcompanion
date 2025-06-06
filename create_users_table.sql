CREATE TABLE users (id uuid PRIMARY KEY, email text NOT NULL, name text, photo_url text, country text, languages text[], preferences jsonb, created_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL);
ALTER TABLE users ENABLE ROW LEVEL SECURITY;
CREATE POLICY \
Users
can
view
own
profile\ ON users FOR SELECT USING (auth.uid() = id);
CREATE POLICY \
Users
can
update
own
profile\ ON users FOR UPDATE USING (auth.uid() = id);
CREATE POLICY \
Users
can
insert
own
profile\ ON users FOR INSERT WITH CHECK (auth.uid() = id);
CREATE POLICY \
Users
can
delete
own
profile\ ON users FOR DELETE USING (auth.uid() = id);
