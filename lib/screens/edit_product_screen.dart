import 'package:flutter/material.dart';

class  EditProduct extends StatefulWidget {

  static const routeName = 'edit-product';
  const  EditProduct({super.key});

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  final _priceFocudNode = FocusNode();
  final _decsriptionNode = FocusNode();
  final _imageController = TextEditingController();
  final _imageUrlFocus = FocusNode();

  @override
  void initState() {
   _imageUrlFocus.addListener(_updateImageUrl  );
    super.initState();
  }
  @override
  void dispose() {
    _imageUrlFocus.removeListener(_updateImageUrl);
    _decsriptionNode.dispose();
    _priceFocudNode.dispose(); 
    _imageController.dispose();
    _imageUrlFocus.dispose();
    super.dispose();
  }

  void _updateImageUrl(){
  if(!_imageUrlFocus.hasFocus){
    setState(() {
      
    });
  }
  }
   
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit product")),
      body: Padding(
        padding: const EdgeInsets.all(17.0),
        child: Form(child: ListView(children: [
          TextFormField(
            decoration: const InputDecoration(labelText: 'Title'),
            textInputAction: TextInputAction.next,
            onFieldSubmitted:(value) {
              FocusScope.of(context).requestFocus(_priceFocudNode); 
            } ,
          ),
            TextFormField(
            decoration: const InputDecoration(labelText: 'Price',  ),
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            focusNode: _priceFocudNode,
            onFieldSubmitted: (value) {
              FocusScope.of(context).requestFocus(_decsriptionNode);
            },
          ),
          const SizedBox(height: 15,),
          TextFormField(
            decoration:  const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Description'),
            maxLines: 3,
            style: const TextStyle(color: Colors.black),
            keyboardType: TextInputType.multiline,
            focusNode: _decsriptionNode,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
                Container(width: 100,
                height: 100,
                margin: EdgeInsets.only(
                  top: 8,
                  right: 10,
                ),
                decoration: BoxDecoration(border: Border.all(width: 1.0, color: Colors.grey)),
                child: _imageController.text.isEmpty? Text(" Enter  a Url"):
                FittedBox(
                  child: Image.network(_imageController.text ),
                  fit: BoxFit.contain,
                ),
                ),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(labelText: 'Image'),
                    keyboardType: TextInputType.url,
                    textInputAction: TextInputAction.done, 
                    controller: _imageController,
                    focusNode: _imageUrlFocus ,
                    onEditingComplete: (){
                      setState(() {
                        
                      });
                    },
                
                  ),
                )
            ],
          )
        ],)),
      ),
    
    );
  }
}