import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/product_gridwidget.dart';
import '../widgets/product_gridwidget.dart';


class ProductOverVirew extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(actions: [], title: const Text("My shop"),),
      body: ProductGrid(),
    );
  }
}