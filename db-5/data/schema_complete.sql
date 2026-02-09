
CREATE TABLE IF NOT EXISTS chats (
    id VARCHAR(255) PRIMARY KEY,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by VARCHAR(255)
);
CREATE TABLE IF NOT EXISTS "public"."anonymous_chat_users" (
    "id" "uuid" DEFAULT "extensions"."uuid_generate_v4"() NOT NULL,
    "chat_id" "uuid",
    "display_name" "text" NOT NULL,
    "guest_id" "uuid" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL
);
CREATE TABLE IF NOT EXISTS "public"."anonymous_chats" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "join_code" "text" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL
);
CREATE TABLE IF NOT EXISTS "public"."anonymous_messages" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "chat_id" "uuid" NOT NULL,
    "sender_display_name" "text" NOT NULL,
    "content" "text" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "is_ai" boolean DEFAULT false NOT NULL,
    "ai_character_id" "text" DEFAULT 'default-ai'::"text"
);
CREATE TABLE IF NOT EXISTS "public"."chat_invitations" (
    "id" "uuid" DEFAULT "extensions"."uuid_generate_v4"() NOT NULL,
    "chat_id" "uuid" NOT NULL,
    "inviting_user_id" "uuid",
    "invited_user_id" "uuid",
    "status" "text" DEFAULT 'pending'::"text",
    "created_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()),
    "updated_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()),
    "expires_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", ("now"() + '7 days'::interval)),
    CONSTRAINT "chat_invitations_status_check" CHECK (("status" = ANY (ARRAY['pending'::"text", 'accepted'::"text", 'rejected'::"text", 'declined'::"text", 'expired'::"text"])))
);
CREATE TABLE IF NOT EXISTS "public"."chat_participants" (
    "chat_id" "uuid" NOT NULL,
    "user_id" "uuid" NOT NULL,
    "joined_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"())
);
CREATE TABLE IF NOT EXISTS "public"."chat_users" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "chat_id" "uuid" NOT NULL,
    "user_id" "uuid" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"()
);
CREATE TABLE IF NOT EXISTS "public"."chats" (
    "id" "uuid" DEFAULT "extensions"."uuid_generate_v4"() NOT NULL,
    "title" "text",
    "created_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL,
    "current_ai_character_id" "text",
    "created_by" "uuid" NOT NULL
);
CREATE TABLE IF NOT EXISTS "public"."file_attachments" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "message_id" "uuid",
    "chat_id" "uuid",
    "user_id" "uuid",
    "file_name" "text" NOT NULL,
    "file_size" integer NOT NULL,
    "file_type" "text" NOT NULL,
    "file_path" "text" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL
);
CREATE TABLE IF NOT EXISTS "public"."friends" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "user_id" "uuid" NOT NULL,
    "friend_id" "uuid" NOT NULL,
    "status" "text" DEFAULT 'pending'::"text",
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    CONSTRAINT "friends_status_check" CHECK (("status" = ANY (ARRAY['pending'::"text", 'accepted'::"text", 'declined'::"text"])))
);
CREATE TABLE IF NOT EXISTS "public"."messages" (
    "id" "uuid" DEFAULT "extensions"."uuid_generate_v4"() NOT NULL,
    "chat_id" "uuid" NOT NULL,
    "sender_id" "uuid",
    "content" "text" NOT NULL,
    "is_ai" boolean DEFAULT false,
    "ai_character_id" "text",
    "created_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()) NOT NULL,
    "deleted_at" timestamp with time zone,
    "mentioned_users" "text"[],
    "is_system_message" boolean DEFAULT false NOT NULL,
    "mentions_data" "jsonb" DEFAULT '[]'::"jsonb"
);
CREATE TABLE IF NOT EXISTS "public"."notifications" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "user_id" "uuid" NOT NULL,
    "type" "text" NOT NULL,
    "title" "text" NOT NULL,
    "message" "text" NOT NULL,
    "data" "jsonb",
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "read" boolean DEFAULT false NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"(),
    "seen_at" timestamp with time zone,
    CONSTRAINT "notifications_type_check" CHECK (("type" = ANY (ARRAY['friend_request'::"text", 'mention'::"text", 'chat_invite'::"text"])))
);
CREATE TABLE IF NOT EXISTS "public"."profiles" (
    "id" "uuid" NOT NULL,
    "username" "text",
    "display_name" "text",
    "avatar_url" "text",
    "created_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()),
    "updated_at" timestamp with time zone DEFAULT "timezone"('utc'::"text", "now"()),
    "ai_character_id" "text",
    "user_role" "public"."user_role" DEFAULT 'user'::"public"."user_role",
    "email" "text",
    "bio" "text",
    "last_username_changed_at" timestamp with time zone,
    "prompt_username_setup" boolean DEFAULT false NOT NULL
);