

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


SET SESSION AUTHORIZATION DEFAULT;

ALTER TABLE public.posts DISABLE TRIGGER ALL;

INSERT INTO public.posts (id, title, body, created_at) VALUES ('4df35dfa-a459-4a03-8fe0-e2f9be80942b', 'Hello World!', 'hello', '2021-06-19 20:34:07.418451+02');
INSERT INTO public.posts (id, title, body, created_at) VALUES ('aaf047ce-a7aa-4b76-a844-739abd03a63c', 'post 2', 'test', '2021-06-19 20:34:07.419089+02');
INSERT INTO public.posts (id, title, body, created_at) VALUES ('70bd8d62-9ffa-4102-bef1-accfb6de32d2', 'latest post', '**hello**

## Headline one

Test', '2021-06-19 20:35:18.17678+02');
INSERT INTO public.posts (id, title, body, created_at) VALUES ('6002d7c9-12df-4ed4-b068-48f3716f5e72', 'invalid', '#', '2021-06-19 20:34:07.419307+02');


ALTER TABLE public.posts ENABLE TRIGGER ALL;


ALTER TABLE public.comments DISABLE TRIGGER ALL;

INSERT INTO public.comments (id, post_id, author, body) VALUES ('81f753dd-1e45-433d-9326-a672c1623f32', '70bd8d62-9ffa-4102-bef1-accfb6de32d2', 'marc', 'hello');
INSERT INTO public.comments (id, post_id, author, body) VALUES ('c64e58a8-5b4f-475a-b88e-cb499cd8b325', '70bd8d62-9ffa-4102-bef1-accfb6de32d2', 'test', 'test');
INSERT INTO public.comments (id, post_id, author, body) VALUES ('38865dca-1173-4b14-a800-86478a58117e', '70bd8d62-9ffa-4102-bef1-accfb6de32d2', 'test', 'test');
INSERT INTO public.comments (id, post_id, author, body) VALUES ('565afb9a-0e93-45c8-b7ca-0397d17e8e65', '70bd8d62-9ffa-4102-bef1-accfb6de32d2', 'marc', 'latest comment');


ALTER TABLE public.comments ENABLE TRIGGER ALL;


