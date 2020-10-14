import 'package:flutter/foundation.dart';


class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem(this.id, this.title, this.quantity, this.price);
}


class Cart with ChangeNotifier {
  Map<String, CartItem> _items={};

  Map<String, CartItem> get items{
   return {..._items};
  }

  void removeSingleItem(String productId) {
    if(!_items.containsKey(productId)) {return ;}
    if(_items[productId].quantity > 1)
      {
        _items.update(productId, (existingCartItem) => CartItem(existingCartItem.id,existingCartItem.title,existingCartItem.quantity-1,existingCartItem.price));
      }
    else
      {
        _items.remove(productId);
      }
    notifyListeners();
}

  void addItem(String productId,double price,String title,) {
    if (_items.containsKey(productId)) {
      _items.update(productId, (existingCartItem) => CartItem(existingCartItem.id,existingCartItem.title,existingCartItem.quantity+1,existingCartItem.price));
    }
    else
      {
        _items.putIfAbsent(productId, () => CartItem(DateTime.now().toString(), title, 1, price));
      }
    notifyListeners();
  }

  double get totalAmount
  {  double total = 0.0;
     if(_items != null) {
       _items.forEach((key, cartItem) {
         total += cartItem.price * cartItem.quantity;
       });
       print(totalAmount);
       return totalAmount;
     }
     return 0.0;
  }

  int get itemCount {
    return  _items.length;
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clear(){
    _items = {};
    notifyListeners();
  }

}