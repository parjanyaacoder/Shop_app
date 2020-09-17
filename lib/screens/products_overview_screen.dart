import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import 'package:shop_app/widgets/badge.dart';
 import 'package:shop_app/widgets/products_grid.dart';

enum FilterOptions {
  Favourites,
  All
}

class ProductsOverviewScreen extends StatefulWidget {



  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {

  bool _showOnlyFav = false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title:Text('MyShop'),
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            itemBuilder: (_)=>[
              PopupMenuItem(child: Text('Only favourites'),value: FilterOptions.Favourites,),
              PopupMenuItem(child: Text('Show All'),value: FilterOptions.All,)
            ],
            onSelected: (FilterOptions selectedValue) {
             if(selectedValue == FilterOptions.Favourites)
               {
                 setState(() {
                   _showOnlyFav = true;
                 });
               }
             else {
               setState(() {
                 _showOnlyFav = false;
               });
             }
            },
          ),
          Consumer<Cart>(
              builder:(_,cart,child)=> Badge(child:child , value: cart.itemCount.toString()),
          child: IconButton(icon:Icon(Icons.shopping_cart),onPressed: (){
            Navigator.of(context).pushNamed(CartScreen.routeName);
          },),),
        ],
      ),
      body: ProductsGrid(showFavs: _showOnlyFav),
    );
  }
}

