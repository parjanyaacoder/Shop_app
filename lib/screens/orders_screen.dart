import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/orders.dart' show Orders;
import 'package:shop_app/widgets/app_drawer.dart';
import 'package:shop_app/widgets/order_item.dart';

class OrdersScreen extends StatelessWidget {

  static const routeName = '/orders';


  @override
  Widget build(BuildContext context) {
   return Scaffold(
        drawer: AppDrawer(),
      appBar: AppBar(
        title: Text(
          'Your Orders'
        ),
      ),
      body: FutureBuilder(future:  Provider.of<Orders>(context,listen: false).fetchAndSetOrders(),
       builder: (context,dataSnapshot ) {
      if(  dataSnapshot.connectionState == ConnectionState.waiting )
        {
          return Center(child: CircularProgressIndicator());
        }
       else if (dataSnapshot.error != null){}
            return Consumer<Orders>(
              builder: (ctx,orders,child) => ListView.builder(
              itemCount: orders.orders.length,

          itemBuilder: (context,index) => OrderItem(order: orders.orders[index],)),
            );
          }
      ),
    );
  }
}
