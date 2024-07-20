import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/account/screens/account_screen.dart';
import 'package:amazon_clone/features/home/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

class BottomBar extends StatefulWidget {
    static const  String routeName = '/bottomBar';
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
   int page = 0;
    double bottomBarWidth = 42;
    double bottomBarBorderWidth = 5;
    void updatePage(int page){
      setState(() {
        this.page = page;
      });
    }
    List<Widget> pages = [
     const HomeScreen(),
     const AccountScreen(),
     const Center(child: Text('Carts Page'),),
    ];
  @override
  Widget build(BuildContext context) {
 
   
    return Scaffold(
      body: pages[page],
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
           child: const Icon(Icons.person),
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
           child:  badges.Badge(
            badgeContent:const Text('3'),
            badgeStyle: const badges.BadgeStyle(
              padding: EdgeInsets.all(0),
              elevation: 0,
              badgeColor: Colors.white
              
            ),
            position: badges.BadgePosition.topStart(start: 30,top: -8),
            child: const Icon(Icons.shopping_cart_outlined)),
          ),
          label: '',
          ),

        ],
      ),
    );
  }
}