import 'package:flutter/material.dart';
import 'package:udemy3/screens/cart_screen.dart';
import 'package:udemy3/widgets/badge.dart';
import '../provider/cart.dart';
import '../widgets/app_drawer.dart';
import '../widgets/product_gridwidget.dart';
import 'package:provider/provider.dart';

enum FilteredOptions {
  favorites,
  all,
}

class ProductOverVirew extends StatefulWidget {
  const ProductOverVirew({super.key});

  @override
  State<ProductOverVirew> createState() => _ProductOverVirewState();
}

class _ProductOverVirewState extends State<ProductOverVirew> {
  //
  var _showOnlyFavorites = false;

  @override
  void initState() {
    // TODO: implement initState
     
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("String"),
        actions: [
          PopupMenuButton(
              onSelected: (FilteredOptions selectedValue) {
                setState(() {
                  if (selectedValue == FilteredOptions.favorites) {
                    _showOnlyFavorites = true;
                  } else {
                    _showOnlyFavorites = false;
                  }
                });
              },
              icon: const Icon(Icons.more_vert),
              itemBuilder: (value) => [
                    const PopupMenuItem(
                      value: FilteredOptions.favorites,
                      child: Text(
                        "Favorie",
                        style: TextStyle(color: Colors.purple),
                      ),
                    ),
                    const PopupMenuItem(
                      value: FilteredOptions.all,
                      child: Text(
                        "Show all",
                        style: TextStyle(color: Colors.purple),
                      ),
                    )
                  ]),
          Consumer<Cart>(
            builder: (context, cart, ch) => Krug(
              color: Colors.orange,
              value: cart.itemCount.toString(),
              child: ch as Widget,
            ),
            child: IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreen.routeName);
                },
                icon: const Icon(Icons.shopping_bag)),
          )
        ],
      ),
      drawer: const AppDrawer(),
      body: ProductGrid(_showOnlyFavorites),
    );
  }
}
