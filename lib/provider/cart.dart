import 'package:flutter/foundation.dart';

class CartItem{
final String id;
final String title;
final int quantity;
final double price;

CartItem({required this.id, required this.title, required this.quantity, required this.price}); 
}

class Cart with ChangeNotifier{
 final Map<String, CartItem> _items = {};
 Map<String, CartItem> get items{
  return {..._items}; 
 }

 int get itemCount {
  return _items.length;
 }

 double get totalAmount{
  double total = 0.0;
   _items.forEach((key, value) {
    total += value.price * value.quantity;
    
  });
  return  total;
 }

 void addItem(String productId, double price, String title){
   if(items.containsKey(productId)){
    // change quantity
    _items.update(productId, (existingItem  ) =>  CartItem(
        id: existingItem.id,
        title: existingItem.title,
        quantity: existingItem.quantity +1, 
        price: existingItem.price));
   }
   else{
      _items.putIfAbsent(productId, () => CartItem(
        id: DateTime.now().toString(),
        title: title,
        price: price,
        quantity: 1
        ));
   }
   notifyListeners();
 }
 void removeItem(String productId){
  _items.remove(productId);
  notifyListeners();
 }
}