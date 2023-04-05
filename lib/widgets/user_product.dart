import 'package:flutter/material.dart';
import 'package:udemy3/screens/edit_product_screen.dart';

class UserProductItem  extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
   
   
  const UserProductItem (this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return ListTile(
       title: Text( title, style: TextStyle(color: Colors.black),), 
       leading: CircleAvatar(backgroundImage: NetworkImage(imageUrl)),
       trailing: SizedBox(
        height: 300,
        width: 100,
         child: Row(children: [
          IconButton(onPressed: (){
            Navigator.of(context).pushNamed(EditProduct.routeName, arguments: id   ); 
          }, icon: Icon(Icons.edit)),
          IconButton(onPressed: (){}, icon: Icon(Icons.delete), color: Theme.of(context).colorScheme.error,),
          
          ]),
       ),
    );
  }
}