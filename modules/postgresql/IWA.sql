CREATE TABLE "admin" (
  "id" uuid PRIMARY KEY,
  "username" varchar(64) NOT NULL,
  "email" varchar(128) NOT NULL,
  "photo" bytea,
  "password" varchar NOT NULL
);

CREATE TABLE "gender" (
  "id" serial PRIMARY KEY,
  "name" varchar(16)
);

CREATE TABLE "citizenship" (
  "id" serial PRIMARY KEY,
  "name" varchar(8)
);

CREATE TABLE "country" (
  "id" serial PRIMARY KEY,
  "name" varchar(50)
);

CREATE TABLE "city" (
  "id" serial PRIMARY KEY,
  "name" varchar(50),
  "country" integer
);

CREATE TABLE "address" (
  "id" uuid PRIMARY KEY,
  "num" integer,
  "steet" text NOT NULL,
  "complement" text,
  "zipCode" smallint,
  "city" integer
);

CREATE TABLE "reference" (
  "id" uuid PRIMARY KEY,
  "title" varchar(100) NOT NULL,
  "phone" varchar,
  "email" varchar NOT NULL,
  "candidate" uuid,
  "comapany" integer NOT NULL
);

CREATE TABLE "recruiter" (
  "id" uuid PRIMARY KEY,
  "first_name" varchar NOT NULL,
  "last_name" varchar NOT NULL,
  "phone" varchar,
  "email" varchar UNIQUE NOT NULL,
  "password" varchar
);

CREATE TABLE "availabitiy" (
  "id" serial PRIMARY KEY,
  "job" integer NOT NULL,
  "start" date NOT NULL,
  "end" date
);

CREATE TABLE "candidate" (
  "id" uuid PRIMARY KEY,
  "first_name" varchar NOT NULL,
  "last_name" varchar NOT NULL,
  "gender" integer NOT NULL,
  "citizenship" integer NOT NULL,
  "address" uuid NOT NULL,
  "phone" varchar,
  "email" varchar UNIQUE NOT NULL,
  "photo" bytea,
  "cv" text,
  "bio" text,
  "password" varchar NOT NULL
);

CREATE TABLE "company" (
  "siret" integer PRIMARY KEY,
  "name" varchar,
  "address" uuid
);

CREATE TABLE "tier" (
  "id" serial PRIMARY KEY,
  "level" varchar,
  "price_biyearly" integer,
  "price_yearly" integer,
  "price_monthly" integer
);

CREATE TABLE "feature" (
  "id" integer PRIMARY KEY,
  "name" varchar
);

CREATE TABLE "job_category" (
  "id" serial PRIMARY KEY,
  "name" varchar(100) NOT NULL
);

CREATE TABLE "job" (
  "id" serial PRIMARY KEY,
  "title" varchar,
  "category" integer
);

CREATE TABLE "job_offer" (
  "id" uuid PRIMARY KEY,
  "description" text,
  "start" date,
  "end" date,
  "salary" integer,
  "job" integer NOT NULL,
  "company_recruiter" integer
);

CREATE TABLE "application" (
  "id" uuid PRIMARY KEY,
  "candidate" uuid NOT NULL,
  "job_offer" uuid NOT NULL,
  "review" uuid
);

CREATE TABLE "review" (
  "id" uuid PRIMARY KEY,
  "rating" decimal NOT NULL,
  "message" text,
  "providedAt" date NOT NULL
);

CREATE TABLE "advantage" (
  "id" serial PRIMARY KEY,
  "name" varchar
);

CREATE TABLE "company_recruiter" (
  "id" uuit PRIMARY KEY,
  "company" integer,
  "recruiter" uuid,
  "proof" bytea
);

CREATE TABLE "subscription" (
  "level" integer,
  "recruiter" uuid UNIQUE,
  "begin" date,
  PRIMARY KEY ("recruiter", "level")
);

CREATE UNIQUE INDEX ON "job" ("title", "category");

CREATE UNIQUE INDEX ON "application" ("candidate", "job_offer");

CREATE UNIQUE INDEX ON "company_recruiter" ("company", "recruiter");

