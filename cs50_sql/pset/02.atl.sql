DROP TABLE "passengers";
DROP TABLE "airlines";
DROP TABLE "flights";
DROP TABLE "check_ins";
CREATE TABLE "passengers" (
    "id" INTEGER,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "age" INTEGER CHECK ("age" > 0),
    PRIMARY KEY("id")
);

CREATE TABLE "airlines" (
    "id" INTEGER,
    "name" TEXT NOT NULL UNIQUE,
    "concourse" TEXT NOT NULL CHECK("concourse" IN ("A", "B", "C", "D", "E", "F", "T")),
    PRIMARY KEY("id")
);
CREATE TABLE "flights" (
    "id" INTEGER,
    "number" INTEGER CHECK ("number" > 0),
    "airline_id" TEXT NOT NULL,
    "departure_airport_id" TEXT NOT NULL,
    "arrival_airport_id" TEXT NOT NULL,
    "departure_time" NUMERIC NOT NULL DEFAULT CURRENT_TIMESTAMP CHECK ("arrival_time" > "departure_time"),
    "arrival_time" NUMERIC NOT NULL DEFAULT CURRENT_TIMESTAMP CHECK("arrival_time" > "departure_time"),
    FOREIGN KEY("airline_id") REFERENCES "airlines"("id"),
    PRIMARY KEY("id")
);
CREATE TABLE "check_ins" (
    "passenger_id" INTEGER,
    "flight_id" INTEGER,
    "check_in_time" NUMERIC NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY("passenger_id") REFERENCES "passengers"("id"),
    FOREIGN KEY("flight_id") REFERENCES "flights"("id"),
    PRIMARY KEY("passenger_id","flight_id")
);