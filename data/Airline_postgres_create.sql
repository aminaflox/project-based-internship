CREATE TABLE public."user" (
	"userID" integer NOT NULL,
	"email" TEXT NOT NULL UNIQUE,
	"password" TEXT NOT NULL,
	"firstName" TEXT NOT NULL,
	"lastName" TEXT NOT NULL,
	"city" TEXT NOT NULL,
	"streetAddrs" TEXT NOT NULL,
	"numberAddrs" TEXT NOT NULL,
	"bdate" DATE NOT NULL,
	"age" integer NOT NULL,
	"gender" varchar(1) NOT NULL,
	"phonenumber" TEXT NOT NULL,
	"salt" TEXT NOT NULL,
	CONSTRAINT "user_pk" PRIMARY KEY ("userID")
) WITH (
  OIDS=FALSE
);



CREATE TABLE public."flight" (
	"flightNO" integer NOT NULL,
	"airline_code" TEXT NOT NULL,
	"journeyID" integer NOT NULL,
	"flightName" TEXT NOT NULL,
	"departureDate" DATE NOT NULL,
	"arrivalDate" DATE NOT NULL,
	"departFrom" TEXT NOT NULL,
	"arriveTo" TEXT NOT NULL,
	CONSTRAINT "flight_pk" PRIMARY KEY ("flightNO")
) WITH (
  OIDS=FALSE
);



CREATE TABLE public."airline" (
	"airlineCode" TEXT NOT NULL,
	"airlineName" TEXT NOT NULL,
	"contactNO" TEXT,
	"city" TEXT NOT NULL,
	"streetAddrs" TEXT NOT NULL,
	"numberAddrs" TEXT,
	CONSTRAINT "airline_pk" PRIMARY KEY ("airlineCode")
) WITH (
  OIDS=FALSE
);



CREATE TABLE public."journey" (
	"journeyID" integer NOT NULL,
	"cost" FLOAT NOT NULL,
	"origin" TEXT NOT NULL,
	"destination" TEXT NOT NULL,
	CONSTRAINT "journey_pk" PRIMARY KEY ("journeyID")
) WITH (
  OIDS=FALSE
);



CREATE TABLE public."airport" (
	"airportID" integer NOT NULL,
	"airportCode" TEXT NOT NULL unique,
	"name" TEXT NOT NULL,
	"country" TEXT NOT NULL,
	"region" TEXT NOT NULL,
	CONSTRAINT "airport_pk" PRIMARY KEY ("airportID")
) WITH (
  OIDS=FALSE
);



CREATE TABLE public."admin" (
	"admin_id" integer NOT NULL,
	CONSTRAINT "admin_pk" PRIMARY KEY ("admin_id")
) WITH (
  OIDS=FALSE
);



CREATE TABLE public."ticket" (
	"ticketID" integer NOT NULL,
	"status" TEXT NOT NULL,
	"fair" FLOAT NOT NULL,
	"seatNO" text NOT NULL unique,
	"class" TEXT NOT NULL,
	CONSTRAINT "ticket_pk" PRIMARY KEY ("ticketID")
) WITH (
  OIDS=FALSE
);



CREATE TABLE public."payment" (
	"paymentID" integer NOT NULL,
	"paydate" DATE NOT NULL,
	"amount" FLOAT NOT NULL,
	CONSTRAINT "payment_pk" PRIMARY KEY ("paymentID")
) WITH (
  OIDS=FALSE
);



CREATE TABLE public."customer" (
	"customerID" integer NOT NULL,
	"paymnet_id" integer NOT NULL,
	CONSTRAINT "customer_pk" PRIMARY KEY ("customerID")
) WITH (
  OIDS=FALSE
);



CREATE TABLE public."passenger" (
	"cusID" integer NOT NULL,
	"fName" TEXT NOT NULL,
	"lName" TEXT NOT NULL,
	"bdate" DATE NOT NULL,
	"age" integer NOT NULL,
	"gender" varchar(1) NOT NULL,
	CONSTRAINT "passenger_pk" PRIMARY KEY ("cusID")
) WITH (
  OIDS=FALSE
);



