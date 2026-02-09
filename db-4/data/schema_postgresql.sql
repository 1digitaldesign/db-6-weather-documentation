-- PostgreSQL-compatible schema for db-4
-- Production schema extracted from database dump
SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;
CREATE SCHEMA auth;
CREATE SCHEMA extensions;
CREATE SCHEMA graphql;
CREATE SCHEMA graphql_public;
CREATE SCHEMA pgbouncer;
COMMENT ON SCHEMA public IS '';
CREATE SCHEMA realtime;
CREATE SCHEMA storage;
CREATE SCHEMA vault;
CREATE EXTENSION IF NOT EXISTS pg_graphql WITH SCHEMA graphql;
COMMENT ON EXTENSION pg_graphql IS 'pg_graphql: GraphQL support';
CREATE EXTENSION IF NOT EXISTS pg_stat_statements WITH SCHEMA extensions;
COMMENT ON EXTENSION pg_stat_statements IS 'track planning and execution statistics of all SQL statements executed';
CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA extensions;
COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';
CREATE EXTENSION IF NOT EXISTS supabase_vault WITH SCHEMA vault;
COMMENT ON EXTENSION supabase_vault IS 'Supabase Vault Extension';
CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA extensions;
COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';
CREATE TYPE auth.aal_level AS ENUM (
CREATE TYPE auth.code_challenge_method AS ENUM (
CREATE TYPE auth.factor_status AS ENUM (
CREATE TYPE auth.factor_type AS ENUM (
CREATE TYPE auth.oauth_authorization_status AS ENUM (
CREATE TYPE auth.oauth_client_type AS ENUM (
CREATE TYPE auth.oauth_registration_type AS ENUM (
CREATE TYPE auth.oauth_response_type AS ENUM (
CREATE TYPE auth.one_time_token_type AS ENUM (
CREATE TYPE realtime.action AS ENUM (
CREATE TYPE realtime.equality_op AS ENUM (
CREATE TYPE realtime.user_defined_filter AS (
CREATE TYPE realtime.wal_column AS (
CREATE TYPE realtime.wal_rls AS (
CREATE TYPE storage.buckettype AS ENUM (
CREATE FUNCTION auth.email() RETURNS text
COMMENT ON FUNCTION auth.email() IS 'Deprecated. Use auth.jwt() -> ''email'' instead.';
CREATE FUNCTION auth.jwt() RETURNS jsonb
CREATE FUNCTION auth.role() RETURNS text
COMMENT ON FUNCTION auth.role() IS 'Deprecated. Use auth.jwt() -> ''role'' instead.';
CREATE FUNCTION auth.uid() RETURNS uuid
COMMENT ON FUNCTION auth.uid() IS 'Deprecated. Use auth.jwt() -> ''sub'' instead.';
CREATE FUNCTION extensions.grant_pg_cron_access() RETURNS event_trigger
COMMENT ON FUNCTION extensions.grant_pg_cron_access() IS 'Grants access to pg_cron';
CREATE FUNCTION extensions.grant_pg_graphql_access() RETURNS event_trigger
COMMENT ON FUNCTION extensions.grant_pg_graphql_access() IS 'Grants access to pg_graphql';
CREATE FUNCTION extensions.grant_pg_net_access() RETURNS event_trigger
COMMENT ON FUNCTION extensions.grant_pg_net_access() IS 'Grants access to pg_net';
CREATE FUNCTION extensions.pgrst_ddl_watch() RETURNS event_trigger
CREATE FUNCTION extensions.pgrst_drop_watch() RETURNS event_trigger
CREATE FUNCTION extensions.set_graphql_placeholder() RETURNS event_trigger
COMMENT ON FUNCTION extensions.set_graphql_placeholder() IS 'Reintroduces placeholder function for graphql_public.graphql';
CREATE FUNCTION pgbouncer.get_auth(p_usename text) RETURNS TABLE(username text, password text)
CREATE FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer DEFAULT (1024 * 1024)) RETURNS SETOF realtime.wal_rls
CREATE FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text DEFAULT 'ROW'::text) RETURNS void
CREATE FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) RETURNS text
CREATE FUNCTION realtime."cast"(val text, type_ regtype) RETURNS jsonb
CREATE FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) RETURNS boolean
CREATE FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) RETURNS boolean
CREATE FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) RETURNS SETOF realtime.wal_rls
CREATE FUNCTION realtime.quote_wal2json(entity regclass) RETURNS text
CREATE FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean DEFAULT true) RETURNS void
CREATE FUNCTION realtime.subscription_check_filters() RETURNS trigger
CREATE FUNCTION realtime.to_regrole(role_name text) RETURNS regrole
CREATE FUNCTION realtime.topic() RETURNS text
CREATE FUNCTION storage.add_prefixes(_bucket_id text, _name text) RETURNS void
CREATE FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) RETURNS void
CREATE FUNCTION storage.delete_leaf_prefixes(bucket_ids text[], names text[]) RETURNS void
CREATE FUNCTION storage.delete_prefix(_bucket_id text, _name text) RETURNS boolean
CREATE FUNCTION storage.delete_prefix_hierarchy_trigger() RETURNS trigger
CREATE FUNCTION storage.enforce_bucket_name_length() RETURNS trigger
CREATE FUNCTION storage.extension(name text) RETURNS text
CREATE FUNCTION storage.filename(name text) RETURNS text
CREATE FUNCTION storage.foldername(name text) RETURNS text[]
CREATE FUNCTION storage.get_level(name text) RETURNS integer
CREATE FUNCTION storage.get_prefix(name text) RETURNS text
CREATE FUNCTION storage.get_prefixes(name text) RETURNS text[]
CREATE FUNCTION storage.get_size_by_bucket() RETURNS TABLE(size bigint, bucket_id text)
CREATE FUNCTION storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, next_key_token text DEFAULT ''::text, next_upload_token text DEFAULT ''::text) RETURNS TABLE(key text, id text, created_at timestamp with time zone)
CREATE FUNCTION storage.list_objects_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, start_after text DEFAULT ''::text, next_token text DEFAULT ''::text) RETURNS TABLE(name text, id uuid, metadata jsonb, updated_at timestamp with time zone)
CREATE FUNCTION storage.lock_top_prefixes(bucket_ids text[], names text[]) RETURNS void
CREATE FUNCTION storage.objects_delete_cleanup() RETURNS trigger
CREATE FUNCTION storage.objects_insert_prefix_trigger() RETURNS trigger
CREATE FUNCTION storage.objects_update_cleanup() RETURNS trigger
CREATE FUNCTION storage.objects_update_level_trigger() RETURNS trigger
CREATE FUNCTION storage.objects_update_prefix_trigger() RETURNS trigger
CREATE FUNCTION storage.operation() RETURNS text
CREATE FUNCTION storage.prefixes_delete_cleanup() RETURNS trigger
CREATE FUNCTION storage.prefixes_insert_trigger() RETURNS trigger
CREATE FUNCTION storage.search(prefix text, bucketname text, limits integer DEFAULT 100, levels integer DEFAULT 1, offsets integer DEFAULT 0, search text DEFAULT ''::text, sortcolumn text DEFAULT 'name'::text, sortorder text DEFAULT 'asc'::text) RETURNS TABLE(name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
CREATE FUNCTION storage.search_legacy_v1(prefix text, bucketname text, limits integer DEFAULT 100, levels integer DEFAULT 1, offsets integer DEFAULT 0, search text DEFAULT ''::text, sortcolumn text DEFAULT 'name'::text, sortorder text DEFAULT 'asc'::text) RETURNS TABLE(name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
CREATE FUNCTION storage.search_v1_optimised(prefix text, bucketname text, limits integer DEFAULT 100, levels integer DEFAULT 1, offsets integer DEFAULT 0, search text DEFAULT ''::text, sortcolumn text DEFAULT 'name'::text, sortorder text DEFAULT 'asc'::text) RETURNS TABLE(name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
CREATE FUNCTION storage.search_v2(prefix text, bucket_name text, limits integer DEFAULT 100, levels integer DEFAULT 1, start_after text DEFAULT ''::text, sort_order text DEFAULT 'asc'::text, sort_column text DEFAULT 'name'::text, sort_column_after text DEFAULT ''::text) RETURNS TABLE(key text, name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
CREATE FUNCTION storage.update_updated_at_column() RETURNS trigger
SET default_tablespace = '';
SET default_table_access_method = heap;
CREATE TABLE auth.audit_log_entries (
COMMENT ON TABLE auth.audit_log_entries IS 'Auth: Audit trail for user actions.';
CREATE TABLE auth.flow_state (
COMMENT ON TABLE auth.flow_state IS 'stores metadata for pkce logins';
CREATE TABLE auth.identities (
COMMENT ON TABLE auth.identities IS 'Auth: Stores identities associated to a user.';
COMMENT ON COLUMN auth.identities.email IS 'Auth: Email is a generated column that references the optional email property in the identity_data';
CREATE TABLE auth.instances (
COMMENT ON TABLE auth.instances IS 'Auth: Manages users across multiple sites.';
CREATE TABLE auth.mfa_amr_claims (
COMMENT ON TABLE auth.mfa_amr_claims IS 'auth: stores authenticator method reference claims for multi factor authentication';
CREATE TABLE auth.mfa_challenges (
COMMENT ON TABLE auth.mfa_challenges IS 'auth: stores metadata about challenge requests made';
CREATE TABLE auth.mfa_factors (
COMMENT ON TABLE auth.mfa_factors IS 'auth: stores metadata about factors';
COMMENT ON COLUMN auth.mfa_factors.last_webauthn_challenge_data IS 'Stores the latest WebAuthn challenge data including attestation/assertion for customer verification';
CREATE TABLE auth.oauth_authorizations (
CREATE TABLE auth.oauth_client_states (
COMMENT ON TABLE auth.oauth_client_states IS 'Stores OAuth states for third-party provider authentication flows where Supabase acts as the OAuth client.';
CREATE TABLE auth.oauth_clients (
CREATE TABLE auth.oauth_consents (
CREATE TABLE auth.one_time_tokens (
CREATE TABLE auth.refresh_tokens (
COMMENT ON TABLE auth.refresh_tokens IS 'Auth: Store of tokens used to refresh JWT tokens once they expire.';
CREATE SEQUENCE auth.refresh_tokens_id_seq
ALTER SEQUENCE auth.refresh_tokens_id_seq OWNED BY auth.refresh_tokens.id;
CREATE TABLE auth.saml_providers (
COMMENT ON TABLE auth.saml_providers IS 'Auth: Manages SAML Identity Provider connections.';
CREATE TABLE auth.saml_relay_states (
COMMENT ON TABLE auth.saml_relay_states IS 'Auth: Contains SAML Relay State information for each Service Provider initiated login.';
CREATE TABLE auth.schema_migrations (
COMMENT ON TABLE auth.schema_migrations IS 'Auth: Manages updates to the auth system.';
CREATE TABLE auth.sessions (
COMMENT ON TABLE auth.sessions IS 'Auth: Stores session data associated to a user.';
COMMENT ON COLUMN auth.sessions.not_after IS 'Auth: Not after is a nullable column that contains a timestamp after which the session should be regarded as expired.';
COMMENT ON COLUMN auth.sessions.refresh_token_hmac_key IS 'Holds a HMAC-SHA256 key used to sign refresh tokens for this session.';
COMMENT ON COLUMN auth.sessions.refresh_token_counter IS 'Holds the ID (counter) of the last issued refresh token.';
CREATE TABLE auth.sso_domains (
COMMENT ON TABLE auth.sso_domains IS 'Auth: Manages SSO email address domain mapping to an SSO Identity Provider.';
CREATE TABLE auth.sso_providers (
COMMENT ON TABLE auth.sso_providers IS 'Auth: Manages SSO identity provider information; see saml_providers for SAML.';
COMMENT ON COLUMN auth.sso_providers.resource_id IS 'Auth: Uniquely identifies a SSO provider according to a user-chosen resource ID (case insensitive), useful in infrastructure as code.';
CREATE TABLE auth.users (
COMMENT ON TABLE auth.users IS 'Auth: Stores user login data within a secure schema.';
COMMENT ON COLUMN auth.users.is_sso_user IS 'Auth: Set this column to true when the account comes from SSO. These accounts can have duplicate emails.';
CREATE TABLE public.account_emailaddress (
ALTER TABLE public.account_emailaddress ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
CREATE TABLE public.account_emailconfirmation (
ALTER TABLE public.account_emailconfirmation ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
CREATE TABLE public.auth_group (
ALTER TABLE public.auth_group ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
CREATE TABLE public.auth_group_permissions (
ALTER TABLE public.auth_group_permissions ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
CREATE TABLE public.auth_permission (
ALTER TABLE public.auth_permission ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
CREATE TABLE public.authtoken_token (
CREATE TABLE public.django_admin_log (
ALTER TABLE public.django_admin_log ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
CREATE TABLE public.django_content_type (
ALTER TABLE public.django_content_type ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
CREATE TABLE public.django_migrations (
ALTER TABLE public.django_migrations ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
CREATE TABLE public.django_session (
CREATE TABLE public.django_site (
ALTER TABLE public.django_site ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
CREATE TABLE public.seydam_contactus (
ALTER TABLE public.seydam_contactus ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
CREATE TABLE public.seydam_customuser (
CREATE TABLE public.seydam_customuser_groups (
ALTER TABLE public.seydam_customuser_groups ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
ALTER TABLE public.seydam_customuser ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
CREATE TABLE public.seydam_customuser_user_permissions (
ALTER TABLE public.seydam_customuser_user_permissions ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
CREATE TABLE public.seydam_emailotp (
ALTER TABLE public.seydam_emailotp ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
CREATE TABLE public.seydam_jsonreport (
ALTER TABLE public.seydam_jsonreport ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
CREATE TABLE public.seydam_outline (
ALTER TABLE public.seydam_outline ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
CREATE TABLE public.seydam_payment (
ALTER TABLE public.seydam_payment ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
CREATE TABLE public.seydam_rawhtmlcode (
ALTER TABLE public.seydam_rawhtmlcode ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
CREATE TABLE public.seydam_referencejobid (
ALTER TABLE public.seydam_referencejobid ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
CREATE TABLE public.seydam_references (
ALTER TABLE public.seydam_references ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
CREATE TABLE public.seydam_reportdirectory (
ALTER TABLE public.seydam_reportdirectory ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
CREATE TABLE public.seydam_reportjobid (
ALTER TABLE public.seydam_reportjobid ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
CREATE TABLE public.seydam_reports (
CREATE TABLE public.seydam_surveyresponse (
ALTER TABLE public.seydam_surveyresponse ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
CREATE TABLE public.seydam_tokenusage (
ALTER TABLE public.seydam_tokenusage ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
CREATE TABLE public.seydam_uploadedimage (
ALTER TABLE public.seydam_uploadedimage ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
CREATE TABLE public.seydam_waitlist (
ALTER TABLE public.seydam_waitlist ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
CREATE TABLE public.socialaccount_socialaccount (
ALTER TABLE public.socialaccount_socialaccount ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
CREATE TABLE public.socialaccount_socialapp (
ALTER TABLE public.socialaccount_socialapp ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
CREATE TABLE public.socialaccount_socialapp_sites (
ALTER TABLE public.socialaccount_socialapp_sites ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
CREATE TABLE public.socialaccount_socialtoken (
ALTER TABLE public.socialaccount_socialtoken ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
CREATE TABLE realtime.messages (
CREATE TABLE realtime.schema_migrations (
CREATE TABLE realtime.subscription (
ALTER TABLE realtime.subscription ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
CREATE TABLE storage.buckets (
COMMENT ON COLUMN storage.buckets.owner IS 'Field is deprecated, use owner_id instead';
CREATE TABLE storage.buckets_analytics (
CREATE TABLE storage.buckets_vectors (
CREATE TABLE storage.migrations (
CREATE TABLE storage.objects (
COMMENT ON COLUMN storage.objects.owner IS 'Field is deprecated, use owner_id instead';
CREATE TABLE storage.prefixes (
CREATE TABLE storage.s3_multipart_uploads (
CREATE TABLE storage.s3_multipart_uploads_parts (
CREATE TABLE storage.vector_indexes (
ALTER TABLE ONLY auth.refresh_tokens ALTER COLUMN id SET DEFAULT nextval('auth.refresh_tokens_id_seq'::regclass);
SELECT pg_catalog.setval('auth.refresh_tokens_id_seq', 1, false);
SELECT pg_catalog.setval('public.account_emailaddress_id_seq', 1, false);
SELECT pg_catalog.setval('public.account_emailconfirmation_id_seq', 1, false);
SELECT pg_catalog.setval('public.auth_group_id_seq', 1, false);
SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);
SELECT pg_catalog.setval('public.auth_permission_id_seq', 116, true);
SELECT pg_catalog.setval('public.django_admin_log_id_seq', 1, false);
SELECT pg_catalog.setval('public.django_content_type_id_seq', 29, true);
SELECT pg_catalog.setval('public.django_migrations_id_seq', 38, true);
SELECT pg_catalog.setval('public.django_site_id_seq', 1, true);
SELECT pg_catalog.setval('public.seydam_contactus_id_seq', 1, false);
SELECT pg_catalog.setval('public.seydam_customuser_groups_id_seq', 1, false);
SELECT pg_catalog.setval('public.seydam_customuser_id_seq', 94, true);
SELECT pg_catalog.setval('public.seydam_customuser_user_permissions_id_seq', 1, false);
SELECT pg_catalog.setval('public.seydam_emailotp_id_seq', 102, true);
SELECT pg_catalog.setval('public.seydam_jsonreport_id_seq', 65, true);
SELECT pg_catalog.setval('public.seydam_outline_id_seq', 71, true);
SELECT pg_catalog.setval('public.seydam_payment_id_seq', 1, false);
SELECT pg_catalog.setval('public.seydam_rawhtmlcode_id_seq', 62, true);
SELECT pg_catalog.setval('public.seydam_referencejobid_id_seq', 69, true);
SELECT pg_catalog.setval('public.seydam_references_id_seq', 69, true);
SELECT pg_catalog.setval('public.seydam_reportdirectory_id_seq', 1, false);
SELECT pg_catalog.setval('public.seydam_reportjobid_id_seq', 65, true);
SELECT pg_catalog.setval('public.seydam_surveyresponse_id_seq', 4, true);
SELECT pg_catalog.setval('public.seydam_tokenusage_id_seq', 1, false);
SELECT pg_catalog.setval('public.seydam_uploadedimage_id_seq', 1, false);
SELECT pg_catalog.setval('public.seydam_waitlist_id_seq', 1, false);
SELECT pg_catalog.setval('public.socialaccount_socialaccount_id_seq', 1, false);
SELECT pg_catalog.setval('public.socialaccount_socialapp_id_seq', 1, false);
SELECT pg_catalog.setval('public.socialaccount_socialapp_sites_id_seq', 1, false);
SELECT pg_catalog.setval('public.socialaccount_socialtoken_id_seq', 1, false);
SELECT pg_catalog.setval('realtime.subscription_id_seq', 1, false);
ALTER TABLE ONLY auth.mfa_amr_claims
ALTER TABLE ONLY auth.audit_log_entries
ALTER TABLE ONLY auth.flow_state
ALTER TABLE ONLY auth.identities
ALTER TABLE ONLY auth.identities
ALTER TABLE ONLY auth.instances
ALTER TABLE ONLY auth.mfa_amr_claims
ALTER TABLE ONLY auth.mfa_challenges
ALTER TABLE ONLY auth.mfa_factors
ALTER TABLE ONLY auth.mfa_factors
ALTER TABLE ONLY auth.oauth_authorizations
ALTER TABLE ONLY auth.oauth_authorizations
ALTER TABLE ONLY auth.oauth_authorizations
ALTER TABLE ONLY auth.oauth_client_states
ALTER TABLE ONLY auth.oauth_clients
ALTER TABLE ONLY auth.oauth_consents
ALTER TABLE ONLY auth.oauth_consents
ALTER TABLE ONLY auth.one_time_tokens
ALTER TABLE ONLY auth.refresh_tokens
ALTER TABLE ONLY auth.refresh_tokens
ALTER TABLE ONLY auth.saml_providers
ALTER TABLE ONLY auth.saml_providers
ALTER TABLE ONLY auth.saml_relay_states
ALTER TABLE ONLY auth.schema_migrations
ALTER TABLE ONLY auth.sessions
ALTER TABLE ONLY auth.sso_domains
ALTER TABLE ONLY auth.sso_providers
ALTER TABLE ONLY auth.users
ALTER TABLE ONLY auth.users
ALTER TABLE ONLY public.account_emailaddress
ALTER TABLE ONLY public.account_emailaddress
ALTER TABLE ONLY public.account_emailconfirmation
ALTER TABLE ONLY public.account_emailconfirmation
ALTER TABLE ONLY public.auth_group
ALTER TABLE ONLY public.auth_group_permissions
ALTER TABLE ONLY public.auth_group_permissions
ALTER TABLE ONLY public.auth_group
ALTER TABLE ONLY public.auth_permission
ALTER TABLE ONLY public.auth_permission
ALTER TABLE ONLY public.authtoken_token
ALTER TABLE ONLY public.authtoken_token
ALTER TABLE ONLY public.django_admin_log
ALTER TABLE ONLY public.django_content_type
ALTER TABLE ONLY public.django_content_type
ALTER TABLE ONLY public.django_migrations
ALTER TABLE ONLY public.django_session
ALTER TABLE ONLY public.django_site
ALTER TABLE ONLY public.django_site
ALTER TABLE ONLY public.seydam_contactus
ALTER TABLE ONLY public.seydam_customuser
ALTER TABLE ONLY public.seydam_customuser_groups
ALTER TABLE ONLY public.seydam_customuser_groups
ALTER TABLE ONLY public.seydam_customuser
ALTER TABLE ONLY public.seydam_customuser_user_permissions
ALTER TABLE ONLY public.seydam_customuser_user_permissions
ALTER TABLE ONLY public.seydam_emailotp
ALTER TABLE ONLY public.seydam_jsonreport
ALTER TABLE ONLY public.seydam_outline
ALTER TABLE ONLY public.seydam_payment
ALTER TABLE ONLY public.seydam_payment
ALTER TABLE ONLY public.seydam_rawhtmlcode
ALTER TABLE ONLY public.seydam_rawhtmlcode
ALTER TABLE ONLY public.seydam_referencejobid
ALTER TABLE ONLY public.seydam_references
ALTER TABLE ONLY public.seydam_reportdirectory
ALTER TABLE ONLY public.seydam_reportjobid
ALTER TABLE ONLY public.seydam_reports
ALTER TABLE ONLY public.seydam_surveyresponse
ALTER TABLE ONLY public.seydam_tokenusage
ALTER TABLE ONLY public.seydam_uploadedimage
ALTER TABLE ONLY public.seydam_waitlist
ALTER TABLE ONLY public.socialaccount_socialaccount
ALTER TABLE ONLY public.socialaccount_socialaccount
ALTER TABLE ONLY public.socialaccount_socialapp_sites
ALTER TABLE ONLY public.socialaccount_socialapp
ALTER TABLE ONLY public.socialaccount_socialapp_sites
ALTER TABLE ONLY public.socialaccount_socialtoken
ALTER TABLE ONLY public.socialaccount_socialtoken
ALTER TABLE ONLY realtime.messages
ALTER TABLE ONLY realtime.subscription
ALTER TABLE ONLY realtime.schema_migrations
ALTER TABLE ONLY storage.buckets_analytics
ALTER TABLE ONLY storage.buckets
ALTER TABLE ONLY storage.buckets_vectors
ALTER TABLE ONLY storage.migrations
ALTER TABLE ONLY storage.migrations
ALTER TABLE ONLY storage.objects
ALTER TABLE ONLY storage.prefixes
ALTER TABLE ONLY storage.s3_multipart_uploads_parts
ALTER TABLE ONLY storage.s3_multipart_uploads
ALTER TABLE ONLY storage.vector_indexes
CREATE INDEX audit_logs_instance_id_idx ON auth.audit_log_entries USING btree (instance_id);
CREATE UNIQUE INDEX confirmation_token_idx ON auth.users USING btree (confirmation_token) WHERE ((confirmation_token)::text !~ '^[0-9 ]*$'::text);
CREATE UNIQUE INDEX email_change_token_current_idx ON auth.users USING btree (email_change_token_current) WHERE ((email_change_token_current)::text !~ '^[0-9 ]*$'::text);
CREATE UNIQUE INDEX email_change_token_new_idx ON auth.users USING btree (email_change_token_new) WHERE ((email_change_token_new)::text !~ '^[0-9 ]*$'::text);
CREATE INDEX factor_id_created_at_idx ON auth.mfa_factors USING btree (user_id, created_at);
CREATE INDEX flow_state_created_at_idx ON auth.flow_state USING btree (created_at DESC);
CREATE INDEX identities_email_idx ON auth.identities USING btree (email text_pattern_ops);
COMMENT ON INDEX auth.identities_email_idx IS 'Auth: Ensures indexed queries on the email column';
CREATE INDEX identities_user_id_idx ON auth.identities USING btree (user_id);
CREATE INDEX idx_auth_code ON auth.flow_state USING btree (auth_code);
CREATE INDEX idx_oauth_client_states_created_at ON auth.oauth_client_states USING btree (created_at);
CREATE INDEX idx_user_id_auth_method ON auth.flow_state USING btree (user_id, authentication_method);
CREATE INDEX mfa_challenge_created_at_idx ON auth.mfa_challenges USING btree (created_at DESC);
CREATE UNIQUE INDEX mfa_factors_user_friendly_name_unique ON auth.mfa_factors USING btree (friendly_name, user_id) WHERE (TRIM(BOTH FROM friendly_name) <> ''::text);
CREATE INDEX mfa_factors_user_id_idx ON auth.mfa_factors USING btree (user_id);
CREATE INDEX oauth_auth_pending_exp_idx ON auth.oauth_authorizations USING btree (expires_at) WHERE (status = 'pending'::auth.oauth_authorization_status);
CREATE INDEX oauth_clients_deleted_at_idx ON auth.oauth_clients USING btree (deleted_at);
CREATE INDEX oauth_consents_active_client_idx ON auth.oauth_consents USING btree (client_id) WHERE (revoked_at IS NULL);
CREATE INDEX oauth_consents_active_user_client_idx ON auth.oauth_consents USING btree (user_id, client_id) WHERE (revoked_at IS NULL);
CREATE INDEX oauth_consents_user_order_idx ON auth.oauth_consents USING btree (user_id, granted_at DESC);
CREATE INDEX one_time_tokens_relates_to_hash_idx ON auth.one_time_tokens USING hash (relates_to);
CREATE INDEX one_time_tokens_token_hash_hash_idx ON auth.one_time_tokens USING hash (token_hash);
CREATE UNIQUE INDEX one_time_tokens_user_id_token_type_key ON auth.one_time_tokens USING btree (user_id, token_type);
CREATE UNIQUE INDEX reauthentication_token_idx ON auth.users USING btree (reauthentication_token) WHERE ((reauthentication_token)::text !~ '^[0-9 ]*$'::text);
CREATE UNIQUE INDEX recovery_token_idx ON auth.users USING btree (recovery_token) WHERE ((recovery_token)::text !~ '^[0-9 ]*$'::text);
CREATE INDEX refresh_tokens_instance_id_idx ON auth.refresh_tokens USING btree (instance_id);
CREATE INDEX refresh_tokens_instance_id_user_id_idx ON auth.refresh_tokens USING btree (instance_id, user_id);
CREATE INDEX refresh_tokens_parent_idx ON auth.refresh_tokens USING btree (parent);
CREATE INDEX refresh_tokens_session_id_revoked_idx ON auth.refresh_tokens USING btree (session_id, revoked);
CREATE INDEX refresh_tokens_updated_at_idx ON auth.refresh_tokens USING btree (updated_at DESC);
CREATE INDEX saml_providers_sso_provider_id_idx ON auth.saml_providers USING btree (sso_provider_id);
CREATE INDEX saml_relay_states_created_at_idx ON auth.saml_relay_states USING btree (created_at DESC);
CREATE INDEX saml_relay_states_for_email_idx ON auth.saml_relay_states USING btree (for_email);
CREATE INDEX saml_relay_states_sso_provider_id_idx ON auth.saml_relay_states USING btree (sso_provider_id);
CREATE INDEX sessions_not_after_idx ON auth.sessions USING btree (not_after DESC);
CREATE INDEX sessions_oauth_client_id_idx ON auth.sessions USING btree (oauth_client_id);
CREATE INDEX sessions_user_id_idx ON auth.sessions USING btree (user_id);
CREATE UNIQUE INDEX sso_domains_domain_idx ON auth.sso_domains USING btree (lower(domain));
CREATE INDEX sso_domains_sso_provider_id_idx ON auth.sso_domains USING btree (sso_provider_id);
CREATE UNIQUE INDEX sso_providers_resource_id_idx ON auth.sso_providers USING btree (lower(resource_id));
CREATE INDEX sso_providers_resource_id_pattern_idx ON auth.sso_providers USING btree (resource_id text_pattern_ops);
CREATE UNIQUE INDEX unique_phone_factor_per_user ON auth.mfa_factors USING btree (user_id, phone);
CREATE INDEX user_id_created_at_idx ON auth.sessions USING btree (user_id, created_at);
CREATE UNIQUE INDEX users_email_partial_key ON auth.users USING btree (email) WHERE (is_sso_user = false);
COMMENT ON INDEX auth.users_email_partial_key IS 'Auth: A partial unique index that applies only when is_sso_user is false';
CREATE INDEX users_instance_id_email_idx ON auth.users USING btree (instance_id, lower((email)::text));
CREATE INDEX users_instance_id_idx ON auth.users USING btree (instance_id);
CREATE INDEX users_is_anonymous_idx ON auth.users USING btree (is_anonymous);
CREATE INDEX account_emailaddress_upper ON public.account_emailaddress USING btree (upper((email)::text));
CREATE INDEX account_emailaddress_user_id_2c513194 ON public.account_emailaddress USING btree (user_id);
CREATE INDEX account_emailconfirmation_email_address_id_5b7f8c58 ON public.account_emailconfirmation USING btree (email_address_id);
CREATE INDEX account_emailconfirmation_key_f43612bd_like ON public.account_emailconfirmation USING btree (key varchar_pattern_ops);
CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);
CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);
CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);
CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);
CREATE INDEX authtoken_token_key_10f0b77e_like ON public.authtoken_token USING btree (key varchar_pattern_ops);
CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);
CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);
CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);
CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);
CREATE INDEX django_site_domain_a2e37b91_like ON public.django_site USING btree (domain varchar_pattern_ops);
CREATE INDEX seydam_customuser_email_d938def2_like ON public.seydam_customuser USING btree (email varchar_pattern_ops);
CREATE INDEX seydam_customuser_groups_customuser_id_1a696fc3 ON public.seydam_customuser_groups USING btree (customuser_id);
CREATE INDEX seydam_customuser_groups_group_id_6336441b ON public.seydam_customuser_groups USING btree (group_id);
CREATE INDEX seydam_customuser_user_permissions_customuser_id_8a31cce8 ON public.seydam_customuser_user_permissions USING btree (customuser_id);
CREATE INDEX seydam_customuser_user_permissions_permission_id_baf18649 ON public.seydam_customuser_user_permissions USING btree (permission_id);
CREATE INDEX seydam_jsonreport_report_id_65212cab ON public.seydam_jsonreport USING btree (report_id);
CREATE INDEX seydam_jsonreport_user_id_24fd7655 ON public.seydam_jsonreport USING btree (user_id);
CREATE INDEX seydam_outline_report_id_41438c9f ON public.seydam_outline USING btree (report_id);
CREATE INDEX seydam_outline_user_id_813a3400 ON public.seydam_outline USING btree (user_id);
CREATE INDEX seydam_rawhtmlcode_user_id_0bb2cfbd ON public.seydam_rawhtmlcode USING btree (user_id);
CREATE INDEX seydam_referencejobid_report_id_6c0e8f18 ON public.seydam_referencejobid USING btree (report_id);
CREATE INDEX seydam_referencejobid_user_id_c28b9eab ON public.seydam_referencejobid USING btree (user_id);
CREATE INDEX seydam_references_report_id_522083cf ON public.seydam_references USING btree (report_id);
CREATE INDEX seydam_references_user_id_75001af7 ON public.seydam_references USING btree (user_id);
CREATE INDEX seydam_reportdirectory_project_id_cb4c5770 ON public.seydam_reportdirectory USING btree (project_id);
CREATE INDEX seydam_reportdirectory_user_id_d53bd19d ON public.seydam_reportdirectory USING btree (user_id);
CREATE INDEX seydam_reportjobid_report_id_69512e4a ON public.seydam_reportjobid USING btree (report_id);
CREATE INDEX seydam_reportjobid_user_id_11118487 ON public.seydam_reportjobid USING btree (user_id);
CREATE INDEX seydam_reports_user_id_7ac82d67 ON public.seydam_reports USING btree (user_id);
CREATE INDEX seydam_surveyresponse_user_id_f02d4cbc ON public.seydam_surveyresponse USING btree (user_id);
CREATE INDEX seydam_tokenusage_user_id_171cabd4 ON public.seydam_tokenusage USING btree (user_id);
CREATE INDEX seydam_uploadedimage_user_id_1e3a7e3c ON public.seydam_uploadedimage USING btree (user_id);
CREATE INDEX socialaccount_socialaccount_user_id_8146e70c ON public.socialaccount_socialaccount USING btree (user_id);
CREATE INDEX socialaccount_socialapp_sites_site_id_2579dee5 ON public.socialaccount_socialapp_sites USING btree (site_id);
CREATE INDEX socialaccount_socialapp_sites_socialapp_id_97fb6e7d ON public.socialaccount_socialapp_sites USING btree (socialapp_id);
CREATE INDEX socialaccount_socialtoken_account_id_951f210e ON public.socialaccount_socialtoken USING btree (account_id);
CREATE INDEX socialaccount_socialtoken_app_id_636a42d7 ON public.socialaccount_socialtoken USING btree (app_id);
CREATE UNIQUE INDEX unique_verified_email ON public.account_emailaddress USING btree (email) WHERE verified;
CREATE INDEX ix_realtime_subscription_entity ON realtime.subscription USING btree (entity);
CREATE INDEX messages_inserted_at_topic_index ON ONLY realtime.messages USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));
CREATE UNIQUE INDEX subscription_subscription_id_entity_filters_key ON realtime.subscription USING btree (subscription_id, entity, filters);
CREATE UNIQUE INDEX bname ON storage.buckets USING btree (name);
CREATE UNIQUE INDEX bucketid_objname ON storage.objects USING btree (bucket_id, name);
CREATE UNIQUE INDEX buckets_analytics_unique_name_idx ON storage.buckets_analytics USING btree (name) WHERE (deleted_at IS NULL);
CREATE INDEX idx_multipart_uploads_list ON storage.s3_multipart_uploads USING btree (bucket_id, key, created_at);
CREATE UNIQUE INDEX idx_name_bucket_level_unique ON storage.objects USING btree (name COLLATE "C", bucket_id, level);
CREATE INDEX idx_objects_bucket_id_name ON storage.objects USING btree (bucket_id, name COLLATE "C");
CREATE INDEX idx_objects_lower_name ON storage.objects USING btree ((path_tokens[level]), lower(name) text_pattern_ops, bucket_id, level);
CREATE INDEX idx_prefixes_lower_name ON storage.prefixes USING btree (bucket_id, level, ((string_to_array(name, '/'::text))[level]), lower(name) text_pattern_ops);
CREATE INDEX name_prefix_search ON storage.objects USING btree (name text_pattern_ops);
CREATE UNIQUE INDEX objects_bucket_id_level_idx ON storage.objects USING btree (bucket_id, level, name COLLATE "C");
CREATE UNIQUE INDEX vector_indexes_name_bucket_id_idx ON storage.vector_indexes USING btree (name, bucket_id);
CREATE TRIGGER tr_check_filters BEFORE INSERT OR UPDATE ON realtime.subscription FOR EACH ROW EXECUTE FUNCTION realtime.subscription_check_filters();
CREATE TRIGGER enforce_bucket_name_length_trigger BEFORE INSERT OR UPDATE OF name ON storage.buckets FOR EACH ROW EXECUTE FUNCTION storage.enforce_bucket_name_length();
CREATE TRIGGER objects_delete_delete_prefix AFTER DELETE ON storage.objects FOR EACH ROW EXECUTE FUNCTION storage.delete_prefix_hierarchy_trigger();
CREATE TRIGGER objects_insert_create_prefix BEFORE INSERT ON storage.objects FOR EACH ROW EXECUTE FUNCTION storage.objects_insert_prefix_trigger();
CREATE TRIGGER objects_update_create_prefix BEFORE UPDATE ON storage.objects FOR EACH ROW WHEN (((new.name <> old.name) OR (new.bucket_id <> old.bucket_id))) EXECUTE FUNCTION storage.objects_update_prefix_trigger();
CREATE TRIGGER prefixes_create_hierarchy BEFORE INSERT ON storage.prefixes FOR EACH ROW WHEN ((pg_trigger_depth() < 1)) EXECUTE FUNCTION storage.prefixes_insert_trigger();
CREATE TRIGGER prefixes_delete_hierarchy AFTER DELETE ON storage.prefixes FOR EACH ROW EXECUTE FUNCTION storage.delete_prefix_hierarchy_trigger();
CREATE TRIGGER update_objects_updated_at BEFORE UPDATE ON storage.objects FOR EACH ROW EXECUTE FUNCTION storage.update_updated_at_column();
ALTER TABLE ONLY auth.identities
ALTER TABLE ONLY auth.mfa_amr_claims
ALTER TABLE ONLY auth.mfa_challenges
ALTER TABLE ONLY auth.mfa_factors
ALTER TABLE ONLY auth.oauth_authorizations
ALTER TABLE ONLY auth.oauth_authorizations
ALTER TABLE ONLY auth.oauth_consents
ALTER TABLE ONLY auth.oauth_consents
ALTER TABLE ONLY auth.one_time_tokens
ALTER TABLE ONLY auth.refresh_tokens
ALTER TABLE ONLY auth.saml_providers
ALTER TABLE ONLY auth.saml_relay_states
ALTER TABLE ONLY auth.saml_relay_states
ALTER TABLE ONLY auth.sessions
ALTER TABLE ONLY auth.sessions
ALTER TABLE ONLY auth.sso_domains
ALTER TABLE ONLY public.account_emailaddress
ALTER TABLE ONLY public.account_emailconfirmation
ALTER TABLE ONLY public.auth_group_permissions
ALTER TABLE ONLY public.auth_group_permissions
ALTER TABLE ONLY public.auth_permission
ALTER TABLE ONLY public.authtoken_token
ALTER TABLE ONLY public.django_admin_log
ALTER TABLE ONLY public.django_admin_log
ALTER TABLE ONLY public.seydam_customuser_groups
ALTER TABLE ONLY public.seydam_customuser_groups
ALTER TABLE ONLY public.seydam_customuser_user_permissions
ALTER TABLE ONLY public.seydam_customuser_user_permissions
ALTER TABLE ONLY public.seydam_jsonreport
ALTER TABLE ONLY public.seydam_jsonreport
ALTER TABLE ONLY public.seydam_outline
ALTER TABLE ONLY public.seydam_outline
ALTER TABLE ONLY public.seydam_payment
ALTER TABLE ONLY public.seydam_rawhtmlcode
ALTER TABLE ONLY public.seydam_rawhtmlcode
ALTER TABLE ONLY public.seydam_referencejobid
ALTER TABLE ONLY public.seydam_referencejobid
ALTER TABLE ONLY public.seydam_references
ALTER TABLE ONLY public.seydam_references
ALTER TABLE ONLY public.seydam_reportdirectory
ALTER TABLE ONLY public.seydam_reportdirectory
ALTER TABLE ONLY public.seydam_reportjobid
ALTER TABLE ONLY public.seydam_reportjobid
ALTER TABLE ONLY public.seydam_reports
ALTER TABLE ONLY public.seydam_surveyresponse
ALTER TABLE ONLY public.seydam_tokenusage
ALTER TABLE ONLY public.seydam_uploadedimage
ALTER TABLE ONLY public.socialaccount_socialtoken
ALTER TABLE ONLY public.socialaccount_socialtoken
ALTER TABLE ONLY public.socialaccount_socialapp_sites
ALTER TABLE ONLY public.socialaccount_socialapp_sites
ALTER TABLE ONLY public.socialaccount_socialaccount
ALTER TABLE ONLY storage.objects
ALTER TABLE ONLY storage.prefixes
ALTER TABLE ONLY storage.s3_multipart_uploads
ALTER TABLE ONLY storage.s3_multipart_uploads_parts
ALTER TABLE ONLY storage.s3_multipart_uploads_parts
ALTER TABLE ONLY storage.vector_indexes
ALTER TABLE auth.audit_log_entries ENABLE ROW LEVEL SECURITY;
ALTER TABLE auth.flow_state ENABLE ROW LEVEL SECURITY;
ALTER TABLE auth.identities ENABLE ROW LEVEL SECURITY;
ALTER TABLE auth.instances ENABLE ROW LEVEL SECURITY;
ALTER TABLE auth.mfa_amr_claims ENABLE ROW LEVEL SECURITY;
ALTER TABLE auth.mfa_challenges ENABLE ROW LEVEL SECURITY;
ALTER TABLE auth.mfa_factors ENABLE ROW LEVEL SECURITY;
ALTER TABLE auth.one_time_tokens ENABLE ROW LEVEL SECURITY;
ALTER TABLE auth.refresh_tokens ENABLE ROW LEVEL SECURITY;
ALTER TABLE auth.saml_providers ENABLE ROW LEVEL SECURITY;
ALTER TABLE auth.saml_relay_states ENABLE ROW LEVEL SECURITY;
ALTER TABLE auth.schema_migrations ENABLE ROW LEVEL SECURITY;
ALTER TABLE auth.sessions ENABLE ROW LEVEL SECURITY;
ALTER TABLE auth.sso_domains ENABLE ROW LEVEL SECURITY;
ALTER TABLE auth.sso_providers ENABLE ROW LEVEL SECURITY;
ALTER TABLE auth.users ENABLE ROW LEVEL SECURITY;
ALTER TABLE realtime.messages ENABLE ROW LEVEL SECURITY;
ALTER TABLE storage.buckets ENABLE ROW LEVEL SECURITY;
ALTER TABLE storage.buckets_analytics ENABLE ROW LEVEL SECURITY;
ALTER TABLE storage.buckets_vectors ENABLE ROW LEVEL SECURITY;
ALTER TABLE storage.migrations ENABLE ROW LEVEL SECURITY;
ALTER TABLE storage.objects ENABLE ROW LEVEL SECURITY;
ALTER TABLE storage.prefixes ENABLE ROW LEVEL SECURITY;
ALTER TABLE storage.s3_multipart_uploads ENABLE ROW LEVEL SECURITY;
ALTER TABLE storage.s3_multipart_uploads_parts ENABLE ROW LEVEL SECURITY;
ALTER TABLE storage.vector_indexes ENABLE ROW LEVEL SECURITY;
CREATE PUBLICATION supabase_realtime WITH (publish = 'insert, update, delete, truncate');
CREATE EVENT TRIGGER issue_graphql_placeholder ON sql_drop
CREATE EVENT TRIGGER issue_pg_cron_access ON ddl_command_end
CREATE EVENT TRIGGER issue_pg_graphql_access ON ddl_command_end
CREATE EVENT TRIGGER issue_pg_net_access ON ddl_command_end
CREATE EVENT TRIGGER pgrst_ddl_watch ON ddl_command_end
CREATE EVENT TRIGGER pgrst_drop_watch ON sql_drop
