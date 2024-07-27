//improt from packages
const express = require('express');
const mongoose = require('mongoose');


//import from files

const authRouter = require("./routes/auth");
const adminRouter = require('./routes/admin');
const productRouter = require('./routes/product');



//init
const PORT = 3000;
const app = express();
const dbUrl = "mongodb+srv://yadavrohit1411:Eq7itkgzIgrL0g4D@cluster0.cjvkvrn.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0";

//middlware
  app.use(express.json());
app.use(authRouter);
app.use(adminRouter);
app.use(productRouter);


// connection

mongoose.connect(dbUrl).then(()=>{
    console.log("connection successful");
}).catch((e)=>{
console.log(e);
});



app.get("/hello-world",(req,res)=>{
   res.json({
    name:"Rohit Yadav"
   })
})

app.listen(PORT,"0.0.0.0",()=>{
console.log("connected at Port"+PORT);
console.log("hello");
});


