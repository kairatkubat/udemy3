import 'package:flutter/material.dart';
import '../provider/product.dart';

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
  final _form = GlobalKey<FormState>(); 
  var _editProduct = Product(id: null.toString() , title: '', description: '', price: 0, imageUrl: '');

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

  void saveForm(){
      _form.currentState?.save();
      final isValid = _form.currentState?.validate();
      print(_editProduct.price);
      if(isValid!){
        return; 
      }
  }
   
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit product"), actions: [
        IconButton(onPressed: saveForm, icon: const Icon(Icons.save))
      ],),
      body: Padding(
        padding: const EdgeInsets.all(17.0),
        child: Form(
          key: _form ,
          child: ListView(children: [
          TextFormField(
            decoration: const InputDecoration(labelText: 'Title'),
            textInputAction: TextInputAction.next,
            onFieldSubmitted:(value) {
              FocusScope.of(context).requestFocus(_priceFocudNode); 
            } ,
            onSaved: (newValue) {
              _editProduct = 
              Product(id: null.toString() , title: newValue.toString(), 
              description: _editProduct.description,
               price: _editProduct.price, 
               imageUrl: _editProduct.imageUrl);
            },
            validator: (value) { 
              if(value!.isEmpty){
                 return 'Please Enter title';
              }
              return null;
            },
          ),
            TextFormField(
            decoration: const InputDecoration(labelText: 'Price',  ),
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            focusNode: _priceFocudNode,
            onFieldSubmitted: (value) {
              FocusScope.of(context).requestFocus(_decsriptionNode);
            },
             validator: (value) {
              if(value!.isEmpty){
                return 'Please enter price';
              }
             
              return null;  
            },
            onSaved: (value) {
              _editProduct = 
              Product(id: null.toString() , title: _editProduct.title, 
              description: _editProduct.description,
               price: double.parse(value!), 
               imageUrl: _editProduct.imageUrl);
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
             onSaved: (newValue) {
              _editProduct = 
              Product(id: null.toString() , title: _editProduct.title, 
              description: newValue.toString(),
               price: _editProduct.price, 
               imageUrl: _editProduct.imageUrl);
            },
            validator: (value) { 
              if(value!.isEmpty){
                 return 'Please Enter the Description';
              }
              if(value.length < 10){
                return 'text longer';
              }
              return null;
            },
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
                Container(width: 100,
                height: 100,
                margin: const EdgeInsets.only(
                  top: 8,
                  right: 10,
                ),
                decoration: BoxDecoration(border: Border.all(width: 1.0, color: Colors.grey)),
                child: _imageController.text.isEmpty? Text(" Enter  a Url"):
                FittedBox(
                  fit: BoxFit.contain,
                  child: Image.network(_imageController.text ),
                ),
                ),
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(labelText: 'Image'),
                    keyboardType: TextInputType.url,
                    textInputAction: TextInputAction.done, 
                    controller: _imageController,
                    focusNode: _imageUrlFocus ,
                    onFieldSubmitted  : (value){
                      saveForm();
                    },
                    onEditingComplete: (){
                      setState(() {
                        
                      });
                    },
                     onSaved: (newValue) {
              _editProduct = 
              Product(id: null.toString() , title: _editProduct.title, 
              description: _editProduct.description,
               price: _editProduct.price , 
               imageUrl: newValue.toString());
            }, 
            validator: (value){
              if(value!.isEmpty){
                return 'Please enter image url';
              }
              if(!value.startsWith('http') && !value.startsWith('https')){
                return 'invalid adress';
              }
              return null;
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