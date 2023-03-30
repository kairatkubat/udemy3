import 'package:flutter/material.dart';

class UserProductItem  extends StatelessWidget {
  final String title;
  final String imageUrl;
   
   
  const UserProductItem (this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return ListTile(
       title: Text( title, style: TextStyle(color: Colors.black),), 
       leading: CircleAvatar(backgroundImage: NetworkImage(imageUrl)),
       trailing: SizedBox(
        height: 300,
        width: 100,
         child: Row(children: [
          IconButton(onPressed: (){}, icon: Icon(Icons.edit)),
          IconButton(onPressed: (){}, icon: Icon(Icons.delete), color: Theme.of(context).colorScheme.error,),
          
          ]),
       ),
    );
  }
}