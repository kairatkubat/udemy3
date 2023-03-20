import 'package:flutter/material.dart';
import '../widgets/product_gridwidget.dart';

enum FilteredOptions{
  favorites,
  all,
}

class ProductOverVirew extends StatefulWidget {
  const ProductOverVirew({super.key});

  @override
  State<ProductOverVirew> createState() => _ProductOverVirewState();
}

class _ProductOverVirewState extends State<ProductOverVirew> {
   var _showOnlyFavorites = false;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar( title: const Text("String"),
      actions: [
        IconButton(onPressed: (){}, icon: Icon(Icons.shop)),
        PopupMenuButton(
          onSelected: (FilteredOptions selectedValue) {
           setState(() {
              if(selectedValue == FilteredOptions.favorites){
             _showOnlyFavorites =true;
            }
            else{
             _showOnlyFavorites = false; 
            }
           });
          },
          icon: const Icon(Icons.more_vert),  
          itemBuilder:  (value) =>[
          const PopupMenuItem( value: FilteredOptions.favorites,child:  Text("Favorie"),),
           const PopupMenuItem(value: FilteredOptions.all,child:  Text("Show all"),)
        ]
      )],
      ),
      body: ProductGrid(_showOnlyFavorites),
    );
  }
}