import 'dart:convert';
import 'dart:io';

import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:cloudinary_public/cloudinary_public.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AdminServices {
  void sellProduct({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required double quantity,
    required String category,
    required List<File> images,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      final cloudinary = CloudinaryPublic('dfinmhios', 'r1xnheji');
      List<String> imageUrls = [];
      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinary
            .uploadFile(CloudinaryFile.fromFile(images[i].path, folder: name));
        imageUrls.add(res.secureUrl);
      }
      Product product = Product(
        name: name,
        description: description,
        quantity: quantity,
        images: imageUrls,
        category: category,
        price: price,
      );
      http.Response response = await http.post(
        Uri.parse('$uri/admin/add-product/'),
        headers: {
          'Content-Type': 'application/json;charset=UTF-8',
          'auth_token': userProvider.user.token,
        },
        body: product.toJson(),
      );
      print("fn called");
      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            showSnackBar(context, 'Product Added Successfully !');
            Navigator.pop(context);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<List<Product>> fetchAllProducts(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];
    try {
      http.Response response = await http
          .get(Uri.parse('$uri/admin/get-products'), headers: <String, String>{
        // 'Content-Type':'application/json;charset=UTF-8',
        //  'auth_token':userProvider.user.token,
        'Content-Type': 'application/json; charset=UTF-8',
        'auth_token': userProvider.user.token,
      });
      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            print("length is ${jsonDecode(response.body).length}");
            for (int i = 0; i < jsonDecode(response.body).length; i++) {
              productList.add(
                  Product.fromJson(jsonEncode(jsonDecode(response.body)[i])));
            }
          });
    } catch (err) {
      showSnackBar(context, err.toString());
    }

    return productList;
  }

  void deleteProduct({
    required BuildContext context,
    required Product product,
    required VoidCallback onSuccess,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response response =
          await http.post(Uri.parse("$uri/admin/delete-product"),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
                'auth_token': userProvider.user.token,
              },
              body: jsonEncode({'id': product.id}));
      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            print('onsuccess errorhandle called');
            onSuccess();
          });
    } catch (err) {
      showSnackBar(context, err.toString());
    }
  }
}
