import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/account/screens/account_screen.dart';
import 'package:amazon_clone/features/admin/screens/post_screen.dart';
import 'package:amazon_clone/features/home/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
   int page = 0;
    double bottomBarWidth = 42;
    double bottomBarBorderWidth = 5;
    void updatePage(int page){
      setState(() {
        this.page = page;
      });
    }
    List<Widget> pages = [
     const PostScreen(),
     const Center(child: Text('Analytics Page'),),
     const Center(child: Text('Orders Page'),),
    ];
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
       appBar: PreferredSize(preferredSize: const Size.fromHeight(50),
       child: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: GlobalVariables.appBarGradient
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              alignment: Alignment.topLeft,
              child: Image.asset('assets/images/amazon_in.png',
              width: 120,
              height: 45,
              color: Colors.black,),
            ),

          

            const Text('Admin',
      style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),),
          ],
        ),
       )),
   
   body:   pages[page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: page ,
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        backgroundColor: GlobalVariables.backgroundColor,
        iconSize: 28,
        onTap:updatePage,
        items: [
          BottomNavigationBarItem(
            
            icon: Container(
           width: bottomBarWidth,
           decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: page==0?GlobalVariables.selectedNavBarColor:GlobalVariables.backgroundColor,
                width: bottomBarBorderWidth,
              )
            )
           ),
           child: const Icon(Icons.home_outlined),
          ),
          label: '',
          ),
             BottomNavigationBarItem(icon: Container(
           width: bottomBarWidth,
           decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: page==1?GlobalVariables.selectedNavBarColor:GlobalVariables.backgroundColor,
                width: bottomBarBorderWidth,
              )
            )
           ),
           child: const Icon(Icons.analytics_outlined),
          ),
          label: '',
          ),
           BottomNavigationBarItem(icon: Container(
           width: bottomBarWidth,
           decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: page==2?GlobalVariables.selectedNavBarColor:GlobalVariables.backgroundColor,
                width: bottomBarBorderWidth,
              )
            )
           ),
           child: const Icon(Icons.all_inbox_outlined),
          ),
          label: '',
          ),
       
       

        ],
      ),
    );

  }
}