import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:udemy3/provider/cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime; 
  OrderItem({
    required this.id,
     required this.amount,
     required this.products,
     required this.dateTime
  });
} 

class Orders with ChangeNotifier{
     List<OrderItem> _oreders = [];

     List<OrderItem> get orders {
      return [...orders];
     }
      
      void addOrders(List<CartItem> cartProduct, double total){
        _oreders.insert(0,  OrderItem(id: DateTime.now().toString(),
         amount: total, products: cartProduct, dateTime: DateTime.now(),
                                     )
               );
               notifyListeners(); 
      }

}