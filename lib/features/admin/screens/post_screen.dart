import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/admin/screens/add_product_screen.dart';
import 'package:flutter/material.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  void naigateToAddProduct(){
    Navigator.pushNamed(context, AddProductScreen.routeName);
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
     body: const Center(child: Text('Products'),),
     floatingActionButton: FloatingActionButton(
      backgroundColor: GlobalVariables.selectedNavBarColor,
      tooltip: "Add a Product",
      onPressed: naigateToAddProduct,
      child:  const Icon(Icons.add)
      ),
     floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}