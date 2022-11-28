-- AlterTable
ALTER TABLE "Bus" ALTER COLUMN "total_seats" DROP NOT NULL,
ALTER COLUMN "vacant_seats" DROP NOT NULL,
ALTER COLUMN "operator_name" DROP NOT NULL,
ALTER COLUMN "operator_contact" DROP NOT NULL;

-- AlterTable
ALTER TABLE "Flight" ALTER COLUMN "operator_name" DROP NOT NULL,
ALTER COLUMN "operator_contact" DROP NOT NULL;

-- AlterTable
ALTER TABLE "Hotel" ADD COLUMN     "images" TEXT,
ALTER COLUMN "total_rooms" DROP NOT NULL,
ALTER COLUMN "vacant_rooms" DROP NOT NULL,
ALTER COLUMN "owner_contact" DROP NOT NULL;

-- AlterTable
ALTER TABLE "RHomes" ADD COLUMN     "image" TEXT,
ALTER COLUMN "total_rooms" DROP NOT NULL,
ALTER COLUMN "owner_contact" DROP NOT NULL;

-- AlterTable
ALTER TABLE "Train" ALTER COLUMN "total_seats" DROP NOT NULL,
ALTER COLUMN "vacant_seats" DROP NOT NULL,
ALTER COLUMN "operator_name" DROP NOT NULL,
ALTER COLUMN "operator_contact" DROP NOT NULL;

-- AlterTable
ALTER TABLE "Transport_bookings" ALTER COLUMN "owner_contact" DROP NOT NULL;
