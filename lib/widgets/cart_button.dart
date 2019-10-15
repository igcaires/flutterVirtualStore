import 'package:flutter/material.dart';
import 'package:virtual_store/screens/cart_screen.dart';

class CardButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.shopping_cart, color: Colors.white,),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => CartScreen())
        );
      },
      backgroundColor: Theme.of(context).primaryColor,
    );
  }
}
