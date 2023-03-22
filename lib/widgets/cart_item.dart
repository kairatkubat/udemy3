import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  final String id;
  final double price;
  final int quantity;
  final String title;
  const CartItem(this.id, this.price, this.quantity, this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(

      margin: const  EdgeInsets.symmetric(horizontal: 15,
       vertical: 4),
       child:  Padding(padding: const EdgeInsets.all(8),
       child: ListTile(
        leading: CircleAvatar(child: Padding(
          padding: const EdgeInsets.all(5),
          child: FittedBox(
            child: Text('\$$price')),
        ),
        ),
        title: Text(title, style: Theme.of(context).textTheme.titleLarge),
         subtitle: Text('Total : \$${(price * quantity)}'),
         trailing: Text('$quantity X'),
       ),
       ),
    );
  }
}