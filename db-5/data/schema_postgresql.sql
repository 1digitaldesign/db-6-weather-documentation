-- PostgreSQL-compatible schema for db-5
-- Production schema extracted from database dump
SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;
COMMENT ON SCHEMA "public" IS 'standard public schema';
CREATE EXTENSION IF NOT EXISTS "pg_graphql" WITH SCHEMA "graphql";
CREATE EXTENSION IF NOT EXISTS "pg_stat_statements" WITH SCHEMA "extensions";
CREATE EXTENSION IF NOT EXISTS "pgcrypto" WITH SCHEMA "extensions";
CREATE EXTENSION IF NOT EXISTS "pgjwt" WITH SCHEMA "extensions";
CREATE EXTENSION IF NOT EXISTS "supabase_vault" WITH SCHEMA "vault";
CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA "extensions";
CREATE TYPE "public"."user_role" AS ENUM (
ALTER TYPE "public"."user_role" OWNER TO "postgres";
CREATE OR REPLACE FUNCTION "public"."accept_chat_invitation"("invitation_id" "uuid") RETURNS "void"
ALTER FUNCTION "public"."accept_chat_invitation"("invitation_id" "uuid") OWNER TO "postgres";
COMMENT ON FUNCTION "public"."accept_chat_invitation"("invitation_id" "uuid") IS 'Accepts a chat invitation and adds the user to the chat participants.';
CREATE OR REPLACE FUNCTION "public"."create_anonymous_chat"() RETURNS TABLE("chat_id" "uuid", "join_code" "text")
ALTER FUNCTION "public"."create_anonymous_chat"() OWNER TO "postgres";
CREATE OR REPLACE FUNCTION "public"."handle_new_mention"() RETURNS "trigger"
ALTER FUNCTION "public"."handle_new_mention"() OWNER TO "postgres";
CREATE OR REPLACE FUNCTION "public"."handle_new_user"() RETURNS "trigger"
ALTER FUNCTION "public"."handle_new_user"() OWNER TO "postgres";
COMMENT ON FUNCTION "public"."handle_new_user"() IS 'Trigger function to create a user profile upon new user signup.
CREATE OR REPLACE FUNCTION "public"."handle_updated_at"() RETURNS "trigger"
ALTER FUNCTION "public"."handle_updated_at"() OWNER TO "postgres";
CREATE OR REPLACE FUNCTION "public"."is_chat_participant"("_user_id" "uuid", "_chat_id" "uuid") RETURNS boolean
ALTER FUNCTION "public"."is_chat_participant"("_user_id" "uuid", "_chat_id" "uuid") OWNER TO "postgres";
COMMENT ON FUNCTION "public"."is_chat_participant"("_user_id" "uuid", "_chat_id" "uuid") IS 'Checks if a user is a participant in a chat. SECURITY DEFINER bypasses RLS.';
CREATE OR REPLACE FUNCTION "public"."is_user_in_chat"("chat_uuid" "uuid") RETURNS boolean
ALTER FUNCTION "public"."is_user_in_chat"("chat_uuid" "uuid") OWNER TO "postgres";
CREATE OR REPLACE FUNCTION "public"."leave_chat"("p_chat_id" "uuid") RETURNS "void"
ALTER FUNCTION "public"."leave_chat"("p_chat_id" "uuid") OWNER TO "postgres";
CREATE OR REPLACE FUNCTION "public"."update_chat_timestamp"() RETURNS "trigger"
ALTER FUNCTION "public"."update_chat_timestamp"() OWNER TO "postgres";
CREATE OR REPLACE FUNCTION "public"."update_friends_updated_at"() RETURNS "trigger"
ALTER FUNCTION "public"."update_friends_updated_at"() OWNER TO "postgres";
CREATE OR REPLACE FUNCTION "public"."update_notification_count"() RETURNS "trigger"
ALTER FUNCTION "public"."update_notification_count"() OWNER TO "postgres";
CREATE OR REPLACE FUNCTION "public"."update_notifications_updated_at"() RETURNS "trigger"
ALTER FUNCTION "public"."update_notifications_updated_at"() OWNER TO "postgres";
CREATE OR REPLACE FUNCTION "public"."update_updated_at_column"() RETURNS "trigger"
ALTER FUNCTION "public"."update_updated_at_column"() OWNER TO "postgres";
SET default_tablespace = '';
SET default_table_access_method = "heap";
CREATE TABLE IF NOT EXISTS "public"."anonymous_chat_users" (
ALTER TABLE "public"."anonymous_chat_users" OWNER TO "postgres";
CREATE TABLE IF NOT EXISTS "public"."anonymous_chats" (
ALTER TABLE "public"."anonymous_chats" OWNER TO "postgres";
COMMENT ON TABLE "public"."anonymous_chats" IS 'Stores information about anonymous chat sessions, identified by a unique join code.';
CREATE TABLE IF NOT EXISTS "public"."anonymous_messages" (
ALTER TABLE "public"."anonymous_messages" OWNER TO "postgres";
COMMENT ON TABLE "public"."anonymous_messages" IS 'Stores messages for anonymous chat sessions.';
CREATE TABLE IF NOT EXISTS "public"."chat_invitations" (
ALTER TABLE "public"."chat_invitations" OWNER TO "postgres";
CREATE TABLE IF NOT EXISTS "public"."chat_participants" (
ALTER TABLE "public"."chat_participants" OWNER TO "postgres";
COMMENT ON TABLE "public"."chat_participants" IS 'Stores chat participants with non-recursive policies that:
CREATE TABLE IF NOT EXISTS "public"."chat_users" (
ALTER TABLE "public"."chat_users" OWNER TO "postgres";
CREATE TABLE IF NOT EXISTS "public"."chats" (
ALTER TABLE "public"."chats" OWNER TO "postgres";
COMMENT ON TABLE "public"."chats" IS 'Stores chat rooms with proper access control:
CREATE TABLE IF NOT EXISTS "public"."file_attachments" (
ALTER TABLE "public"."file_attachments" OWNER TO "postgres";
CREATE TABLE IF NOT EXISTS "public"."friends" (
ALTER TABLE "public"."friends" OWNER TO "postgres";
CREATE TABLE IF NOT EXISTS "public"."messages" (
ALTER TABLE "public"."messages" OWNER TO "postgres";
COMMENT ON TABLE "public"."messages" IS 'Stores all chat messages, including both user messages and AI responses';
COMMENT ON COLUMN "public"."messages"."is_ai" IS 'Indicates if the message is from an AI character';
COMMENT ON COLUMN "public"."messages"."ai_character_id" IS 'References the AI character that generated this message, if applicable';
CREATE TABLE IF NOT EXISTS "public"."notifications" (
ALTER TABLE "public"."notifications" OWNER TO "postgres";
CREATE TABLE IF NOT EXISTS "public"."profiles" (
ALTER TABLE "public"."profiles" OWNER TO "postgres";
COMMENT ON COLUMN "public"."profiles"."last_username_changed_at" IS 'Timestamp of when the user last changed their username. Used for cooldown.';
COMMENT ON COLUMN "public"."profiles"."prompt_username_setup" IS 'Flag to indicate if the user should be prompted to set/confirm their username, especially for new OAuth users.';
ALTER TABLE ONLY "public"."anonymous_chat_users"
ALTER TABLE ONLY "public"."anonymous_chat_users"
ALTER TABLE ONLY "public"."anonymous_chats"
ALTER TABLE ONLY "public"."anonymous_chats"
ALTER TABLE ONLY "public"."anonymous_messages"
ALTER TABLE ONLY "public"."chat_invitations"
ALTER TABLE ONLY "public"."chat_participants"
ALTER TABLE ONLY "public"."chat_users"
ALTER TABLE ONLY "public"."chat_users"
ALTER TABLE ONLY "public"."chats"
ALTER TABLE ONLY "public"."file_attachments"
ALTER TABLE ONLY "public"."friends"
ALTER TABLE ONLY "public"."friends"
ALTER TABLE ONLY "public"."messages"
ALTER TABLE ONLY "public"."notifications"
ALTER TABLE ONLY "public"."profiles"
ALTER TABLE ONLY "public"."profiles"
ALTER TABLE ONLY "public"."profiles"
CREATE INDEX "idx_anonymous_chats_join_code" ON "public"."anonymous_chats" USING "btree" ("join_code");
CREATE INDEX "idx_anonymous_messages_chat_id" ON "public"."anonymous_messages" USING "btree" ("chat_id");
CREATE INDEX "idx_chat_invitations_chat_id" ON "public"."chat_invitations" USING "btree" ("chat_id");
CREATE INDEX "idx_chat_users_chat_id" ON "public"."chat_users" USING "btree" ("chat_id");
CREATE INDEX "idx_chat_users_user_id" ON "public"."chat_users" USING "btree" ("user_id");
CREATE INDEX "idx_chats_created_by" ON "public"."chats" USING "btree" ("created_by");
CREATE INDEX "idx_friends_friend_id" ON "public"."friends" USING "btree" ("friend_id");
CREATE INDEX "idx_friends_status" ON "public"."friends" USING "btree" ("status");
CREATE INDEX "idx_friends_user_id" ON "public"."friends" USING "btree" ("user_id");
CREATE INDEX "idx_messages_ai_character_id" ON "public"."messages" USING "btree" ("ai_character_id") WHERE ("ai_character_id" IS NOT NULL);
CREATE INDEX "idx_messages_chat_id" ON "public"."messages" USING "btree" ("chat_id");
CREATE INDEX "idx_messages_created_at" ON "public"."messages" USING "btree" ("created_at");
CREATE INDEX "idx_messages_sender_id" ON "public"."messages" USING "btree" ("sender_id");
CREATE INDEX "idx_notifications_created_at" ON "public"."notifications" USING "btree" ("created_at");
CREATE INDEX "idx_notifications_read" ON "public"."notifications" USING "btree" ("read");
CREATE INDEX "idx_notifications_type" ON "public"."notifications" USING "btree" ("type");
CREATE INDEX "idx_notifications_user_id" ON "public"."notifications" USING "btree" ("user_id");
CREATE INDEX "idx_notifications_user_id_created_at" ON "public"."notifications" USING "btree" ("user_id", "created_at" DESC);
CREATE INDEX "idx_user_unseen_notifications" ON "public"."notifications" USING "btree" ("user_id", "seen_at") WHERE ("seen_at" IS NULL);
CREATE UNIQUE INDEX "profiles_email_idx" ON "public"."profiles" USING "btree" ("email") WHERE ("email" IS NOT NULL);
CREATE OR REPLACE TRIGGER "handle_updated_at" BEFORE UPDATE ON "public"."messages" FOR EACH ROW EXECUTE FUNCTION "public"."handle_updated_at"();
CREATE OR REPLACE TRIGGER "on_new_mention" AFTER INSERT ON "public"."messages" FOR EACH ROW WHEN (("jsonb_array_length"("new"."mentions_data") > 0)) EXECUTE FUNCTION "public"."handle_new_mention"();
CREATE OR REPLACE TRIGGER "trigger_update_chat_timestamp" AFTER INSERT ON "public"."messages" FOR EACH ROW EXECUTE FUNCTION "public"."update_chat_timestamp"();
CREATE OR REPLACE TRIGGER "update_anonymous_chats_updated_at" BEFORE UPDATE ON "public"."anonymous_chats" FOR EACH ROW EXECUTE FUNCTION "public"."update_updated_at_column"();
CREATE OR REPLACE TRIGGER "update_chat_invitations_updated_at" BEFORE UPDATE ON "public"."chat_invitations" FOR EACH ROW EXECUTE FUNCTION "public"."update_updated_at_column"();
CREATE OR REPLACE TRIGGER "update_friends_updated_at" BEFORE UPDATE ON "public"."friends" FOR EACH ROW EXECUTE FUNCTION "public"."update_friends_updated_at"();
CREATE OR REPLACE TRIGGER "update_notifications_updated_at" BEFORE UPDATE ON "public"."notifications" FOR EACH ROW EXECUTE FUNCTION "public"."update_notifications_updated_at"();
CREATE OR REPLACE TRIGGER "update_profiles_updated_at" BEFORE UPDATE ON "public"."profiles" FOR EACH ROW EXECUTE FUNCTION "public"."update_updated_at_column"();
ALTER TABLE ONLY "public"."anonymous_chat_users"
ALTER TABLE ONLY "public"."anonymous_messages"
ALTER TABLE ONLY "public"."chat_invitations"
ALTER TABLE ONLY "public"."chat_invitations"
ALTER TABLE ONLY "public"."chat_invitations"
ALTER TABLE ONLY "public"."chat_participants"
ALTER TABLE ONLY "public"."chat_users"
ALTER TABLE ONLY "public"."chat_users"
ALTER TABLE ONLY "public"."chats"
ALTER TABLE ONLY "public"."file_attachments"
ALTER TABLE ONLY "public"."file_attachments"
ALTER TABLE ONLY "public"."file_attachments"
ALTER TABLE ONLY "public"."friends"
ALTER TABLE ONLY "public"."friends"
ALTER TABLE ONLY "public"."messages"
ALTER TABLE ONLY "public"."messages"
ALTER TABLE ONLY "public"."notifications"
ALTER TABLE ONLY "public"."profiles"
CREATE POLICY "Allow all users to see chat names" ON "public"."chats" FOR SELECT TO "authenticated" USING (true);
CREATE POLICY "Allow anon insert for messages in anonymous chats" ON "public"."anonymous_messages" FOR INSERT TO "anon" WITH CHECK ((EXISTS ( SELECT 1
CREATE POLICY "Allow anon insert for new anonymous chats" ON "public"."anonymous_chats" FOR INSERT TO "anon" WITH CHECK (true);
CREATE POLICY "Allow anon select for anonymous chats by join_code" ON "public"."anonymous_chats" FOR SELECT TO "anon" USING (true);
CREATE POLICY "Allow anon select for messages in anonymous chats" ON "public"."anonymous_messages" FOR SELECT TO "anon" USING ((EXISTS ( SELECT 1
CREATE POLICY "Allow authenticated users to insert chats" ON "public"."chats" FOR INSERT TO "authenticated" WITH CHECK (true);
CREATE POLICY "Allow authenticated users to insert their own profile" ON "public"."profiles" FOR INSERT TO "authenticated" WITH CHECK (("auth"."uid"() = "id"));
CREATE POLICY "Allow authenticated users to select chats" ON "public"."chats" FOR SELECT TO "authenticated" USING ((EXISTS ( SELECT 1
CREATE POLICY "Allow authenticated users to view all chat participants" ON "public"."chat_participants" FOR SELECT TO "authenticated" USING ("public"."is_user_in_chat"("chat_id"));
CREATE POLICY "Allow chat creators to delete their chats" ON "public"."chats" FOR DELETE TO "authenticated" USING (("created_by" = "auth"."uid"()));
CREATE POLICY "Allow chat creators to update their chats" ON "public"."chats" FOR UPDATE TO "authenticated" USING (("created_by" = "auth"."uid"())) WITH CHECK (true);
CREATE POLICY "Allow chat participants to delete chats" ON "public"."chats" FOR DELETE TO "authenticated" USING ((EXISTS ( SELECT 1
CREATE POLICY "Allow participants to insert their own chat participants" ON "public"."chat_participants" FOR INSERT TO "authenticated" WITH CHECK (("user_id" = ( SELECT "auth"."uid"() AS "uid")));
CREATE POLICY "Allow participants to insert their own chats" ON "public"."chats" FOR INSERT TO "authenticated" WITH CHECK (true);
CREATE POLICY "Allow participants to select chats" ON "public"."chats" FOR SELECT TO "authenticated" USING ((EXISTS ( SELECT 1
COMMENT ON POLICY "Allow participants to select chats" ON "public"."chats" IS 'Allows authenticated users to select chats they are participants in.';
CREATE POLICY "Allow participants to select their own chat participants" ON "public"."chat_participants" FOR SELECT TO "authenticated" USING (("user_id" = ( SELECT "auth"."uid"() AS "uid")));
CREATE POLICY "Allow participants to select their own chats" ON "public"."chats" FOR SELECT TO "authenticated" USING ((EXISTS ( SELECT 1
CREATE POLICY "Allow system inserts for profile creation" ON "public"."profiles" FOR INSERT WITH CHECK (("auth"."uid"() IS NULL));
CREATE POLICY "Allow users to insert new chats" ON "public"."chats" FOR INSERT TO "authenticated" WITH CHECK (true);
CREATE POLICY "Allow users to select their own chats" ON "public"."chats" FOR SELECT TO "authenticated" USING (("created_by" = "auth"."uid"()));
CREATE POLICY "Anyone can create anonymous chat users" ON "public"."anonymous_chat_users" FOR INSERT WITH CHECK (true);
CREATE POLICY "Anyone can create anonymous chats" ON "public"."anonymous_chats" FOR INSERT WITH CHECK (true);
CREATE POLICY "Anyone can create anonymous messages" ON "public"."anonymous_messages" FOR INSERT WITH CHECK (true);
CREATE POLICY "Anyone can delete anonymous chat users" ON "public"."anonymous_chat_users" FOR DELETE USING (true);
CREATE POLICY "Anyone can read anonymous chat users" ON "public"."anonymous_chat_users" FOR SELECT USING (true);
CREATE POLICY "Anyone can read anonymous chats" ON "public"."anonymous_chats" FOR SELECT USING (true);
CREATE POLICY "Anyone can read anonymous messages" ON "public"."anonymous_messages" FOR SELECT USING (true);
CREATE POLICY "Anyone can update anonymous chats" ON "public"."anonymous_chats" FOR UPDATE USING (true);
CREATE POLICY "Chat creators can delete their chats" ON "public"."chats" FOR DELETE TO "authenticated" USING (("created_by" = "auth"."uid"()));
COMMENT ON POLICY "Chat creators can delete their chats" ON "public"."chats" IS 'Allows authenticated users to delete chats they created.';
CREATE POLICY "Chat creators can update their chats" ON "public"."chats" FOR UPDATE TO "authenticated" USING (("created_by" = "auth"."uid"()));
COMMENT ON POLICY "Chat creators can update their chats" ON "public"."chats" IS 'Allows authenticated users to update chats they created.';
CREATE POLICY "Chat participants can create invitations" ON "public"."chat_invitations" FOR INSERT WITH CHECK ((EXISTS ( SELECT 1
CREATE POLICY "Chat participants can insert messages" ON "public"."messages" FOR INSERT WITH CHECK ((EXISTS ( SELECT 1
CREATE POLICY "Chat participants can update their own messages" ON "public"."messages" FOR UPDATE USING ((("sender_id" = "auth"."uid"()) AND (EXISTS ( SELECT 1
CREATE POLICY "Chat participants can view messages" ON "public"."messages" FOR SELECT USING ((EXISTS ( SELECT 1
CREATE POLICY "Invited users can delete their own invitations" ON "public"."chat_invitations" FOR DELETE TO "authenticated" USING (("invited_user_id" = ( SELECT "auth"."uid"() AS "uid")));
CREATE POLICY "Invited users can update their invitation status" ON "public"."chat_invitations" FOR UPDATE USING ((("invited_user_id" = "auth"."uid"()) AND ("status" = 'pending'::"text"))) WITH CHECK (("status" = ANY (ARRAY['accepted'::"text", 'rejected'::"text"])));
CREATE POLICY "Profiles are viewable by everyone" ON "public"."profiles" FOR SELECT USING (true);
CREATE POLICY "Service role can do everything" ON "public"."notifications" TO "service_role" USING (true) WITH CHECK (true);
CREATE POLICY "Users can create friend requests" ON "public"."friends" FOR INSERT WITH CHECK (("auth"."uid"() = "user_id"));
CREATE POLICY "Users can create notifications for others" ON "public"."notifications" FOR INSERT WITH CHECK (true);
CREATE POLICY "Users can delete their own file attachments" ON "public"."file_attachments" FOR DELETE USING (("user_id" = "auth"."uid"()));
CREATE POLICY "Users can delete their own notifications" ON "public"."notifications" FOR DELETE USING (("auth"."uid"() = "user_id"));
CREATE POLICY "Users can delete their own profile" ON "public"."profiles" FOR DELETE TO "authenticated" USING (("auth"."uid"() = "id"));
CREATE POLICY "Users can delete themselves from chat_users" ON "public"."chat_users" FOR DELETE USING (("user_id" = "auth"."uid"()));
CREATE POLICY "Users can insert file attachments in chats they participate in" ON "public"."file_attachments" FOR INSERT WITH CHECK (((EXISTS ( SELECT 1
CREATE POLICY "Users can insert themselves into chat_users" ON "public"."chat_users" FOR INSERT WITH CHECK (("user_id" = "auth"."uid"()));
CREATE POLICY "Users can join chats they're invited to" ON "public"."chat_participants" FOR INSERT WITH CHECK ((EXISTS ( SELECT 1
CREATE POLICY "Users can leave chats they are part of" ON "public"."chat_participants" FOR DELETE TO "authenticated" USING ((("user_id" = "auth"."uid"()) AND (EXISTS ( SELECT 1
CREATE POLICY "Users can update seen_at for their own notifications" ON "public"."notifications" FOR UPDATE TO "authenticated" USING (("auth"."uid"() = "user_id")) WITH CHECK ((("auth"."uid"() = "user_id") AND (NOT ("seen_at" IS DISTINCT FROM "seen_at"))));
CREATE POLICY "Users can update their own friend requests" ON "public"."friends" FOR UPDATE USING ((("auth"."uid"() = "friend_id") AND ("status" = 'pending'::"text"))) WITH CHECK (("status" = ANY (ARRAY['accepted'::"text", 'declined'::"text"])));
CREATE POLICY "Users can update their own notifications" ON "public"."notifications" FOR UPDATE USING (("auth"."uid"() = "user_id"));
CREATE POLICY "Users can update their own profile" ON "public"."profiles" FOR UPDATE TO "authenticated" USING (("auth"."uid"() = "id"));
CREATE POLICY "Users can view chat_users for chats they are in" ON "public"."chat_users" FOR SELECT USING ((EXISTS ( SELECT 1
CREATE POLICY "Users can view file attachments in chats they participate in" ON "public"."file_attachments" FOR SELECT USING ((EXISTS ( SELECT 1
CREATE POLICY "Users can view invitations they've sent or received" ON "public"."chat_invitations" FOR SELECT USING ((("inviting_user_id" = "auth"."uid"()) OR ("invited_user_id" = "auth"."uid"())));
CREATE POLICY "Users can view their own friend relationships" ON "public"."friends" FOR SELECT USING ((("auth"."uid"() = "user_id") OR ("auth"."uid"() = "friend_id")));
CREATE POLICY "Users can view their own notifications" ON "public"."notifications" FOR SELECT TO "authenticated" USING (("auth"."uid"() = "user_id"));
ALTER TABLE "public"."anonymous_chat_users" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "public"."anonymous_chats" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "public"."anonymous_messages" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "public"."chat_invitations" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "public"."chat_participants" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "public"."chat_users" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "public"."chats" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "public"."file_attachments" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "public"."friends" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "public"."messages" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "public"."notifications" ENABLE ROW LEVEL SECURITY;
ALTER TABLE "public"."profiles" ENABLE ROW LEVEL SECURITY;
ALTER PUBLICATION "supabase_realtime" OWNER TO "postgres";
COMMENT ON PUBLICATION "supabase_realtime" IS 'Configures replication for real-time features.';
ALTER PUBLICATION "supabase_realtime" ADD TABLE ONLY "public"."anonymous_chats";
ALTER PUBLICATION "supabase_realtime" ADD TABLE ONLY "public"."anonymous_messages";
ALTER PUBLICATION "supabase_realtime" ADD TABLE ONLY "public"."chat_invitations";
ALTER PUBLICATION "supabase_realtime" ADD TABLE ONLY "public"."chat_participants";
ALTER PUBLICATION "supabase_realtime" ADD TABLE ONLY "public"."chats";
ALTER PUBLICATION "supabase_realtime" ADD TABLE ONLY "public"."file_attachments";
ALTER PUBLICATION "supabase_realtime" ADD TABLE ONLY "public"."friends";
ALTER PUBLICATION "supabase_realtime" ADD TABLE ONLY "public"."messages";
ALTER PUBLICATION "supabase_realtime" ADD TABLE ONLY "public"."notifications";
ALTER PUBLICATION "supabase_realtime" ADD TABLE ONLY "public"."profiles";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES  TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES  TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES  TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES  TO "service_role";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS  TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS  TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS  TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS  TO "service_role";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES  TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES  TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES  TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES  TO "service_role";
SET session_replication_role = replica;
SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;
SELECT pg_catalog.setval('"auth"."refresh_tokens_id_seq"', 752, true);
