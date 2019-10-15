import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:virtual_store/datas/cart_product.dart';
import 'package:virtual_store/datas/product_data.dart';
import 'package:virtual_store/models/cart_model.dart';
import 'package:virtual_store/models/user_model.dart';
import 'package:virtual_store/screens/cart_screen.dart';
import 'package:virtual_store/screens/login_screen.dart';

class ProductScreen extends StatefulWidget {
  final ProductData product;
  ProductScreen(this.product);

  @override
  _ProductScreenState createState() => _ProductScreenState(product);
}

class _ProductScreenState extends State<ProductScreen> {
  String selectedSize;

  final ProductData product;
  _ProductScreenState(this.product);

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
        appBar: AppBar(
          title: Text(product.title),
          centerTitle: true,
        ),
        body: ListView(
          children: <Widget>[
            AspectRatio(
              aspectRatio: 0.9,
              child: Carousel(
                images: product.images.map((url) {
                  return NetworkImage(url);
                }).toList(),
                dotSize: 4,
                dotSpacing: 15,
                dotBgColor: Colors.transparent,
                dotColor: primaryColor,
                autoplay: false,
              ),
            ),
            Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      product.title,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                      maxLines: 3,
                    ),
                    Text(
                      "R\$ ${product.price.toStringAsFixed(2)}",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: primaryColor),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      "Tamanho",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 34,
                      child: GridView(
                        padding: EdgeInsets.symmetric(vertical: 4),
                        scrollDirection: Axis.horizontal,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          mainAxisSpacing: 8,
                          childAspectRatio: 0.5,
                        ),
                        children: product.sizes.map((size) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                if (selectedSize == size) {
                                  selectedSize = null;
                                } else {
                                  selectedSize = size;
                                }
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                  border: Border.all(
                                    color: size == selectedSize
                                        ? primaryColor
                                        : Colors.grey[500],
                                    width: 3,
                                  )),
                              width: 50,
                              alignment: Alignment.center,
                              child: Text(size),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      height: 44,
                      child: RaisedButton(
                        onPressed: selectedSize != null ? () {
                          if (UserModel.of(context).isLoggedIn()) {
                            CartProduct cartProduct = CartProduct();
                            cartProduct.size = selectedSize;
                            cartProduct.quantity = 1;
                            cartProduct.pid = product.id;
                            cartProduct.category = product.category;
                            cartProduct.productData = product;

                            CartModel.of(context).addCartItem(cartProduct);

                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => CartScreen()));
                          } else {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                          }
                        } : null,
                        child: Text(
                          UserModel.of(context).isLoggedIn()
                              ? "Adicionar ao carrinho"
                              : "Entre para comprar",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        color: primaryColor,
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      "Descriçao",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      product.description,
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                )),
          ],
        ));
  }
}