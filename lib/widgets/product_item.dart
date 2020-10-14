
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/auth.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/screens/product_details_screen.dart';
class ProductItem extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
  final  product =  Provider.of<Product>(context,listen:false);
  final authData = Provider.of<Auth>(context,listen:false);
  final cart = Provider.of<Cart>(context,listen: false);
    return  ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GridTile(
            child: GestureDetector(
        onTap:(){Navigator.of(context).pushNamed(ProductDetailsScreen.routeName,arguments: product.id,);},
      child: Hero(
        tag: product.id,
        child: FadeInImage(
            placeholder: AssetImage('assets/images/product-placeholder.png'),
            image: NetworkImage(product.imageUrl),fit: BoxFit.cover
        ),
      ),

      ),
            footer: GridTileBar(
              backgroundColor: Colors.black87,
              title:Text(product.title,textAlign: TextAlign.center,),
              leading: Consumer<Product>(
                builder: (context,product,child) =>IconButton(icon:product.isFavourite ? Icon(Icons.favorite,color: Theme.of(context).accentColor,):Icon(Icons.favorite_border,color: Theme.of(context).accentColor,),onPressed: (){
                product.toggleFavStatus(authData.token);
              },),),
              trailing: IconButton(icon:Icon(Icons.shopping_cart,color: Theme.of(context).accentColor,),
                onPressed: (){cart.addItem(product.id, product.price, product.title) ;
                Scaffold.of(context).hideCurrentSnackBar();
                    Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text('Added item to cart'),
                  action:SnackBarAction(
                      label:'UNDO',
                    onPressed:(){
                        cart.removeSingleItem(product.id);
                    }
                  ),
                  duration:Duration(seconds:2)
                )
                  );

                },
              ),
            ),
      ),
    );
  }
}
