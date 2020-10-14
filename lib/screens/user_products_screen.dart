import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/screens/edit_product_screen.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import 'package:shop_app/widgets/user_product_item.dart';
class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';
  Future<void> _refreshProducts(BuildContext context) async {
   await  Provider.of<Products>(context,listen: false).fetchAndSetProducts(filterByUser: true);
  }




  @override
  Widget build(BuildContext context) {

   // final productData = Provider.of<Products>(context);

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
      body:FutureBuilder(
        future: _refreshProducts(context),
        builder:(ctx,snapshot)=> snapshot.connectionState == ConnectionState.waiting ? Center(child: CircularProgressIndicator(),): RefreshIndicator(
          onRefresh: () =>_refreshProducts(context),
          child: Consumer<Products>(
            builder: (context,productData,_)=> Padding(
              padding:EdgeInsets.all(8),
              child: ListView.builder(
                 itemCount: productData.items.length,
                itemBuilder: (context,index) => Column(
                  children: [
                    UserProductItem(id:productData.items[index].id,title:productData.items[index].title,imageUrl:productData.items[index].imageUrl),
                    Divider(),
                  ],
                ),
              ),
            ),
          ),
        ),
      )

    );
  }
}
