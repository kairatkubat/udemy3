import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udemy3/provider/orders.dart' as vf;
import 'package:udemy3/widgets/app_drawer.dart';
import '../widgets/order_item.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final orderData = Provider.of<vf.Orders>(context);
    return Scaffold(
        appBar: AppBar(title: const Text('Orders')),
        drawer: const AppDrawer(),
        body: FutureBuilder(
          future: Provider.of<vf.Orders>(context, listen: false)
              .fetchAndSetOrders(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              if (snapshot.error != null) {
                //...
                return const Center(
                  child: Text("An error"),
                );
              } else {
                return Consumer<vf.Orders>(
                    builder: (ctx, orderData, child) => ListView.builder(
                          itemCount: orderData.orders.length,
                          itemBuilder: (ctx, index) =>
                              OrderItem(orderData.orders[index]),
                        ));
              }
            }
          },
        ));
  }
}
