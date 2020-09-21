

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/providers/products.dart';
class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-products';
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
final _priceFocusNode= FocusNode();
final _imageController = TextEditingController();
final _descFocusNode = FocusNode();
final _imageUrlFocusNode = FocusNode();
final _form = GlobalKey<FormState>();
var isInit = true;
var _editedProduct = Product(null,'','',0.0,'');
var _initValues = {
  'title':'',
 'description' : '',
  'imageUrl':'',
  'price':'',

};

void _updateImageUrl(){
 if(!_imageUrlFocusNode.hasFocus)
   {
     setState(() {

     });
   }
}

void _saveForm() {
 final isValid = _form.currentState.validate();
 if(!isValid)
   {
     return ;
   }
   _form.currentState.save();

 if(_editedProduct.id != null)
   {
     Provider.of<Products>(context,listen: false).updateProduct(_editedProduct.id, _editedProduct);
   }
 else {
   Provider.of<Products>(context,listen: false).addProduct(_editedProduct);
 }
}
 @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if(isInit
    ) {

      final productId = ModalRoute
          .of(context)
          .settings
          .arguments as String;
      if(productId!=null) {
        _editedProduct =
            Provider.of<Products>(context, listen: false).findById(productId);
        _initValues = {
          'title': _editedProduct.title,
          'price': _editedProduct.price.toString(),
          'description': _editedProduct.description,
          'imageUrl': '',
        };
        _imageController.text =  _editedProduct.imageUrl;
      }
      isInit = false;
    }
  }

void dispose(){

  _priceFocusNode.dispose();
  _descFocusNode.dispose();
  _imageController.dispose();
  _imageUrlFocusNode.removeListener(_updateImageUrl);
  _imageUrlFocusNode.dispose();
  super.dispose();
}

@override
  void initState() {

    super.initState();
  _imageUrlFocusNode.addListener(_updateImageUrl);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('Edit Product'),
        actions:[IconButton(icon:Icon(Icons.save),onPressed: _saveForm,)],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child:  ListView(
            children: [
              TextFormField(
                initialValue: _initValues['title'],
                validator: (value){
                  if(value.isEmpty)
                    return 'Please enter a value';
                  else
                    return null;
                },
                 decoration: InputDecoration(labelText: 'Title',),
                textInputAction:  TextInputAction.next,
                onSaved: (value) {
                   _editedProduct = Product(_editedProduct.id,value,_editedProduct.description,_editedProduct.price,_editedProduct.imageUrl,isFavourite: _editedProduct.isFavourite);
                },
                onFieldSubmitted: (value) {
                   FocusScope.of(context).requestFocus(_priceFocusNode);
                },
                autofocus: true,
              ),
              TextFormField(
                
                initialValue: _initValues['price'],
                decoration: InputDecoration(labelText: 'Price',),
                keyboardType: TextInputType.number,
                focusNode: _priceFocusNode,
                textInputAction:  TextInputAction.next,
                onSaved: (value) {
                  _editedProduct = Product(_editedProduct.id,_editedProduct.title,_editedProduct.description,double.parse(value),_editedProduct.imageUrl,isFavourite: _editedProduct.isFavourite);
                },
                onFieldSubmitted: (value) {
                  FocusScope.of(context).requestFocus(_descFocusNode);
                },
              ),
              TextFormField(
                initialValue: _initValues['description'],
                decoration: InputDecoration(labelText: 'Description',),
                maxLines: 3,
                onSaved: (value) {
                  _editedProduct = Product(_editedProduct.id,_editedProduct.title,value,_editedProduct.price,_editedProduct.imageUrl,isFavourite: _editedProduct.isFavourite);
                },
                keyboardType: TextInputType.multiline,
                focusNode: _descFocusNode,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    margin: EdgeInsets.only(top: 8,right: 10),
                    decoration: BoxDecoration(border:Border.all(width: 1,color: Colors.grey)),
                    child: _imageController.text.isEmpty ? Text('Enter a URl') : FittedBox(
                      fit: BoxFit.cover,
                      child: Image.network(_imageController.text),
                    ),

                  ),
                  Expanded(
                    child: TextFormField(

                      decoration: InputDecoration(labelText: 'Image url'),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _imageController,
                      focusNode: _imageUrlFocusNode,
                      onSaved: (value) {
                        _editedProduct = Product(_editedProduct.id,_editedProduct.title,_editedProduct.description,_editedProduct.price,value,isFavourite: _editedProduct.isFavourite);
                      },
                      onFieldSubmitted: (_){_saveForm();},
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
