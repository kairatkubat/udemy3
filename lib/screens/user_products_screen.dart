import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udemy3/widgets/app_drawer.dart';
import 'package:udemy3/widgets/user_product.dart';
import '../provider/product_provider.dart';
import '../screens/edit_product_screen.dart';

class UserProduct extends StatelessWidget {
  static const routeName = '/user-product';

  Future<void> _refreshProducts(BuildContext context) async{
    await Provider.of<Products>(context, listen:  false).fetchAndSetProducts();  }

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Product"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(EditProduct.routeName);
              },
              icon: const Icon(Icons.add))
        ],
      ),
      drawer: const AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () => _refreshProducts(context),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView.builder(
            itemCount: productsData.items.length,
            itemBuilder: (ctx, index) => Column(
              children: [
                UserProductItem(
                    productsData.items[index].id!,
                    productsData.items[index].title,
                    productsData.items[index].imageUrl),
                const Divider(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
