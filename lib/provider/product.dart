import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String? id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;
  bool isPressed;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
    this.isPressed = false,
  });

  void _setFavVal(bool newValue) {
    isFavorite = newValue;
    notifyListeners();
  }

  Future<void> toggleFavoriteStatus(String token) async {
    final oldStatus = isFavorite;

    isFavorite = !isFavorite;
    notifyListeners();
    final url = Uri.parse(
        'https://udemy3-62da2-default-rtdb.firebaseio.com/products/$id.json?auth=$token');
    try {
      final response =
          await http.patch(url, body: jsonEncode({'isFavorite': isFavorite}));
      if (response.statusCode >= 400) {
        _setFavVal(oldStatus);
      }
    } catch (error) {
      _setFavVal(oldStatus);
    }
  }

  // void toggleIsPressed() {
  //   isPressed = !isPressed;

  //   notifyListeners();
  // }
}
