import 'package:flutter/material.dart';
import '../widgets/product_gridwidget.dart';


class ProductOverVirew extends StatelessWidget {
  const ProductOverVirew({super.key});

  

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(actions: [], title: const Text("My shop"),),
      body: ProductGrid(),
    );
  }
}