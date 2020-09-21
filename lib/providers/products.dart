import 'package:flutter/material.dart';

import 'product.dart';


class Products with ChangeNotifier  {
   List<Product> _products = [
    Product(
      'p1',
      'Red Shirt',
      'A red shirt - it is pretty red!',
      29.99,
      'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      'p2',
      'Red Shirt',
      'A red shirt - it is pretty red!',
      29.99,
      'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      'p3',
      'Red Shirt',
      'A red shirt - it is pretty red!',
      29.99,
      'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
  ];

   List<Product> get items {
     return [..._products];
   }

   List<Product> get favouriteItems {
     return _products.where((element) => element.isFavourite == true).toList();
   }

   Product findById(String id){
     return items.firstWhere((prod)=> prod.id == id);
   }

   void addProduct(Product product) {
     final newProduct = Product(DateTime.now().toString(),product.title,product.description,product.price,product.imageUrl);
     _products.add(newProduct);
     notifyListeners();
   }
   void updateProduct(String id,Product product) {
     final prodIndex=_products.indexWhere((element) => element.id==id);
     if(prodIndex>0) {
       _products[prodIndex] = product;
       notifyListeners();
     }
   }

   void deleteProduct(String id) {
   _products.removeWhere((element) => element.id==id);
       notifyListeners();
     }


}