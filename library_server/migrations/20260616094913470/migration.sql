BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "book" (
    "id" bigserial PRIMARY KEY,
    "title" text NOT NULL,
    "author" text NOT NULL,
    "description" text NOT NULL,
    "imageUrl" text,
    "isAvailableOnline" boolean NOT NULL,
    "isAvailableOffline" boolean NOT NULL,
    "pdfUrl" text,
    "categoryId" bigint NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "category" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL
);

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "book"
    ADD CONSTRAINT "book_fk_0"
    FOREIGN KEY("categoryId")
    REFERENCES "category"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR library
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('library', '20260616094913470', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260616094913470', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20260129180959368', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260129180959368', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_idp
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_idp', '20260213194423028', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260213194423028', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_core
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_core', '20260129181112269', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260129181112269', "timestamp" = now();


COMMIT;
