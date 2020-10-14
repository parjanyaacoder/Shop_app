import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop_app/providers/orders.dart' as ord;
class OrderItem extends StatefulWidget {
  final ord.OrderItem order;

   OrderItem({ this.order});

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {

  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: _expanded ? min(widget.order.products.length*20.0+110,200) : 95,
      child: Card(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            ListTile(
             // title: Text('\$${widget.order.amount}'),
              subtitle: Text(DateFormat('dd/MM/yyyy hh:mm').format(widget.order.dateTime)),
              trailing: IconButton(icon:_expanded ? Icon(Icons.expand_less) : Icon(Icons.expand_more),onPressed: (){
setState(() {
  _expanded =!_expanded;
});
              },),
            ),
              AnimatedContainer(
                duration: Duration(milliseconds: 300),
                padding:EdgeInsets.symmetric(horizontal: 15.0,vertical: 4.0),
                height: _expanded ?  min(widget.order.products.length*20.0+10,100) : 0,
              child: ListView(children: widget.order.products.map(
                  (product) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(product.title,style:TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                      Text('${product.quantity}x \$${product.price}',style: TextStyle(fontSize: 18,color: Colors.grey),)
                    ],
                  )
              ).toList()),
              )
          ],
        ),
      ),
    );
  }
}
