import 'package:emarting/Providers/product.dart';
import 'package:flutter/material.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({Key? key}) : super(key: key);

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _imageURLPreviewController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();

  var _editedProduct =
      Product(id: '', name: '', price: 0, desc: '', imageURL: '', isFav: false);

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImagePreview);
    super.initState();
  }

  @override
  void dispose() {
    _imageURLPreviewController.dispose();
    _imageUrlFocusNode.removeListener(_updateImagePreview);
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  void _updateImagePreview() {
    if (!_imageUrlFocusNode.hasFocus) {
      if ((!_imageURLPreviewController.text.startsWith('http') &&
              !_imageURLPreviewController.text.startsWith('https')) ||
          (!_imageURLPreviewController.text.endsWith('png') &&
              !_imageURLPreviewController.text.endsWith('.jpg') &&
              !_imageURLPreviewController.text.endsWith('.jpeg'))) {
        return;
      }
      setState(() {});
    }
  }

  void _submitForm() {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('Edit Product')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
            key: _form,
            child: ListView(
              children: [
                TextFormField(
                    decoration: InputDecoration(labelText: 'Title'),
                    textInputAction: TextInputAction.next,
                    onSaved: (value) {
                      _editedProduct = Product(
                        name: value as String,
                        desc: _editedProduct.desc,
                        imageURL: _editedProduct.imageURL,
                        price: _editedProduct.price,
                        id: '',
                      );
                    },
                    validator: (value) {
                      if (value!.length < 5) {
                        return 'Title should be atleast 5 character\'s long!';
                      }
                      return null;
                    }),
                TextFormField(
                    decoration: InputDecoration(labelText: 'Price'),
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    onSaved: (value) {
                      _editedProduct = Product(
                        name: _editedProduct.name,
                        desc: _editedProduct.desc,
                        imageURL: _editedProduct.imageURL,
                        price: double.parse(value as String),
                        id: '',
                      );
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a value';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Enter a valid number';
                      }
                      if (double.parse(value) <= 0) {
                        return 'Price should be greater than 0';
                      }
                      return null;
                    }),
                TextFormField(
                    decoration: InputDecoration(labelText: 'Description'),
                    maxLines: 3,
                    keyboardType: TextInputType.multiline,
                    onSaved: (value) {
                      _editedProduct = Product(
                        name: _editedProduct.name,
                        desc: value as String,
                        imageURL: _editedProduct.imageURL,
                        price: _editedProduct.price,
                        id: '',
                      );
                    },
                    validator: (value) {
                      if (value!.length < 10) {
                        return 'Description should be atleast 5 character\'s long!';
                      }
                      return null;
                    }),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      margin: const EdgeInsets.only(top: 8, right: 10),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey)),
                      child: _imageURLPreviewController.text.isEmpty
                          ? Text('Enter Image URL to preview!')
                          : FittedBox(
                              child: Image.network(
                                  _imageURLPreviewController.text),
                              fit: BoxFit.fill,
                            ),
                    ),
                    Expanded(
                      child: TextFormField(
                          decoration: InputDecoration(labelText: 'Image URL'),
                          keyboardType: TextInputType.url,
                          textInputAction: TextInputAction.done,
                          controller: _imageURLPreviewController,
                          focusNode: _imageUrlFocusNode,
                          onSaved: (value) {
                            _editedProduct = Product(
                              name: _editedProduct.name,
                              desc: _editedProduct.desc,
                              imageURL: value as String,
                              price: _editedProduct.price,
                              id: '',
                            );
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter a value';
                            }
                            if (!value.startsWith('http') &&
                                !value.startsWith('https')) {
                              return 'Please enter a valid URL';
                            }
                            if (!value.endsWith('png') &&
                                !value.endsWith('.jpg') &&
                                !value.endsWith('.jpeg')) {
                              return 'Please enter an Image URL';
                            }
                            return null;
                          },
                          onEditingComplete: () {
                            setState(() {});
                          },
                          onFieldSubmitted: (value) {
                            _submitForm();
                          }),
                    ),
                  ],
                ),
                ElevatedButton(
                    onPressed: () {
                      _submitForm();
                    },
                    child: Text('Submit')),
              ],
            )),
      ),
    );
  }
}
