import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
class CartItem extends StatelessWidget {
  final String id;
  final String productId;
  final String title;
  final int quantity;
  final double price;



   CartItem(this.id,this.productId, this.title, this.quantity,this.price);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key:ValueKey(id),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        Provider.of<Cart>(context).removeItem(productId);
      },
      confirmDismiss: (direction){
        showDialog(context: context, builder: (context) {
          return AlertDialog(title: Text('Are you sure?'),
          content: Text('DO you want to remove the item from the cart'),
          actions: [
            FlatButton(child: Text('No'),onPressed: (){
              Navigator.of(context).pop(false);},),
            FlatButton(child: Text('Yes'),onPressed: (){ Navigator.of(context).pop(true);},),
          ],
          );
        });
        return ;
      },
      background: Container(color: Theme.of(context).errorColor,
      child: Icon(Icons.delete,color: Colors.white,size: 40,),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(horizontal: 15,vertical: 4.0),
      ),
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 15,vertical: 4.0),
        child: Padding(
          padding:EdgeInsets.all(8.0),
          child: ListTile(
            leading: CircleAvatar(child:Text('\$$price')),
            title: Text(title),
            subtitle: Text('Total: \$${price * quantity}'),
            trailing: Text('$quantity x'),
          ),
        ),
      ),
    );
  }
}
