import 'package:amazon_clone/common/widgets/loader.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/home/services/home_services.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CategoryDealScreen extends StatefulWidget {
  static const String routeName = "/category-deals";
  final String category;
  const CategoryDealScreen({super.key, required this.category});

  @override
  State<CategoryDealScreen> createState() => _CategoryDealScreenState();
}

class _CategoryDealScreenState extends State<CategoryDealScreen> {
  List<Product>? productList;
  final HomeServices homeServices = HomeServices();

  @override
  void initState() {
   
    super.initState();
    fetchCategoryProducts();
  }
  fetchCategoryProducts()async{
  productList = await homeServices.fetchCategoryProducts(context: context, category: widget.category);
  setState(() {
    
  });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBar(
            flexibleSpace: Container(
              decoration:
                  const BoxDecoration(gradient: GlobalVariables.appBarGradient),
            ),
            title: Text(
              widget.category,
              style: const TextStyle(color: Colors.black),
            ),
          )),
      body: productList==null? const Loader():
       Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            alignment: Alignment.topLeft,
            child: Text("Keep Shoping For ${widget.category}"),
          ),
          SizedBox(
            height: 170,
            child: GridView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: 15),
              itemCount: productList!.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    childAspectRatio: 1.4,
                    mainAxisSpacing: 10),
                itemBuilder: (context, index) {
                  final product = productList![index];
                  return Column(
                    children: [
                      SizedBox(
                        height: 130,
                        child: DecoratedBox(decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 0.5,
                          )
                        ),
                        child: Padding(padding: const EdgeInsets.all(10),
                         child: Image.network(product.images[0]),
                        ),
                        ),
                      )
                    ],
                  );
                }),
          )
        ],
      ),
    );
  }
}
