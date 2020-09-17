import 'package:flutter/foundation.dart';
import 'package:shop_app/providers/cart.dart';

class OrderItem {
 @required final String id;
 @required final double amount;
 @required final List<CartItem> products;
 @required final DateTime dateTime;

  OrderItem(this.id,this.amount,this.products, this.dateTime);
}



class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    print(_orders);
    return [..._orders];
  }

  void addOrder(List<CartItem> cartProducts, double total) {
    _orders.insert(0,OrderItem(DateTime.now().toString(),total,cartProducts,DateTime.now()));
    notifyListeners();
  }

}