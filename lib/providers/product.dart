import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class Product with ChangeNotifier {
 @required final String id;
 @required final String title;
 @required final String description;
 @required final double price;
 @required final String imageUrl;
  bool isFavourite ;

  Future<void> toggleFavStatus(String authtoken) async
  {
   final oldStatus = isFavourite;
   isFavourite =!isFavourite;
   notifyListeners();
   final url = "https://shopapp-8b1c2.firebaseio.com/products/$id.json?auth=$authtoken";
   try {
    final response = await http.patch(url, body: json.encode({'isFavourite': isFavourite}));
    if(response.statusCode >= 400)
     {
      isFavourite = oldStatus;
      notifyListeners();
     }
   }
   catch (error) {
    isFavourite = oldStatus;
    notifyListeners();
   }
  }

  Product(this.id, this.title, this.description, this.price, this.imageUrl,{this.isFavourite = false});

}