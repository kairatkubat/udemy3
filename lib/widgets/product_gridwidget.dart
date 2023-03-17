import 'package:flutter/material.dart';
import 'package:udemy3/provider/product_provider.dart';
import 'package:udemy3/widgets/product_item.dart';
import 'package:provider/provider.dart';

import '../model/products.dart';

class ProductGrid extends StatelessWidget {
   
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products >(context);
    final product = productsData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: product.length,
      gridDelegate:
     const  SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2, childAspectRatio: 3/2, 
      crossAxisSpacing: 10, mainAxisSpacing: 10),
       itemBuilder: ((context, i) => ProductItem(product[i].id, product[i].title, product[i].imageUrl))
      
       );
  }
}