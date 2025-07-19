DROP TABLE IF EXISTS "users";
DROP TABLE IF EXISTS "schools";
DROP TABLE IF EXISTS "companies";
DROP TABLE IF EXISTS "connections";
DROP TABLE IF EXISTS "educations";
DROP TABLE IF EXISTS "works";

CREATE TABLE "users" (
	"id" INTEGER,
	"first_name" TEXT NOT NULL,
	"last_name" TEXT NOT NULL,
	"username" TEXT NOT NULL UNIQUE,
	"password" TEXT NOT NULL,
	PRIMARY KEY("id")
);

CREATE TABLE "schools" (
	"id" INTEGER,
	"name" TEXT NOT NULL UNIQUE,
	"type" TEXT NOT NULL,
	"location" TEXT NOT NULL, 
	"founded_year" INTEGER CHECK ("founded_year" > 0),
	PRIMARY KEY("id")
);

CREATE TABLE "companies" (
	"id" INTEGER,
	"name" TEXT NOT NULL UNIQUE,
	"industry_type" TEXT NOT NULL CHECK("industry_type" IN ("Education", "Technology", "Finance")),
	"location" TEXT NOT NULL,
	PRIMARY KEY("id")
);

CREATE TABLE "connections" (
	"userA_id" INTEGER NOT NULL,
	"userB_id" INTEGER NOT NULL CHECK("userA_id" != "userB_id"),
	PRIMARY KEY("userA_id", "userB_id")
	FOREIGN KEY("userA_id") REFERENCES "users"("id")
	FOREIGN KEY("userB_id") REFERENCES "users"("id")
);

CREATE TABLE "educations" (
	"user_id" INTEGER NOT NULL,
	"school_id" INTEGER NOT NULL,
	"start_date" NUMERIC NOT NULL,
	"end_date" NUMERIC NOT NULL CHECK("end_date" > "start_date"),
	"degree" TEXT NOT NULL CHECK("degree" IN ("BE", "ME", "MS", "PhD")),
	PRIMARY KEY("user_id", "school_id"),
	FOREIGN KEY("user_id") REFERENCES "users"("id"),
	FOREIGN KEY("school_id") REFERENCES "schools"("id")
);

CREATE TABLE "works" (
	"user_id" INTEGER NOT NULL,
	"company_id" INTEGER NOT NULL,
	"start_date" NUMERIC NOT NULL,
	"end_date" NUMERIC NOT NULL CHECK("end_date" > "start_date"),
	"title" TEXT NOT NULL CHECK("title" IN ("Engineer", "Manager", "HR")),
	PRIMARY KEY("user_id", "comapany_id"),
	FOREIGN KEY("user_id") REFERENCES "users"("id"),
	FOREIGN KEY("comapany_id") REFERENCES "companies"("id")
);




