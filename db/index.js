const { Pool } = require("pg");

const pool = new Pool({
  connectionString:
    "postgresql://postgres:rajpatel@localhost:5432/zapdos?schema=myschema",
});

const query = (text, ...params) => {
  return pool.query(text, ...params);
};

module.exports = {
  query,
};
