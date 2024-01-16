import 'package:flutter/material.dart';
import 'package:udemy3/provider/auth.dart';
import 'package:udemy3/screens/product_detail_screen.dart';
import 'package:provider/provider.dart';

import '../provider/cart.dart';
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
    final product =  Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    final  authData = Provider.of<Auth>(context, listen: false);
    return ClipRRect (
      borderRadius: BorderRadius.circular(10),
      child: Container(
    
        decoration: const BoxDecoration(
          color: Colors.grey,
          boxShadow: [
      BoxShadow(
        color: Colors.grey,
        blurRadius: 15.0, // soften the shadow
        spreadRadius: 20.0, //extend the shadow
        offset: Offset(
          20.0, // Move to right 5  horizontally
          20.0, // Move to bottom 5 Vertically
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
                 product.toggleFavoriteStatus(authData.token?? ''); 
              },
              ),
          ),
          title: Text(product. title, textAlign: TextAlign.center,),
          trailing:
           IconButton(
           color: Theme.of(context).secondaryHeaderColor,
           icon:  const Icon( Icons.shopping_cart,size: 20,), onPressed: (){
             if(product.id != null) cart.addItem(product.id!, product.price, product.title); 
             ScaffoldMessenger.of(context).hideCurrentSnackBar();
             ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content:  Text("Item added to cart",),
              duration: Duration(seconds: 2),
              action: SnackBarAction(label:  "Undo", onPressed: (){
                if(product.id != null) cart.removeSingleItem(product.id!); 
              }
              ,),
              
              ));
           },
           )
         
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