import 'dart:math';
import 'package:flutter/material.dart';
import '../provider/orders.dart' as ord;
import 'package:intl/intl.dart';

class OrderItem extends StatefulWidget {
  final ord.OrderItem  orders;

  const OrderItem(this.orders);

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
   var expanded = false;
  @override
  Widget build(BuildContext context) {
    return  Card(
      margin: const EdgeInsets.all(10),
      child: Column(
          children: [
            ListTile(
              title: Text( '\$${widget.orders.amount.toStringAsFixed(2)}', style: TextStyle(color: Colors.black),),
              subtitle: Text(DateFormat('dd MM  yyyy hh:mm').format(widget.orders.dateTime )),
              trailing: IconButton(
                icon: Icon(expanded? Icons.expand_less:  Icons.expand_more), 
                
                onPressed: (){
                setState(() {
                  expanded = !expanded; 
                });
              },),
            ),
            if(expanded) Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              height: min(widget.orders.products.length * 20 + 80,  100 ),
              child: ListView(
                children: [
                  ...widget.orders.products.map((e) =>  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      Text(e.title, style: const  TextStyle(fontSize: 20 , fontWeight: FontWeight.bold),),
                      Text('${e.quantity } x  \$${e.price }', style: const  TextStyle(fontSize: 18, color: Colors.grey),),
                  
                    ],),
                  ) ).toList(),
                  
                ],
              ),
            )
            
          ],
      ),

    );
  }
}