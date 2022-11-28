import express from "express";
import jwt from "jsonwebtoken";
import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();
const PORT = process.env.PORT || 5000;
import cors from "cors";
const SECRET = "dasfdfhyjukuryerwesfdvfbdhe5y34twesgdfb";
const app = express();

app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: false }));

async function Validate(req, res, next) {
  const token = req.headers["token"];
  if (!token) {
    return res.status(401).json({ status: false, data: "Invalid token" });
  }
  try {
    const user = jwt.decode(token);
    req.user = user;
    next();
  } catch {
    res.status(401).json({ status: false, data: "Internal Server Error" });
  }
}

app.get("/", async (req, res) => {
  res.json({ name: "raj" });
});

app.get("/verify-user", async (req, res) => {
  const token = req.headers["token"];
  if (!token) {
    res.status(401).json({ status: false });
  }
  try {
    const user = jwt.decode(token);
    res.json({ status: true, user });
  } catch {
    res.status(401).json({ status: false });
  }
});
app.post("/login", async (req, res) => {
  const { username, password } = req.body;
  console.log({ username, password });
  if (!username || !password) {
    res.json({ status: false, data: "Please Provide credentials" });
    return;
  }

  const u = await prisma.user.findUnique({
    where: {
      email: username,
    },
  });
  if (u == null) {
    res.json({ status: false, data: "Please Provide credentials" });
    return;
  }
  const hashed = u.password;
  if (hashed === password) {
    const payload = { username, createdAt: Date.now() };
    const token = await jwt.sign(payload, SECRET);
    res.json({ status: true, token });
  } else {
    res.json({ status: false, data: "Please Provide credentials" });
  }
});
app.post("/register", async (req, res) => {
  const { name, username, password } = req.body;
  console.log({ name, username, password });
  if (!username && !password) {
    res.status(401).json({ status: false, data: "Please Provide credentials" });
    return;
  }
  const d = await prisma.user.findUnique({
    where: {
      email: username,
    },
  });
  if (d) {
    res
      .status(401)
      .json({ status: false, data: "Please Login in existing account" });
    return;
  }

  const q = await prisma.user.create({
    data: {
      email: username,
      password,
      name,
    },
  });

  const payload = {
    username,
  };
  const token = await jwt.sign(payload, SECRET);
  res.cookie("token", token, {
    httpOnly: true,
    maxAge: 1000 * 60 * 2,
  });
  res.json({ status: true, token });
});

app.get("/all-hotels", async (req, res) => {
  try {
    const hotels = await prisma.hotel.findMany();
    res.json({ status: true, data: hotels });
  } catch {
    res.json({ status: false, data: "Internal Server Error" });
  }
  res.end();
});

app.get("/add-hotels", async (req, res) => {
  const hotels = await prisma.hotel.createMany({
    data: [
      {
        name: "Courtyard Marriott",
        amenities: "Five Star hotel in the Ahmedabad area",
        price: 999,
        rating: 4.5,
        total_rooms: 270,
        vacant_rooms: 150,
        images:
          "https://images.unsplash.com/photo-1669255034440-7d293acdd207?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwxOHx8fGVufDB8fHx8&auto=format&fit=crop&w=400&q=60",
      },
    ],
  });
  res.json({ status: true, data: hotels });
  res.end();
});

app.get("/single-hotel", async (req, res) => {
  const id = req.headers["id"];
  if (!id)
    res.json({ status: false, data: "Please provide the id of the hotel!" });
  else {
    const hotel = await prisma.hotel.findUnique({ where: { id } });
    res.json({ status: true, data: hotel });
  }
  res.end();
});

app.get("/search", async (req, res) => {
  const name_of_hotel = req.headers["search_param"];
  const hotel = await prisma.hotel.findMany({
    where: {
      name: { contains: name_of_hotel },
    },
  });
  res.json({ status: true, data: hotel });
  res.end();
});

app.post("/book-hotel", Validate, async (req, res) => {
  if (!req?.user?.username) {
    res.json({ status: false, data: "Invalid user" });
  }

  const user = await prisma.user.findUnique({
    where: { email: req?.user?.username },
  });
  if (!user) {
    res.json({ status: false, data: "User Does not exist" });
  }

  const booking = await prisma.hotel_bookings.create({
    data: {
      name: user.email,
      number_of_rooms: req.body.no_of_rooms,
      price: req.body.price,
      checkIn: req.body.checkIn,
      checkOut: req.body.checkOut,
      hotelId: req.body.hotelId,
      userId: user.id,
    },
  });
  res.json({ status: true, data: booking });
});

app.get("/get-bookings", Validate, async (req, res) => {
  if (!req.user?.username) {
    return res.json({ status: false, data: "Please Log in" });
  }
  const user = await prisma.user.findUnique({
    where: {
      email: req.user.username,
    },
  });
  if (!user) {
    res.json({ status: false, data: "User Does not exist" });
  }
  const b = await prisma.hotel_bookings.findMany({
    where: {
      userId: user.id,
    },
  });
  for (let i = 0; i < b.length; i++) {
    b[i].hotel = await prisma.hotel.findUnique({ where: { id: b[i].hotelId } });
  }
  res.json({ status: true, data: b });
});

app.listen(PORT, () => {
  console.log("listening...");
});
