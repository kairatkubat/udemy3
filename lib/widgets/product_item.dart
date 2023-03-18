import 'package:flutter/material.dart';
import 'package:udemy3/screens/product_detail_screen.dart';
import 'package:provider/provider.dart';

import '../provider/product.dart';

class  ProductItem extends StatelessWidget {
  //provider added///////////////////////
  // final String id;
  // final String title;
  // final String imageUrl;
  // const ProductItem(
  //   this.id,
  //   this.title,
  //   this.imageUrl
  //);


  @override
  Widget build(BuildContext context) {
    final product =  Provider.of<Product >(context, listen: false);
    return ClipRRect (
      borderRadius: BorderRadius.circular(10),
      child: Container(
    
        decoration: const BoxDecoration(
          color: Colors.grey,
          boxShadow: [
      BoxShadow(
        color: Colors.grey,
        blurRadius: 15.0, // soften the shadow
        spreadRadius: 5.0, //extend the shadow
        offset: Offset(
          5.0, // Move to right 5  horizontally
          5.0, // Move to bottom 5 Vertically
        ),
      ),]),
        child: GridTile(
          footer:  GridTileBar(
          backgroundColor: Colors.black87,
          leading: Consumer<Product>( 
            builder: (ctx, product, _) =>  IconButton(
              color: Theme.of(context).secondaryHeaderColor,
              icon:  Icon(product.isFavorite ? Icons.favorite: Icons.favorite_border),
              onPressed: (){
                 product.toggleFavoriteStatus(); 
              },
              ),
          ),
          title: Text(product. title, textAlign: TextAlign.center,),
          trailing: IconButton(
            color: Theme.of(context).secondaryHeaderColor,
            icon: const Icon(Icons.shopping_cart,size: 20,), onPressed: (){},
            ),
          )
          ,child:  GestureDetector(
            onTap: (){Navigator.of(context).pushNamed(
              ProductDetailScreen.routeName, arguments: product.id);},
            child: Image.network(product.imageUrl, fit: BoxFit.cover,
                  ),
          ) ,
        ),
      ),
    );
  }
}