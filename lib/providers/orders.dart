import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:http/http.dart' as http;
class OrderItem {
 @required final String id;
 @required final double amount;
 @required final List<CartItem> products;
 @required final DateTime dateTime;

  OrderItem(this.id,this.amount,this.products, this.dateTime);
}



class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];
  final String authtoken;
  final String userId;

  Orders(this.authtoken,this._orders,this.userId);
  List<OrderItem> get orders {
    print(_orders);
    return [..._orders];
  }

  Future<void> fetchAndSetOrders() async {
    final url = "https://shopapp-8b1c2.firebaseio.com/orders/$userId.json?auth=$authtoken";
    final response = await  http.get(url);
    final List<OrderItem> loadedOrders = [];
    final extractedData = json.decode(response.body) as Map<String,dynamic>;
    if(extractedData == null )
      return ;
    extractedData.forEach((orderId, orderData) {
      loadedOrders.add(OrderItem(orderId, orderData['amount'], (orderData['products'] as List<dynamic>).map((e) => CartItem(e['id'],e['price'],e['quantity'],e['title'])).toList(), DateTime.parse(orderData['dateTime'])));
    });
    _orders = loadedOrders.reversed.toList();
    notifyListeners();
  }




  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final url = "https://shopapp-8b1c2.firebaseio.com/orders/$userId.json?auth=$authtoken";
    final timeStamp = DateTime.now();
   final response = await http.post(url,body:json.encode({
      'amount':total,
      'dateTime':timeStamp.toIso8601String(),
      'products':cartProducts.map((e) => {
        'id':e.id,
        'title':e.title,
        'price':e.price,
        'qunatity':e.quantity,
      }).toList()

    }));
    _orders.insert(0,OrderItem(json.decode(response.body)['name'],total,cartProducts,DateTime.now()));
    notifyListeners();
  }

}