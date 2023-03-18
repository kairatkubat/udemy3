import 'package:flutter/material.dart';
import 'package:udemy3/provider/product_provider.dart';
import 'package:udemy3/widgets/product_item.dart';
import 'package:provider/provider.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid({super.key});

   
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products >(context);
    final products = productsData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: products.length,
      gridDelegate:
     const  SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2, childAspectRatio: 3/2, 
      crossAxisSpacing: 10, mainAxisSpacing: 10),
       itemBuilder: ((context, i) =>  
       ChangeNotifierProvider.value(
        // create: (context) =>products[i ],
        //alternative way
        value: products[i ],
        child: ProductItem(
          // products[i].id, products[i].title, products[i].imageUrl
          )
        )
       )
      
       );
  }
}