const express = require('express');
const productRouter = express.Router();
const auth = require('../middlewares/auth');
const product = require("../models/product");


productRouter.get("/api/products",auth,async(req,res)=>{
try{
    console.log(req.query.category);
    const products = await product.find({category:req.query.category});
    res.json(products);
}
catch(e){
    res.status(500).json({error:e.message});
}
});
module.exports = productRouter;