import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/orders.dart' show Orders;
import 'package:shop_app/widgets/app_drawer.dart';
import 'package:shop_app/widgets/order_item.dart';

class OrdersScreen extends StatelessWidget {

  static const routeName = '/orders';
  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<Orders>(context);

    return Scaffold(
        drawer: AppDrawer(),
      appBar: AppBar(
        title: Text(
          'Your Orders'
        ),
      ),
      body:ListView.builder(
          itemCount: orders.orders.length,
          itemBuilder: (context,index) => OrderItem(order: orders.orders[index],))
    );
  }
}
