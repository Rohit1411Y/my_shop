import 'package:amazon_clone/models/user.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddressBox extends StatelessWidget {
  const AddressBox({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    User user = userProvider.user;
    return Container(
      height: 40,
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [
          Color.fromARGB(255, 114, 226, 121),
          Color.fromARGB(255, 162, 236, 233),
        
        ],
        stops: [0.5,1.0],
        ),
      ),
      child:  Padding(
        padding: const EdgeInsets.only(left: 10),
        child:  Row(
         children: [
          const Icon(
            Icons.location_on_outlined,
            size: 20,
          ),
          Expanded(child: Padding(padding: const EdgeInsets.only(left: 5),
          child: Text('Delivery to ${user.name} - ${user.address}'),
          )),
          const Padding(padding: EdgeInsets.only(
            left: 5,
            top: 2,

          ),
          child: Icon(Icons.arrow_drop_down_outlined,size: 18,),
          )
         ],
        ),
      ),
    );
  }
}