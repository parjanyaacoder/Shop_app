import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/custom_route.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/screens/edit_product_screen.dart';
import 'package:shop_app/screens/orders_screen.dart';
import 'package:shop_app/screens/product_details_screen.dart';
import 'package:shop_app/screens/products_overview_screen.dart';
import 'providers/auth.dart';
import 'providers/orders.dart';
import 'providers/products.dart';
import 'screens/auth_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/user_products_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Auth(),),
        // ignore: missing_required_param
        ChangeNotifierProxyProvider<Auth,Products>(
        update: ( context, auth, previousProducts) => Products(auth.token,previousProducts == null ? []:previousProducts.items,auth.userId),),
      ChangeNotifierProvider(
    create:(context) => Cart()),
     ChangeNotifierProxyProvider<Auth,Orders>(
       update: ( context, auth, previousOrders) => Orders(auth.token,previousOrders == null ? []:previousOrders.orders,auth.userId),
       ),
      ],
      child: Consumer<Auth>(
        builder: (context,auth,child) => MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.purple,
              accentColor: Colors.deepOrange,
              fontFamily: 'Lato',
              visualDensity: VisualDensity.adaptivePlatformDensity,
              pageTransitionsTheme: PageTransitionsTheme(builders: {
                TargetPlatform.android : CustomPageTransitionBuilder() ,
                TargetPlatform.iOS: CustomPageTransitionBuilder() ,
              })
            ),
            home: auth.isAuth ? ProductsOverviewScreen() : FutureBuilder(future: auth.tryAutoLogin(),builder: (ctx,snapshot) =>
                snapshot.connectionState == ConnectionState.waiting ? SplashScreen() :
                AuthScreen(),),
            routes: {

              ProductDetailsScreen.routeName:(ctx) => ProductDetailsScreen(),
              CartScreen.routeName:(ctx)=> CartScreen(),
              OrdersScreen.routeName:(ctx)=>OrdersScreen(),
              UserProductsScreen.routeName:(ctx)=>UserProductsScreen(),
              EditProductScreen.routeName:(ctx)=> EditProductScreen(),
            },
          ),
      ),

    );
  }
}


