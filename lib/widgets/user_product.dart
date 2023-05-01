import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udemy3/provider/product_provider.dart';
import 'package:udemy3/screens/edit_product_screen.dart';

class UserProductItem  extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  
   
   
  const UserProductItem ( this.id, this.title, this.imageUrl,);

  @override
  Widget build(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    return ListTile(
       title: Text( title, style: TextStyle(color: Colors.black),), 
       leading: CircleAvatar(backgroundImage: NetworkImage(imageUrl)),
       trailing: SizedBox(
        height: 300,
        width: 100,
         child: Row(children: [
          IconButton(onPressed: (){
            Navigator.of(context).pushNamed(EditProduct.routeName, arguments: id   ); 
          }, icon: const Icon(Icons.edit)),
          IconButton(onPressed: ()async {
            try{
                await Provider.of<Products>(context, listen:  false ).deleteProduct(id);
            }
            catch(error){
               scaffold.showSnackBar(SnackBar(content: Text("Could not delete")));
            }
            
          }, icon: const Icon(Icons.delete), color: Theme.of(context).colorScheme.error,),
          
          ]),
       ),
    );
  }
}