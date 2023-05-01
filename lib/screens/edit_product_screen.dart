import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udemy3/provider/product_provider.dart';
import '../provider/product.dart';

class EditProduct extends StatefulWidget {
  static const routeName = 'edit-product';
  const EditProduct({super.key});

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  final _priceFocudNode = FocusNode();
  final _decsriptionNode = FocusNode();
  final _imageController = TextEditingController();
  final _imageUrlFocus = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editProduct =
      Product(id: null, title: '', description: '', price: 0, imageUrl: '');
  var _initValues = {
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': ' '
  };
  var isInit = true;
  var _isLoading = false;
  @override
  void initState() {
    _imageUrlFocus.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final productId = ModalRoute.of(context)?.settings.arguments;

    if (productId != null) {
      _editProduct = Provider.of<Products>(context, listen: false)
          .findbyId(productId as String);
      _initValues = {
        'title': _editProduct.title,
        'description': _editProduct.description,
        'price': _editProduct.price.toString(),
        //'imageUrl': _editProduct.imageUrl
        'imageUrl': ''
      };
      _imageController.text = _editProduct.imageUrl;
    }

    isInit = false;
    super.didChangeDependencies();
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

  void _updateImageUrl() {
    if (!_imageUrlFocus.hasFocus) {
      setState(() {});
    }
  }

  Future<void> saveForm() async {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();

    setState(() {
      _isLoading = true;
    });

    if (_editProduct.id != null) {
      await Provider.of<Products>(context, listen: false)
          .updateProduct(_editProduct.id ?? '', _editProduct);
     
      // Navigator.of(context).pop();
    } else {
      try {
        await Provider.of<Products>(context, listen: false)
            .addProduct(_editProduct);
      } catch (error) {
        await  showDialog<Null>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text("Something went wrong "),
            content: Text(error.toString()),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Okey'))
            ],
          ),
        );
      }
      //  finally {
      //   setState(() {
      //     _isLoading = false;
      //   });

      //   Navigator.of(context).pop();
      // }
    }
     setState(() {
        _isLoading = false;
      });
       Navigator.of(context).pop();
    
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit product"),
        actions: [
          IconButton(onPressed: saveForm, icon: const Icon(Icons.save))
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(17.0),
              child: Form(
                  key: _form,
                  child: ListView(
                    children: [
                      TextFormField(
                        initialValue: _initValues['title'],
                        decoration: const InputDecoration(labelText: 'Title'),
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (value) {
                          FocusScope.of(context).requestFocus(_priceFocudNode);
                        },
                        onSaved: (newValue) {
                          _editProduct = Product(
                              id: _editProduct.id,
                              isFavorite: _editProduct.isFavorite,
                              title: newValue.toString(),
                              description: _editProduct.description,
                              price: _editProduct.price,
                              imageUrl: _editProduct.imageUrl);
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter title';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        initialValue: _initValues['price'],
                        decoration: const InputDecoration(
                          labelText: 'Price',
                        ),
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        focusNode: _priceFocudNode,
                        onFieldSubmitted: (value) {
                          FocusScope.of(context).requestFocus(_decsriptionNode);
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter price';
                          }

                          return null;
                        },
                        onSaved: (value) {
                          _editProduct = Product(
                              id: _editProduct.id,
                              isFavorite: _editProduct.isFavorite,
                              title: _editProduct.title,
                              description: _editProduct.description,
                              price: double.parse(value!),
                              imageUrl: _editProduct.imageUrl);
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        initialValue: _initValues['description'],
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Description'),
                        maxLines: 3,
                        style: const TextStyle(color: Colors.black),
                        keyboardType: TextInputType.multiline,
                        focusNode: _decsriptionNode,
                        onSaved: (newValue) {
                          _editProduct = Product(
                              id: _editProduct.id,
                              isFavorite: _editProduct.isFavorite,
                              title: _editProduct.title,
                              description: newValue.toString(),
                              price: _editProduct.price,
                              imageUrl: _editProduct.imageUrl);
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter the Description';
                          }
                          if (value.length < 10) {
                            return 'text longer';
                          }
                          return null;
                        },
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            margin: const EdgeInsets.only(
                              top: 8,
                              right: 10,
                            ),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1.0, color: Colors.grey)),
                            child: _imageController.text.isEmpty
                                ? const Text(" Enter  a Url")
                                : FittedBox(
                                    fit: BoxFit.contain,
                                    child: Image.network(_imageController.text),
                                  ),
                          ),
                          Expanded(
                            child: TextFormField(
                              decoration:
                                  const InputDecoration(labelText: 'Image'),
                              keyboardType: TextInputType.url,
                              textInputAction: TextInputAction.done,
                              controller: _imageController,
                              focusNode: _imageUrlFocus,
                              onEditingComplete: () {
                                setState(() {});
                              },
                              onSaved: (newValue) {
                                _editProduct = Product(
                                    id: _editProduct.id,
                                    isFavorite: _editProduct.isFavorite,
                                    title: _editProduct.title,
                                    description: _editProduct.description,
                                    price: _editProduct.price,
                                    imageUrl: newValue.toString());
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter image url';
                                }
                                if (!value.startsWith('http') &&
                                    !value.startsWith('https')) {
                                  return 'invalid adress';
                                }
                                return null;
                              },
                            ),
                          )
                        ],
                      )
                    ],
                  )),
            ),
    );
  }
}
