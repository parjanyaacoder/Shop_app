import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
class Product with ChangeNotifier {
 @required final String id;
 @required final String title;
 @required final String description;
 @required final double price;
 @required final String imageUrl;
  bool isFavourite ;

  void toggleFavStatus()
  {
   isFavourite =!isFavourite;
   notifyListeners();
  }

  Product(this.id, this.title, this.description, this.price, this.imageUrl,{this.isFavourite = false});

}