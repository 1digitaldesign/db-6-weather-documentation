-- PostgreSQL-compatible schema for db-1
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
SET default_tablespace = '';
SET default_table_access_method = heap;
CREATE TABLE public.aircraft_real (
CREATE TABLE public.aircraft_sessions_real (
CREATE TABLE public.aircraft_position_history (
CREATE SEQUENCE public.aircraft_position_history_id_seq
ALTER SEQUENCE public.aircraft_position_history_id_seq OWNED BY public.aircraft_position_history.id;
CREATE TABLE public.collision_alerts (
CREATE SEQUENCE public.collision_alerts_id_seq
ALTER SEQUENCE public.collision_alerts_id_seq OWNED BY public.collision_alerts.id;
CREATE TABLE public.risk_assessments (
CREATE SEQUENCE public.risk_assessments_id_seq
ALTER SEQUENCE public.risk_assessments_id_seq OWNED BY public.risk_assessments.id;
ALTER TABLE ONLY public.aircraft_position_history ALTER COLUMN id SET DEFAULT nextval('public.aircraft_position_history_id_seq'::regclass);
ALTER TABLE ONLY public.collision_alerts ALTER COLUMN id SET DEFAULT nextval('public.collision_alerts_id_seq'::regclass);
ALTER TABLE ONLY public.risk_assessments ALTER COLUMN id SET DEFAULT nextval('public.risk_assessments_id_seq'::regclass);
SELECT pg_catalog.setval('public.aircraft_position_history_id_seq', 8764298, true);
SELECT pg_catalog.setval('public.collision_alerts_id_seq', 7570, true);
SELECT pg_catalog.setval('public.risk_assessments_id_seq', 1235, true);
ALTER TABLE ONLY public.aircraft_position_history
ALTER TABLE ONLY public.aircraft_real
ALTER TABLE ONLY public.aircraft_sessions_real
ALTER TABLE ONLY public.collision_alerts
ALTER TABLE ONLY public.risk_assessments
ALTER TABLE ONLY public.collision_alerts
ALTER TABLE ONLY public.risk_assessments
CREATE INDEX idx_aircraft_real_position ON public.aircraft_real USING btree (lat, lon);
CREATE INDEX idx_aircraft_real_receiver ON public.aircraft_real USING btree (receiver_id);
CREATE INDEX idx_aircraft_real_seen_at ON public.aircraft_real USING btree (seen_at);
CREATE INDEX idx_aircraft_sessions_real_active ON public.aircraft_sessions_real USING btree (ended_at) WHERE (ended_at IS NULL);
CREATE INDEX idx_aircraft_sessions_real_times ON public.aircraft_sessions_real USING btree (first_seen, last_seen);
CREATE INDEX idx_collision_alerts_active ON public.collision_alerts USING btree (hex1, hex2, resolved_at) WHERE (resolved_at IS NULL);
CREATE INDEX idx_collision_alerts_detected_at ON public.collision_alerts USING btree (detected_at);
CREATE INDEX idx_history_hex_time ON public.aircraft_position_history USING btree (hex, "timestamp" DESC);
CREATE INDEX idx_history_position ON public.aircraft_position_history USING btree (lat, lon);
CREATE INDEX idx_history_timestamp ON public.aircraft_position_history USING btree ("timestamp");
CREATE INDEX idx_risk_assessments_active ON public.risk_assessments USING btree (hex1, hex2, resolved_at) WHERE (resolved_at IS NULL);
CREATE INDEX idx_risk_assessments_detected_at ON public.risk_assessments USING btree (detected_at);
CREATE INDEX idx_risk_assessments_score ON public.risk_assessments USING btree (risk_score DESC) WHERE (resolved_at IS NULL);
