import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import '../provider/cart.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String productId;
  final double price;
  final int quantity;
  final String title;
  const CartItem(this.id, this.productId, this.price, this.quantity, this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      confirmDismiss: (direction) {
      return  showDialog(context:  context, 
      builder:  (ctx) => AlertDialog(
        backgroundColor: Colors.grey,
        title:  const Text("Are you sure "),
        content: const Text("Do you want to remove item from the cart?"),
        actions: [
           TextButton(onPressed: (){
            Navigator.of(ctx).pop(false);
           }, child: const Text('No')),
           TextButton(onPressed: (){
            Navigator.of(ctx).pop(true);
           },  child: const Text('Yes'))
        ],
      )); 
      },
      key: ValueKey(id),
      background: Container(
        
        alignment: Alignment.centerRight,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.error,
          borderRadius: BorderRadius.circular(5)),
        child: const Icon(Icons.delete, size: 40, color: Colors.white,),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
           Provider.of<Cart>(context, listen: false).removeItem(productId); 
      },
      child: Card(
    
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
      ),
    );
  }
}