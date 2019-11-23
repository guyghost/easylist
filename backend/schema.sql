--
-- PostgreSQL database dump
--

-- Dumped from database version 11.5 (Debian 11.5-1+deb10u1)
-- Dumped by pg_dump version 11.5 (Debian 11.5-1+deb10u1)

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

--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- Name: get_row(text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_row(par_guid text) RETURNS TABLE(guid text, bearer text, private_key text, installation_token text, session_token text)
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$begin
return query
    select  t.guid
    ,       t.bearer
    ,       t.private_key
    ,       t.installation_token
    ,       t.session_token
    from    tokens t
    where   t.guid = par_guid
;
end$$;


ALTER FUNCTION public.get_row(par_guid text) OWNER TO postgres;

--
-- Name: put_row(text, text, text, text, text); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.put_row(par_guid text, par_bearer text, par_private_key text, par_installation_token text, par_session_token text) RETURNS integer
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$begin
insert into tokens
    (guid, bearer, private_key, installation_token, session_token)
    values (par_guid, par_bearer, par_private_key, par_installation_token, 
            par_session_token)
    on conflict (guid) do
        update set
            bearer = par_bearer,
            private_key = par_private_key,
            installation_token = par_installation_token,
            session_token = par_session_token
;
return 1
;
end$$;


ALTER FUNCTION public.put_row(par_guid text, par_bearer text, par_private_key text, par_installation_token text, par_session_token text) OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: tokens; Type: TABLE; Schema: public; Owner: wessel
--

CREATE TABLE public.tokens (
    id integer NOT NULL,
    guid text NOT NULL,
    bearer text,
    private_key text,
    installation_token text,
    session_token text
);


ALTER TABLE public.tokens OWNER TO wessel;

--
-- Name: tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: wessel
--

CREATE SEQUENCE public.tokens_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tokens_id_seq OWNER TO wessel;

--
-- Name: tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: wessel
--

ALTER SEQUENCE public.tokens_id_seq OWNED BY public.tokens.id;


--
-- Name: tokens id; Type: DEFAULT; Schema: public; Owner: wessel
--

ALTER TABLE ONLY public.tokens ALTER COLUMN id SET DEFAULT nextval('public.tokens_id_seq'::regclass);


--
-- Name: tokens tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: wessel
--

ALTER TABLE ONLY public.tokens
    ADD CONSTRAINT tokens_pkey PRIMARY KEY (guid);


--
-- Name: FUNCTION put_row(par_guid text, par_bearer text, par_private_key text, par_installation_token text, par_session_token text); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.put_row(par_guid text, par_bearer text, par_private_key text, par_installation_token text, par_session_token text) TO backend;


--
-- Name: TABLE tokens; Type: ACL; Schema: public; Owner: wessel
--

REVOKE ALL ON TABLE public.tokens FROM wessel;


--
-- PostgreSQL database dump complete
--

