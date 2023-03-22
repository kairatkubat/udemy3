import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udemy3/provider/cart.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(actions: const [], title: const Text( 'Your cart'),),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Text("Total", style: Theme.of(context).textTheme.titleLarge,),
                  Spacer(),
                  Chip(label: Text('\$${cart.totalAmount}', style: Theme.of(context).textTheme.titleMedium,),
                  backgroundColor: Theme.of(context).primaryColor,
                  ),
                  TextButton(onPressed: (){}, child: const Text("Oreder now"))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}