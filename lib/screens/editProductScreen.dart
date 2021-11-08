import 'dart:io';

import 'package:emarting/Providers/auth.dart';
import 'package:emarting/Providers/product.dart';
import 'package:emarting/Providers/products.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:image_picker/image_picker.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({Key? key}) : super(key: key);

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  PickedFile? _imageFile;
  final ImagePicker _picker = ImagePicker();
  final _imageURLPreviewController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  bool addProduct = false;

  var _editedProduct = Product(
    id: '',
    name: '',
    price: 0,
    desc: '',
    imageURL: '',
    isFav: false,
    rating: 5.0,
    author: 'Anonymous',
    genre: 'Unknown',
    quantity: 0,
    pages: 0,
  );

  var _initValue = {
    'name': '',
    'desc': '',
    'imageURL':
        'https://d827xgdhgqbnd.cloudfront.net/wp-content/uploads/2016/04/09121712/book-cover-placeholder.png',
    'price': '',
    'defaultImage': 'assets/images/bookPlaceholder.png',
    'pages': '',
    'quantity': '',
    'author': '',
    'genre': 'Action and Adventure',
  };
  final genredata = [
    {"name": "Action and Adventure"},
    {"name": "Classics"},
    {"name": "Comic Book or Graphic Novel"},
    {"name": "Detective and Mystery"},
    {"name": "Fantasy"},
    {"name": "Historical Fiction"},
    {"name": "Horror"},
    {"name": "Literary Fiction"},
    {"name": "Romance"},
    {"name": "Science Fiction"},
    {"name": "Short Stories"},
    {"name": "Suspense and Thrillers"},
    {"name": "Women's Fiction"},
    {"name": "Biographies and Autobiographies"},
    {"name": "Cookbooks"},
    {"name": "Essays"},
    {"name": "History"},
    {"name": "Memoir"},
    {"name": "Poetry"},
    {"name": "Self-Help"},
    {"name": "True Crime"}
  ];

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImagePreview);
    super.initState();
  }

  bool firstTime = true;

  Future<String> getJson() {
    return rootBundle.loadString('json_data.json');
  }

  @override
  void didChangeDependencies() async {
    if (firstTime) {
      final editingProductId = ModalRoute.of(context)!.settings.arguments;
      if (editingProductId != null) {
        firstTime = false;
        _editedProduct = Provider.of<Products>(context, listen: false)
            .findProductById(editingProductId as String);
        _initValue = {
          'name': _editedProduct.name,
          'desc': _editedProduct.desc,
          'imageURL': _editedProduct.imageURL,
          'price': _editedProduct.price.toString(),
          'pages': _editedProduct.pages.toString(),
          'quantity': _editedProduct.quantity.toString(),
          'author': _editedProduct.author,
          'genre': _editedProduct.genre,
          'defaultImage': _editedProduct.imageURL,
        };
        _imageURLPreviewController.text = _editedProduct.imageURL;
      } else {
        setState(() {
          addProduct = true;
        });
      }
      // genreData = json.decode(await getJson());
    }
    super.didChangeDependencies();
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
              false
          // (!_imageURLPreviewController.text.endsWith('png') &&
          //     !_imageURLPreviewController.text.endsWith('.jpg') &&
          //     !_imageURLPreviewController.text.endsWith('.jpeg'))
          ) {
        return;
      }
      setState(() {});
    }
  }

  void _submitForm() async {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    print('Submitted');
    final userToken = Provider.of<Auth>(context, listen: false).token;
    final productProvider = Provider.of<Products>(context, listen: false);
    _form.currentState!.save();
    if (_editedProduct.id != '') {
      productProvider.updateProducts(
          _editedProduct.id, _editedProduct, _imageFile, userToken);
    } else {
      productProvider.addProduct(
          _editedProduct, _imageFile as PickedFile, userToken);
    }
    // Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    // final arguments = ModalRoute.of(context)!.settings.arguments as Map;
    // if (arguments != null) {
    //   print(arguments);
    // }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text(addProduct ? 'Add Product' : 'Edit Product')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
            key: _form,
            child: ListView(
              children: [
                TextFormField(
                    initialValue: _initValue['name'],
                    decoration: InputDecoration(labelText: 'Title'),
                    textInputAction: TextInputAction.next,
                    onSaved: (value) {
                      _editedProduct = Product(
                        name: value as String,
                        desc: _editedProduct.desc,
                        imageURL: _editedProduct.imageURL,
                        price: _editedProduct.price,
                        id: _editedProduct.id,
                        isFav: _editedProduct.isFav,
                        author: _editedProduct.author,
                        pages: _editedProduct.pages,
                        quantity: _editedProduct.quantity,
                        rating: _editedProduct.rating,
                        genre: _editedProduct.genre,
                      );
                    },
                    validator: (value) {
                      if (value!.length < 5) {
                        return 'Title should be atleast 5 character\'s long!';
                      }
                      return null;
                    }),
                TextFormField(
                    initialValue: _initValue['price'],
                    decoration: InputDecoration(labelText: 'Price'),
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    onSaved: (value) {
                      _editedProduct = Product(
                        name: _editedProduct.name,
                        desc: _editedProduct.desc,
                        imageURL: _editedProduct.imageURL,
                        price: double.parse(value as String),
                        id: _editedProduct.id,
                        isFav: _editedProduct.isFav,
                        author: _editedProduct.author,
                        pages: _editedProduct.pages,
                        quantity: _editedProduct.quantity,
                        rating: _editedProduct.rating,
                        genre: _editedProduct.genre,
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
                    initialValue: _initValue['pages'],
                    decoration: InputDecoration(labelText: 'Pages'),
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    onSaved: (value) {
                      _editedProduct = Product(
                        name: _editedProduct.name,
                        desc: _editedProduct.desc,
                        imageURL: _editedProduct.imageURL,
                        price: _editedProduct.price,
                        id: _editedProduct.id,
                        isFav: _editedProduct.isFav,
                        author: _editedProduct.author,
                        pages: double.parse(value as String),
                        quantity: _editedProduct.quantity,
                        rating: _editedProduct.rating,
                        genre: _editedProduct.genre,
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
                        return 'Pages should be greater than 0';
                      }
                      return null;
                    }),
                TextFormField(
                    initialValue: _initValue['quantity'],
                    decoration: InputDecoration(labelText: 'Quatity'),
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    onSaved: (value) {
                      _editedProduct = Product(
                        name: _editedProduct.name,
                        desc: _editedProduct.desc,
                        imageURL: _editedProduct.imageURL,
                        price: _editedProduct.price,
                        id: _editedProduct.id,
                        isFav: _editedProduct.isFav,
                        author: _editedProduct.author,
                        pages: _editedProduct.pages,
                        quantity: double.parse(value as String),
                        rating: _editedProduct.rating,
                        genre: _editedProduct.genre,
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
                        return 'Quantity should be greater than 0';
                      }
                      return null;
                    }),
                DropdownButtonFormField(
                  decoration: InputDecoration(labelText: 'Category'),
                  value: _initValue['genre'],
                  items: genredata.map((genre) {
                    return DropdownMenuItem(
                      value: genre['name'],
                      child: Text(genre['name'] as String),
                    );
                  }).toList(),
                  onSaved: (value) {
                    _editedProduct = Product(
                      name: _editedProduct.name,
                      desc: _editedProduct.desc,
                      imageURL: _editedProduct.imageURL,
                      price: _editedProduct.price,
                      id: _editedProduct.id,
                      isFav: _editedProduct.isFav,
                      author: _editedProduct.author,
                      pages: _editedProduct.pages,
                      quantity: _editedProduct.quantity,
                      rating: _editedProduct.rating,
                      genre: value as String,
                    );
                  },
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
                TextFormField(
                    initialValue: _initValue['author'],
                    decoration: InputDecoration(labelText: 'Author'),
                    textInputAction: TextInputAction.next,
                    onSaved: (value) {
                      _editedProduct = Product(
                        name: _editedProduct.name,
                        desc: _editedProduct.desc,
                        imageURL: _editedProduct.imageURL,
                        price: _editedProduct.price,
                        id: _editedProduct.id,
                        isFav: _editedProduct.isFav,
                        author: value as String,
                        pages: _editedProduct.pages,
                        quantity: _editedProduct.quantity,
                        rating: _editedProduct.rating,
                        genre: _editedProduct.genre,
                      );
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter Author\'s name';
                      }
                      return null;
                    }),
                TextFormField(
                    initialValue: _initValue['desc'],
                    decoration: InputDecoration(labelText: 'Description'),
                    maxLines: 3,
                    keyboardType: TextInputType.multiline,
                    onSaved: (value) {
                      _editedProduct = Product(
                        name: _editedProduct.name,
                        desc: value as String,
                        imageURL: _editedProduct.imageURL,
                        price: _editedProduct.price,
                        id: _editedProduct.id,
                        isFav: _editedProduct.isFav,
                        author: _editedProduct.author,
                        pages: _editedProduct.pages,
                        quantity: _editedProduct.quantity,
                        rating: _editedProduct.rating,
                        genre: _editedProduct.genre,
                      );
                    },
                    validator: (value) {
                      if (value!.length < 10) {
                        return 'Description should be atleast 10 character\'s long!';
                      }
                      return null;
                    }),
                // Row(
                //   crossAxisAlignment: CrossAxisAlignment.end,
                //   children: [
                //     Container(
                //       width: 100,
                //       height: 100,
                //       margin: const EdgeInsets.only(top: 8, right: 10),
                //       decoration: BoxDecoration(
                //           border: Border.all(width: 1, color: Colors.grey)),
                //       child: _imageURLPreviewController.text.isEmpty
                //           ? Text('Enter Image URL to preview!')
                //           : FittedBox(
                //               child: Image.network(
                //                   _imageURLPreviewController.text),
                //               fit: BoxFit.fill,
                //             ),
                //     ),
                //     Expanded(
                //       child: TextFormField(
                //           decoration: InputDecoration(labelText: 'Image URL'),
                //           keyboardType: TextInputType.url,
                //           textInputAction: TextInputAction.done,
                //           controller: _imageURLPreviewController,
                //           focusNode: _imageUrlFocusNode,
                //           onSaved: (value) {
                //             _editedProduct = Product(
                //               name: _editedProduct.name,
                //               desc: _editedProduct.desc,
                //               imageURL: value as String,
                //               price: _editedProduct.price,
                //               id: _editedProduct.id,
                //               isFav: _editedProduct.isFav,
                //               author: _editedProduct.author,
                //               pages: _editedProduct.pages,
                //               quantity: _editedProduct.quantity,
                //               rating: _editedProduct.rating,
                //               genre: _editedProduct.genre,
                //             );
                //           },
                //           validator: (value) {
                //             if (value!.isEmpty) {
                //               return 'Please Enter a value';
                //             }
                //             // if (!value.startsWith('http') &&
                //             //     !value.startsWith('https')) {
                //             //   return 'Please enter a valid URL';
                //             // }
                //             // if (!value.endsWith('png') &&
                //             //     !value.endsWith('.jpg') &&
                //             //     !value.endsWith('.jpeg')) {
                //             //   return 'Please enter an Image URL';
                //             // }
                //             return null;
                //           },
                //           onEditingComplete: () {
                //             setState(() {});
                //           },
                //           onFieldSubmitted: (value) {
                //             _submitForm();
                //           }),
                //     ),
                //   ],
                // ),
                SizedBox(height: 10),
                Text('Image: ',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                        color: Colors.grey[850])),
                Center(
                  child: Stack(children: [
                    Container(
                        height: MediaQuery.of(context).size.width * 0.4 + 70,
                        width: MediaQuery.of(context).size.width * 0.4,
                        padding: const EdgeInsets.all(10),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.grey),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: _imageFile == null
                                    ? NetworkImage(
                                            _initValue['imageURL'] as String)
                                        as ImageProvider
                                    : FileImage(File(_imageFile!.path))))),
                    Positioned(
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(width: 1, color: Colors.grey),
                            borderRadius: BorderRadius.circular(15)),
                        child: InkWell(
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (builder) => imageSelectBottom());
                          },
                          child: Icon(
                            Icons.camera_alt_outlined,
                            color: Colors.black,
                            size: 20,
                          ),
                        ),
                      ),
                      bottom: 10,
                      right: 10,
                    ),
                  ]),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                    onPressed: () {
                      if (_imageFile == null && _editedProduct.id == null) {
                        showCupertinoModalPopup(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: Text('Book Cover Picture!'),
                                  content: Text(
                                      'Please upload a Cover picture of your book'),
                                  actions: [
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).pop(true);
                                        },
                                        child: Text('Ok')),
                                  ],
                                ));
                      }
                      // else if (_imageFile == null && _editedProduct.id != null) {

                      // }
                      else {
                        _submitForm();
                      }
                    },
                    child: Text('Submit')),
              ],
            )),
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    try {
      final pikedFile = await _picker.getImage(
          source: source,
          maxWidth: 480,
          maxHeight: 600,
          preferredCameraDevice: CameraDevice.front);
      if (pikedFile != null) {
        setState(() {
          _imageFile = pikedFile as PickedFile;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Widget imageSelectBottom() {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(top: 8, right: 10, left: 10, bottom: 10),
      padding: const EdgeInsets.all(10),
      child: Column(children: [
        Text('Select Image: '),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                takePhoto(ImageSource.camera);
              },
              child: Row(
                children: [
                  Icon(Icons.camera_alt_outlined),
                  SizedBox(width: 10),
                  Text('Camera')
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                takePhoto(ImageSource.gallery);
              },
              child: Row(
                children: [
                  Icon(Icons.image_outlined),
                  SizedBox(width: 10),
                  Text('Gallery')
                ],
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
