const express = require('express');
const adminRouter = express.Router();
const admin = require("../middlewares/admin");
const Proudct = require('../models/product');
var  Double = require('mongodb').Double;


adminRouter.post('/admin/add-product/', admin, async (req, res) => {
    try {
       
        const { name, description, images, quantity, price, category } = req.body;
        //  let product = new Product({
        //     name,
        //     description,
        //     images,
        //     quantity,
        //     price,
        //     category
        //  });
        let product = new Proudct({
            name,
            description,
            images,
            quantity,
            price,
            category
        })
        product = await product.save();
        res.json(product);
    }
    catch (e) {
        res.status(500).json({ error: e.message });
    }
});

adminRouter.get("/admin/get-products/",admin,async(req,res)=>{
    try{
 
    const products = await Proudct.find({});
    res.json(products)
    // console.log(res.json(products));
    }
    catch(err){
    //  console.log(err);
    res.status(500).json({error:err.message})
    }
});

adminRouter.post('/admin/delete-product',admin,async(req,res)=>{
 try{
  const{id} = req.body;
  let product = await Proudct.findByIdAndDelete(id);
//   product = await product.save();
   res.json("Product Delted Successfully");
 }
 catch(err){
    res.status(500).json({error:err.message});
 }
});


module.exports = adminRouter;