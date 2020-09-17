import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart' show Cart;
import 'package:shop_app/providers/orders.dart';
import 'package:shop_app/widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
   final cart = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: SingleChildScrollView(
        child: Container(
           height: 1000,
          child: Column(
            children: [
            Card(margin: EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total',style: TextStyle(fontSize: 20),),
                  Spacer(),
                //  Consumer<Cart>(
                  //  builder:(context,cart,child) => Chip(
                  //  label: Text('\$${cart.totalAmount.toStringAsFixed(2)}',
                  //  style: TextStyle(color:Theme.of(context).primaryTextTheme.title.color),),
                  //  backgroundColor: Theme.of(context).primaryColor,),
                  //  ),
                  FlatButton(child: Text('ORDER NOW'),onPressed: (){
                  // Provider.of<Orders>(context).addOrder(cart.items.values.toList());
                   print(Provider.of<Orders>(context).orders);
                    cart.clear();
                  },textColor: Theme.of(context).primaryColor,)
                ],
              ),
            ),),
            SizedBox(height:10),
            Expanded(child:ListView.builder(
              itemCount: cart.itemCount,
              itemBuilder: (context,index) => CartItem(cart.items.values.toList()[index].id,cart.items.keys.toList()[index],cart.items.values.toList()[index].title,cart.items.values.toList()[index].quantity,cart.items.values.toList()[index].price.toDouble(),),
            ),
           ),
          ],),
        ),
      ),
    );
  }
}
