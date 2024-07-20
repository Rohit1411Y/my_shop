const express = require('express');

const User = require("../models/user");
const bcryptjs = require('bcryptjs');
const authRouter = express.Router();
const jwt = require('jsonwebtoken');
const auth = require('../middlewares/auth')

authRouter.post("/api/signup", async (req, res) => {
    //get the data from client

    const { name, email, password } = req.body;

    const existingUser = await User.findOne({ email });
    if (existingUser) {
        return res.status(400).json({
            msg: "User with same email already exists!"
        });
    }
    try {

        const hashedPassword = await bcryptjs.hash(password, 8);
        let user = new User({
            email,
            password: hashedPassword,
            name,
        });
        user = await user.save();
        res.json(user);
    }
    catch (err) {
        res.status(500).json({
            error: err.message,
        })
    }



    //post that data in database



    //return that data to the user

});


//signInRoute
authRouter.post('/api/signin', async (req, res) => {
    try {
        const { email, password } = req.body;

        const user = await User.findOne({ email });
        if (!user) {
            return res.status(400).json({ msg: "User with this email does not exist!" });
        }
        const isMatch = await bcryptjs.compare(password, user.password);
        if (!isMatch) {
            return res.status(400).json({ msg: "Incorrect Password" });
        }

        const token = jwt.sign({ id: user._id }, 'passwordKey');
        res.json({ token, ...user._doc });

    }
    catch (err) {
        res.status(500).json({ error: err.message });
    }
});

authRouter.post("/tokenIsValid", async (req, res) => {
    try {
        const token = req.header('auth_token');
        if (!token)
            return res.json(false);

        const isVerified = jwt.verify(token, 'passwordKey');
        if (!isVerified) return res.json(false);
        const user = await User.findById(isVerified.id);
        if(!user) return res.json(false);
      return res.json(true)
    }
    catch (err) {
        res.status(500).json({ error: err.message });
    }
});

//getUserData

authRouter.get('/',auth, async(req,res)=>{
const user = await User.findById(req.user);

res.json({...user._doc,token:req.token});
});





module.exports = authRouter;