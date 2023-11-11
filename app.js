const express = require("express");

const app = express();
const { graphqlHTTP } = require("express-graphql");
const schema = require("./server/schema/schema");

const testSchema = require("./server/schema/types_schema");
const mongoose = require("mongoose");
const dbPath = `mongodb+srv://${process.env.mongoUserName}:${process.env.mongoUserPassword}@graphqlcluster.ytits2m.mongodb.net/${process.env.mongoDatabase}?retryWrites=true&w=majority`;
//mongodb+srv://caleb:<password>@graphqlcluster.ytits2m.mongodb.net/?retryWrites=true&w=majority

const port = process.env.PORT || 4000;
const cors = require("cors");

app.use(cors());
app.use(
  "/graphql",
  graphqlHTTP({
    graphiql: true,
    schema,
  })
);

mongoose
  .connect(dbPath, { useNewUrlParser: true, useUnifiedTopology: true })
  .then(() => {
    app.listen(port, () => {
      console.log("Listening on the port 4000");
    });
  })
  .catch((e) => console.log(e));
