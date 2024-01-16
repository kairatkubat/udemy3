import 'package:flutter/material.dart';
import 'package:udemy3/provider/cart.dart';
import 'package:udemy3/provider/orders.dart';
import 'package:udemy3/screens/cart_screen.dart';
import 'package:udemy3/screens/edit_product_screen.dart';
import 'package:udemy3/screens/product_overview.dart';
import 'package:udemy3/screens/user_products_screen.dart';
import './screens/product_detail_screen.dart';
import 'package:provider/provider.dart';
import './provider/product_provider.dart';
import './screens/orders_screen.dart';
import './screens/auth_screen.dart';
import './provider/auth.dart';


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
        ChangeNotifierProvider.value(value: Auth()),
ChangeNotifierProxyProvider<Auth, Products>(
       //version 4+ create instead of build
    create: (ctx) => Products('', []),
     update: (ctx, auth, previous) => Products(auth.token?? '' , previous!.items == null?[]: previous.items),
     //create: (BuildContext ctx) => Products(Provider.of<Auth>(ctx, listen: false)),
       ),
      ChangeNotifierProvider(create: (context) => Cart()), 
      ChangeNotifierProxyProvider<Auth, Orders>(create: (ctx) => Orders('',[]),
       update: (ctx, auth, previous) => Orders(auth.token?? '', previous == null?[]: previous.orders)), 
    ],
      //alternative way ChangeNotifierProvider.value 
      // value: Products(),
     
      child: Consumer<Auth>(builder: (context, auth, _) => MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData( 
          primarySwatch: Colors.purple,
          secondaryHeaderColor: Colors.deepOrange ,
          textTheme: const TextTheme(titleMedium: TextStyle(color: Colors.black),
          titleLarge: TextStyle(color: Colors.black54 , fontSize: 24, fontWeight: FontWeight.bold)
          
          )
        ),
        home: auth.isAuth? ProductOverVirew():  AuthScreen(),
        routes: {
           ProductDetailScreen.routeName: (context) => ProductDetailScreen() ,
           CartScreen.routeName:(context) => const  CartScreen() ,
           OrdersScreen.routeName: (context) => const OrdersScreen(), 
           UserProduct.routeName:(context) => UserProduct(),
           EditProduct.routeName:(context) => const EditProduct()

        },
      ),) 
    );
  }
}
 