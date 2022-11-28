-- CreateTable
CREATE TABLE "User" (
    "id" TEXT NOT NULL,
    "name" TEXT,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Bus" (
    "id" TEXT NOT NULL,
    "from" TEXT NOT NULL,
    "to" TEXT NOT NULL,
    "arrival_time" TIMESTAMP(3) NOT NULL,
    "departure_time" TIMESTAMP(3) NOT NULL,
    "total_seats" INTEGER NOT NULL,
    "vacant_seats" INTEGER NOT NULL,
    "price" DOUBLE PRECISION NOT NULL,
    "operator_name" TEXT NOT NULL,
    "operator_contact" BIGINT NOT NULL,

    CONSTRAINT "Bus_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Train" (
    "id" TEXT NOT NULL,
    "from" TEXT NOT NULL,
    "to" TEXT NOT NULL,
    "arrival_time" TIMESTAMP(3) NOT NULL,
    "departure_time" TIMESTAMP(3) NOT NULL,
    "total_seats" INTEGER NOT NULL,
    "vacant_seats" INTEGER NOT NULL,
    "price" DOUBLE PRECISION NOT NULL,
    "operator_name" TEXT NOT NULL,
    "operator_contact" BIGINT NOT NULL,

    CONSTRAINT "Train_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Flight" (
    "id" TEXT NOT NULL,
    "from" TEXT NOT NULL,
    "to" TEXT NOT NULL,
    "arrival_time" TIMESTAMP(3) NOT NULL,
    "departure_time" TIMESTAMP(3) NOT NULL,
    "total_seats" INTEGER NOT NULL,
    "vacant_seats" INTEGER NOT NULL,
    "price" DOUBLE PRECISION NOT NULL,
    "operator_name" TEXT NOT NULL,
    "operator_contact" BIGINT NOT NULL,

    CONSTRAINT "Flight_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Hotel" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "price" DOUBLE PRECISION NOT NULL,
    "total_rooms" INTEGER NOT NULL,
    "vacant_rooms" INTEGER NOT NULL,
    "amenities" TEXT NOT NULL,
    "rating" DOUBLE PRECISION NOT NULL,
    "owner_contact" BIGINT NOT NULL,

    CONSTRAINT "Hotel_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "RHomes" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "price" DOUBLE PRECISION NOT NULL,
    "total_rooms" INTEGER NOT NULL,
    "amenities" TEXT NOT NULL,
    "rating" DOUBLE PRECISION NOT NULL,
    "owner_contact" BIGINT NOT NULL,

    CONSTRAINT "RHomes_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Transport_bookings" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "price" DOUBLE PRECISION NOT NULL,
    "total_rooms" INTEGER NOT NULL,
    "vacant_rooms" INTEGER NOT NULL,
    "amenities" TEXT NOT NULL,
    "rating" DOUBLE PRECISION NOT NULL,
    "owner_contact" BIGINT NOT NULL,

    CONSTRAINT "Transport_bookings_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Hotel_bookings" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "hotelId" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "number_of_rooms" INTEGER NOT NULL,
    "checkIn" TIMESTAMP(3),
    "checkOut" TIMESTAMP(3),
    "price" DOUBLE PRECISION NOT NULL,

    CONSTRAINT "Hotel_bookings_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- AddForeignKey
ALTER TABLE "Hotel_bookings" ADD CONSTRAINT "Hotel_bookings_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Hotel_bookings" ADD CONSTRAINT "Hotel_bookings_hotelId_fkey" FOREIGN KEY ("hotelId") REFERENCES "Hotel"("id") ON DELETE CASCADE ON UPDATE CASCADE;
