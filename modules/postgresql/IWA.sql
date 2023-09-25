CREATE TABLE "recruiter" (
  "id" uuid PRIMARY KEY,
  "first_name" varchar,
  "last_name" varchar,
  "phone" varchar,
  "email" varchar,
  "companies_siret" integer[],
  "subscription_start" date,
  "subscription_kind" varchar,
  "subscription_duration" integer
);

CREATE TABLE "company" (
  "siret" integer PRIMARY KEY,
  "name" varchar,
  "address" varchar
);

CREATE TABLE "subscription_kind" (
  "level" varchar PRIMARY KEY,
  "price_biyearly" integer,
  "price_yearly" integer,
  "price_monthly" integer,
  "features" integer[]
);

CREATE TABLE "features" (
  "id" integer PRIMARY KEY,
  "name" varchar
);

CREATE TABLE "duration" (
  "id" integer PRIMARY KEY,
  "year" integer,
  "month" integer,
  "week" integer
);

CREATE TABLE "job" (
  "id" uuid PRIMARY KEY,
  "name" varchar,
  "description" text,
  "start_date" date,
  "start_hour" varchar,
  "end_date" date,
  "end_hour" varchar,
  "company_siret" integer,
  "salary" integer,
  "recruiter" uuid,
  "advantages" integer[]
);

CREATE TABLE "advantages" (
  "id" integer PRIMARY KEY,
  "advantage" varchar
);

COMMENT ON COLUMN "job"."start_hour" IS 'hh:mm';

COMMENT ON COLUMN "job"."end_hour" IS 'hh:mm';

COMMENT ON COLUMN "job"."salary" IS 'gross mensual salary';

CREATE TABLE "subscription_kind_features" (
  "subscription_kind_features" integer[],
  "features_id" integer,
  PRIMARY KEY ("subscription_kind_features", "features_id")
);

ALTER TABLE "subscription_kind_features" ADD FOREIGN KEY ("subscription_kind_features") REFERENCES "subscription_kind" ("features");

ALTER TABLE "subscription_kind_features" ADD FOREIGN KEY ("features_id") REFERENCES "features" ("id");


ALTER TABLE "subscription_kind" ADD FOREIGN KEY ("level") REFERENCES "recruiter" ("subscription_kind");

ALTER TABLE "duration" ADD FOREIGN KEY ("id") REFERENCES "recruiter" ("subscription_duration");

CREATE TABLE "recruiter_company" (
  "recruiter_companies_siret" integer[],
  "company_siret" integer,
  PRIMARY KEY ("recruiter_companies_siret", "company_siret")
);

ALTER TABLE "recruiter_company" ADD FOREIGN KEY ("recruiter_companies_siret") REFERENCES "recruiter" ("companies_siret");

ALTER TABLE "recruiter_company" ADD FOREIGN KEY ("company_siret") REFERENCES "company" ("siret");


ALTER TABLE "company" ADD FOREIGN KEY ("siret") REFERENCES "job" ("company_siret");

CREATE TABLE "job_advantages" (
  "job_advantages" integer[],
  "advantages_id" integer,
  PRIMARY KEY ("job_advantages", "advantages_id")
);

ALTER TABLE "job_advantages" ADD FOREIGN KEY ("job_advantages") REFERENCES "job" ("advantages");

ALTER TABLE "job_advantages" ADD FOREIGN KEY ("advantages_id") REFERENCES "advantages" ("id");

