import 'package:flutter/foundation.dart';
class Product with ChangeNotifier{
  final String? id;
  final String title;
  final String description;
  final double price;
  final  String imageUrl;
  bool isFavorite;
  bool isPressed;

  Product(
      {
        required this.id,
        required this.title, 
        required this.description,
        required this.price,
        required this.imageUrl,
         this.isFavorite = false,
         this.isPressed = false,
        
      }
    ); 
    void toggleFavoriteStatus (){
       isFavorite = !isFavorite;
       notifyListeners();  
    }
    void toggleIsPressed (){
      isPressed = !isPressed;
      notifyListeners();
    }
}

 