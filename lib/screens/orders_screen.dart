import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udemy3/provider/orders.dart' show Orders;
import '../widgets/order_item.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Orders')),
      body: ListView.builder(itemCount: orderData.orders.length,
      itemBuilder: (context, i) =>  OrderItem(orderData.orders[i])
      ) ,
    );
  }
}