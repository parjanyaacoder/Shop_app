import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/widgets/product_item.dart';
class ProductsGrid extends StatelessWidget {

  final bool showFavs;

  const ProductsGrid({this.showFavs});

  @override
  Widget build(BuildContext context) {
    
   final productsData =  Provider.of<Products>(context);
    final products = showFavs ? productsData.favouriteItems : productsData.items;
    return GridView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: products.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (context,index){
          return ChangeNotifierProvider(
              create:(context) => Product(products[index].id,products[index].title,products[index].description,products[index].price,products[index].imageUrl),
              child: ProductItem());
        });
  }
}
