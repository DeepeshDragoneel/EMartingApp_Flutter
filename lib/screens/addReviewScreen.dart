import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class AddReviewScreen extends StatefulWidget {
  // const AddReviewScreen({Key? key}) : super(key: key);

  @override
  _AddReviewScreenState createState() => _AddReviewScreenState();
}

class _AddReviewScreenState extends State<AddReviewScreen> {
  final _form = GlobalKey<FormState>();
  bool intialized = false;

  var _initValues = {
    'title': '',
    'description': '',
    'rating': '',
  };

  @override
  void didChangeDependencies() {
    if (!intialized) {
      final productId = ModalRoute.of(context)!.settings.arguments as String;
      if (productId != null) {
        _initValues = {
          'title': '',
          'description': '',
          'rating': '',
        };
      }
      intialized = true;
    }
    super.didChangeDependencies();
  }

  void _submitForm() async {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    print(_initValues);

    // Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Add Review'),
        ),
        backgroundColor: Colors.white,
        body: Center(
          child: Form(
              key: _form,
              child: ListView(
                padding: EdgeInsets.all(20),
                children: <Widget>[
                  TextFormField(
                    initialValue: _initValues['title'],
                    decoration: InputDecoration(
                      labelText: 'Heading',
                    ),
                    textInputAction: TextInputAction.next,
                    onSaved: (value) {
                      _initValues['title'] = value as String;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a title';
                      } else if (value.length < 5) {
                        return 'Title must be at least 5 characters long';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    initialValue: _initValues['description'],
                    decoration: InputDecoration(
                      labelText: 'Description',
                    ),
                    textInputAction: TextInputAction.next,
                    onSaved: (value) {
                      _initValues['description'] = value as String;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter the Description';
                      }
                      return null;
                    },
                  ),
                  Divider(),
                  SizedBox(height: 20),
                  Text(
                    'Rating: ',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  RatingBar.builder(
                    initialRating: 1,
                    // comments[index].rating.toDouble(),
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemSize: 40,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      _initValues['rating'] = rating.toString();
                    },
                  ),
                ],
              )),
        ),
        persistentFooterButtons: [
          Container(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(),
              child: Text('Submit'),
              onPressed: () {
                _submitForm();
              },
            ),
          ),
        ]);
  }
}