COMMENT ON COLUMN "candidate"."cv" IS 'url to the CV';

ALTER TABLE "city" ADD FOREIGN KEY ("country") REFERENCES "country" ("id");

ALTER TABLE "address" ADD FOREIGN KEY ("city") REFERENCES "city" ("id");

ALTER TABLE "reference" ADD FOREIGN KEY ("candidate") REFERENCES "candidate" ("id");

ALTER TABLE "reference" ADD FOREIGN KEY ("comapany") REFERENCES "company" ("siret");

ALTER TABLE "availabitiy" ADD FOREIGN KEY ("job") REFERENCES "job" ("id");

ALTER TABLE "candidate" ADD FOREIGN KEY ("gender") REFERENCES "gender" ("id");

ALTER TABLE "candidate" ADD FOREIGN KEY ("citizenship") REFERENCES "citizenship" ("id");

ALTER TABLE "candidate" ADD FOREIGN KEY ("address") REFERENCES "address" ("id");

ALTER TABLE "company" ADD FOREIGN KEY ("address") REFERENCES "address" ("id");

ALTER TABLE "job" ADD FOREIGN KEY ("category") REFERENCES "job_category" ("id");

ALTER TABLE "job_offer" ADD FOREIGN KEY ("job") REFERENCES "job" ("id");

ALTER TABLE "job_offer" ADD FOREIGN KEY ("company_recruiter") REFERENCES "company_recruiter" ("id");

ALTER TABLE "application" ADD FOREIGN KEY ("candidate") REFERENCES "candidate" ("id");

ALTER TABLE "application" ADD FOREIGN KEY ("job_offer") REFERENCES "job_offer" ("id");

ALTER TABLE "application" ADD FOREIGN KEY ("review") REFERENCES "review" ("id");

ALTER TABLE "company_recruiter" ADD FOREIGN KEY ("company") REFERENCES "company" ("siret");

ALTER TABLE "company_recruiter" ADD FOREIGN KEY ("recruiter") REFERENCES "recruiter" ("id");

ALTER TABLE "subscription" ADD FOREIGN KEY ("level") REFERENCES "tier" ("id");

ALTER TABLE "subscription" ADD FOREIGN KEY ("recruiter") REFERENCES "recruiter" ("id");

CREATE TABLE "availabitiy_city" (
  "availabitiy_id" serial,
  "city_id" serial,
  PRIMARY KEY ("availabitiy_id", "city_id")
);

ALTER TABLE "availabitiy_city" ADD FOREIGN KEY ("availabitiy_id") REFERENCES "availabitiy" ("id");

ALTER TABLE "availabitiy_city" ADD FOREIGN KEY ("city_id") REFERENCES "city" ("id");


CREATE TABLE "job_offer_advantage" (
  "job_offer_id" uuid,
  "advantage_id" serial,
  PRIMARY KEY ("job_offer_id", "advantage_id")
);

ALTER TABLE "job_offer_advantage" ADD FOREIGN KEY ("job_offer_id") REFERENCES "job_offer" ("id");

ALTER TABLE "job_offer_advantage" ADD FOREIGN KEY ("advantage_id") REFERENCES "advantage" ("id");


CREATE TABLE "tier_feature" (
  "tier_id" serial,
  "feature_id" integer,
  PRIMARY KEY ("tier_id", "feature_id")
);

ALTER TABLE "tier_feature" ADD FOREIGN KEY ("tier_id") REFERENCES "tier" ("id");

ALTER TABLE "tier_feature" ADD FOREIGN KEY ("feature_id") REFERENCES "feature" ("id");


CREATE TABLE "candidate_availabitiy" (
  "candidate_id" uuid,
  "availabitiy_id" serial,
  PRIMARY KEY ("candidate_id", "availabitiy_id")
);

ALTER TABLE "candidate_availabitiy" ADD FOREIGN KEY ("candidate_id") REFERENCES "candidate" ("id");

ALTER TABLE "candidate_availabitiy" ADD FOREIGN KEY ("availabitiy_id") REFERENCES "availabitiy" ("id");

