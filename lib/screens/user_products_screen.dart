import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/screens/edit_product_screen.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import 'package:shop_app/widgets/user_product_item.dart';
class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';

  @override
  Widget build(BuildContext context) {

    final productData = Provider.of<Products>(context);

    return Scaffold(
      appBar:AppBar(
        title:Text('Your products'),
        actions:[
          IconButton(
            icon:Icon(Icons.add),
            onPressed:(){
             Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
          )
        ]
      ),
      drawer: AppDrawer(),
      body:Padding(
        padding:EdgeInsets.all(8),
        child:ListView.builder(
           itemCount: productData.items.length,
          itemBuilder: (context,index) => Column(
            children: [
              UserProductItem(id:productData.items[index].id,title:productData.items[index].title,imageUrl:productData.items[index].imageUrl),
              Divider(),
            ],
          ),
        ),
      )

    );
  }
}
