import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/models/http_exception.dart';
import 'product.dart';


class Products with ChangeNotifier  {
   List<Product> _products = [
    // Product(
    //   'p1',
    //   'Red Shirt',
    //   'A red shirt - it is pretty red!',
    //   29.99,
    //   'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   'p2',
    //   'Red Shirt',
    //   'A red shirt - it is pretty red!',
    //   29.99,
    //   'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   'p3',
    //   'Red Shirt',
    //   'A red shirt - it is pretty red!',
    //   29.99,
    //   'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
  ];

  final String authtoken;
  final String userId;

  Products(this.authtoken,this._products,this.userId);

   List<Product> get items {
     return [..._products];
   }

   List<Product> get favouriteItems {
     return _products.where((element) => element.isFavourite == true).toList();
   }

   Product findById(String id){
     return items.firstWhere((prod)=> prod.id == id);
   }
   
   Future<void> fetchAndSetProducts({bool filterByUser=false}) async {
    final filterString = filterByUser  ? "orderBy='creatorId'equalTo='$userId'" :"";
     final url =  "https://shopapp-8b1c2.firebaseio.com/products.json?auth=$authtoken&$filterString'";
     try{
       final response =  await http.get(url);
       final List<Product> loadedProducts = [];
       final extractedData = json.decode(response.body) as Map<String,dynamic>;
       if(extractedData == null )
         return ;
       extractedData.forEach((prodId, prodData) {
         loadedProducts.add(Product(prodId,
         prodData['title'],
             prodData['description'],
             prodData['price'],
            prodData['imageUrl'],
             isFavourite: prodData['isFavourite'],
         ));
       });
       _products = loadedProducts;
       notifyListeners();
     }catch (error){throw error;}
   }
   
   Future<void> addProduct(Product product) async {
     final url = "https://shopapp-8b1c2.firebaseio.com/products.json?auth=$authtoken";
     try {
       final response = await http.post(url, body: json.encode({
         'title': product.title,
         'description': product.description,
         'imageUrl': product.imageUrl,
         'price': product.price,
         'isFavourite': product.isFavourite,
         'creatorId':userId,
       }));
       final newProduct = Product(json.decode(response.body)['name'],product.title,product.description,product.price,product.imageUrl);
       _products.add(newProduct);
       notifyListeners();

     } catch (error) {
       throw error;
     }



   }
   Future<void> updateProduct(String id,Product product) async {
     final prodIndex=_products.indexWhere((element) => element.id==id);
     if(prodIndex>0) {
       final url = "https://shopapp-8b1c2.firebaseio.com/products/$id.json?auth=$authtoken";
      await  http.patch(url,body:
       json.encode({
         'title': product.title,
         'description': product.description,
         'imageUrl': product.imageUrl,
         'price': product.price,
         'isFavourite': product.isFavourite,
       })
       );
       _products[prodIndex] = product;
       notifyListeners();
     }
   }

   Future<void> deleteProduct(String id) async {
     final url = "https://shopapp-8b1c2.firebaseio.com/products/$id.json?auth=$authtoken";
     final existingProductIndex = _products.indexWhere((element) => element.id==id);
     var  existingProduct = _products[existingProductIndex];
     _products.removeAt(existingProductIndex);
     _products.insert(existingProductIndex, existingProduct);
     notifyListeners();
    final response = await  http.delete(url);
       if(response.statusCode >= 400) {
         _products.insert(existingProductIndex, existingProduct);
         notifyListeners();
         throw HttpException('Could not delete product');

       }
       existingProduct = null;
   }
}