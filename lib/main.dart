import 'package:flutter/material.dart';
import 'package:udemy3/screens/product_overview.dart';
import './screens/product_detail_screen.dart';
import 'package:provider/provider.dart';
import './provider/product_provider.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    //provider listener
    return ChangeNotifierProvider(
       //version 4+ create instead of build
      create: (context) => Products(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData( 
          primarySwatch: Colors.purple,
          secondaryHeaderColor: Colors.deepOrange 
        ),
        home: ProductOverVirew(),
        routes: {
           ProductDetailScreen.routeName:(context) => ProductDetailScreen() 
        },
      ),
    );
  }
}

 