CREATE TABLE public."book" (
	"bookID" integer NOT NULL,
	"userID" integer NOT NULL,
	"journeyID" integer NOT NULL,
	"bookingDate" DATE NOT NULL,
	CONSTRAINT "book_pk" PRIMARY KEY ("bookID","userID","journeyID")
) WITH (
  OIDS=FALSE
);



CREATE TABLE public."receives" (
	"custID" integer NOT NULL,
	"ticketID" integer NOT NULL,
	CONSTRAINT "receives_pk" PRIMARY KEY ("custID","ticketID")
) WITH (
  OIDS=FALSE
);



CREATE TABLE public."receive" (
	"pay_id" integer NOT NULL,
	"ticketID" integer NOT NULL,
	CONSTRAINT "receive_pk" PRIMARY KEY ("pay_id","ticketID")
) WITH (
  OIDS=FALSE
);



CREATE TABLE public."belongsTo" (
	"flightNO" integer NOT NULL,
	"seat_no" varchar(5) NOT NULL
) WITH (
  OIDS=FALSE
);




ALTER TABLE "flight" ADD CONSTRAINT "flight_fk0" FOREIGN KEY ("airline_code") REFERENCES "airline"("airlineCode");
ALTER TABLE "flight" ADD CONSTRAINT "flight_fk1" FOREIGN KEY ("journeyID") REFERENCES "journey"("journeyID");
ALTER TABLE "flight" ADD CONSTRAINT "flight_fk2" FOREIGN KEY ("departFrom") REFERENCES "airport"("airportCode");
ALTER TABLE "flight" ADD CONSTRAINT "flight_fk3" FOREIGN KEY ("arriveTo") REFERENCES "airport"("airportCode");




ALTER TABLE "admin" ADD CONSTRAINT "admin_fk0" FOREIGN KEY ("admin_id") REFERENCES "user"("userID");



ALTER TABLE "customer" ADD CONSTRAINT "customer_fk0" FOREIGN KEY ("customerID") REFERENCES "user"("userID");
ALTER TABLE "customer" ADD CONSTRAINT "customer_fk1" FOREIGN KEY ("paymnet_id") REFERENCES "payment"("paymentID");

ALTER TABLE "passenger" ADD CONSTRAINT "passenger_fk0" FOREIGN KEY ("cusID") REFERENCES "customer"("customerID");

ALTER TABLE "book" ADD CONSTRAINT "book_fk0" FOREIGN KEY ("userID") REFERENCES "user"("userID");
ALTER TABLE "book" ADD CONSTRAINT "book_fk1" FOREIGN KEY ("journeyID") REFERENCES "journey"("journeyID");

ALTER TABLE "receives" ADD CONSTRAINT "receives_fk0" FOREIGN KEY ("custID") REFERENCES "customer"("customerID");
ALTER TABLE "receives" ADD CONSTRAINT "receives_fk1" FOREIGN KEY ("ticketID") REFERENCES "ticket"("ticketID");

ALTER TABLE "receive" ADD CONSTRAINT "receive_fk0" FOREIGN KEY ("pay_id") REFERENCES "payment"("paymentID");
ALTER TABLE "receive" ADD CONSTRAINT "receive_fk1" FOREIGN KEY ("ticketID") REFERENCES "ticket"("ticketID");

ALTER TABLE "belongsTo" ADD CONSTRAINT "belongsTo_fk0" FOREIGN KEY ("flightNO") REFERENCES "flight"("flightNO");
ALTER TABLE "belongsTo" ADD CONSTRAINT "belongsTo_fk1" FOREIGN KEY ("seat_no") REFERENCES "ticket"("seatNO");







ALTER TABLE public."user" ALTER COLUMN "userID" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."user_userID_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);