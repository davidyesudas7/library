BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "downloaded_books" (
    "id" bigserial PRIMARY KEY,
    "userName" text NOT NULL,
    "parish" text NOT NULL,
    "email" text,
    "phone" text,
    "bookId" bigint NOT NULL
);

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "downloaded_books"
    ADD CONSTRAINT "downloaded_books_fk_0"
    FOREIGN KEY("bookId")
    REFERENCES "book"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR library
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('library', '20260623094446342', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260623094446342', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20260129180959368', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260129180959368', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_core
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_core', '20260129181112269', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260129181112269', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_idp
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_idp', '20260213194423028', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260213194423028', "timestamp" = now();


COMMIT;
