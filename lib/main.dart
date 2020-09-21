import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/screens/edit_product_screen.dart';
import 'package:shop_app/screens/orders_screen.dart';
import 'package:shop_app/screens/product_details_screen.dart';
import 'package:shop_app/screens/products_overview_screen.dart';
import 'providers/orders.dart';
import 'providers/products.dart';
import 'screens/user_products_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
        create:(context) => Products(),),
    ChangeNotifierProvider(
    create:(context) => Cart()),
     ChangeNotifierProvider(
       create: (context) => Orders()),
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato',
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: ProductsOverviewScreen(),
          routes: {
            ProductDetailsScreen.routeName:(ctx) => ProductDetailsScreen(),
            CartScreen.routeName:(ctx)=> CartScreen(),
            OrdersScreen.routeName:(ctx)=>OrdersScreen(),
            UserProductsScreen.routeName:(ctx)=>UserProductsScreen(),
            EditProductScreen.routeName:(ctx)=> EditProductScreen(),
          },
        ),

    );
  }
}


