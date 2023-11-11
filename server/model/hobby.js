const mongoose = require("mongoose");
const MSchema = mongoose.Schema;

const hobbySchema = new MSchema({
  title: String,
  userId: String,
  description: String,
});
module.exports = mongoose.model("Hobby", hobbySchema);
