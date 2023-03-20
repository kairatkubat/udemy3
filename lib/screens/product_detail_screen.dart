  import 'package:flutter/material.dart';
  import 'package:provider/provider.dart';
import 'package:udemy3/provider/product_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  // final String title;
  // final String price;
  //   const ProductDetailScreen(this.title,   this.price, {super.key});
static const routeName = '/product-detail'; 
  
    @override
    Widget build(BuildContext context) {
      final productId = ModalRoute.of(context)?.settings.arguments as String;// id
        final loadedProduct = 
        Provider.of<Products>(context, listen: false).findbyId(productId);
      
      return Scaffold(
        appBar: AppBar(title: Text(loadedProduct.title )),
      );
    }
  }