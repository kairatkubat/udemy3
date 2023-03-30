import 'package:flutter/material.dart';
import 'package:udemy3/provider/cart.dart';
import 'package:udemy3/provider/orders.dart';
import 'package:udemy3/screens/cart_screen.dart';
import 'package:udemy3/screens/product_overview.dart';
import 'package:udemy3/screens/user_products_screen.dart';
import './screens/product_detail_screen.dart';
import 'package:provider/provider.dart';
import './provider/product_provider.dart';
import './screens/orders_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    //provider listener
    return MultiProvider(
      providers: [
ChangeNotifierProvider(
       //version 4+ create instead of build
      create: (context) => Products(),
       ),
      ChangeNotifierProvider(create: (context) => Cart()), 
      ChangeNotifierProvider(create: (context) => Orders()), 
    ],
      //alternative way ChangeNotifierProvider.value 
      // value: Products(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData( 
          primarySwatch: Colors.purple,
          secondaryHeaderColor: Colors.deepOrange ,
          textTheme: TextTheme(titleMedium: TextStyle(color: Colors.white),
          titleLarge: TextStyle(color: Colors.black54 , fontSize: 24, fontWeight: FontWeight.bold)
          
          )
        ),
        home: const  ProductOverVirew(),
        routes: {
           ProductDetailScreen.routeName: (context) => ProductDetailScreen() ,
           CartScreen.routeName:(context) => const  CartScreen() ,
           OrdersScreen.routeName: (context) => const OrdersScreen(), 
           UserProduct.routeName:(context) => UserProduct() 

        },
      ),
    );
  }
}

 