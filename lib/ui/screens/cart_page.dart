import 'package:ecommmerce_app/constants.dart';
import 'package:ecommmerce_app/core/models/cart.dart';
import 'package:ecommmerce_app/core/models/product.dart';
import 'package:ecommmerce_app/core/navigator/generate_route.dart';
import 'package:ecommmerce_app/core/viewmodels/CRUDModelOfCart.dart';
import 'package:ecommmerce_app/core/viewmodels/CRUDModelOfProduct.dart';
import 'package:ecommmerce_app/core/viewmodels/my_provider.dart';
import 'package:ecommmerce_app/ui/widgets/custom_action_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<CRUDModelOfProduct>(context);
    final cartProvider = Provider.of<CRUDModelOfCart>(context);
    final myProvider = Provider.of<MyProvider>(context);
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder(
              future: cartProvider.fetchCarts(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Container(
                    child: Center(child: Text("Error:" + snapshot.error)),
                  );
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  List<Cart> carts = snapshot.data;
                  return ListView(
                    padding: EdgeInsets.only(
                      top: 108.0,
                      left: 24.0,
                      right: 24.0,
                    ),
                    children: carts.map<Widget>((cart) {
                      return FutureBuilder(
                          future: productProvider.getProductById(cart.id),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Container(
                                child: Center(
                                    child: Text("Error:" + snapshot.error)),
                              );
                            }
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              Product product = snapshot.data;
                              return GestureDetector(
                                onTap: () {
                                  myProvider.setProduct(product);
                                  Navigator.pushNamed(
                                      context, GenerateRoute.productPageRoute);
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(vertical: 12.0),
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        height: 100.0,
                                        width: 120.0,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          child: Image.network(
                                            product.images[0],
                                            fit: BoxFit.cover,
                                            loadingBuilder:
                                                (BuildContext context,
                                                    Widget child,
                                                    ImageChunkEvent
                                                        loadingProgress) {
                                              if (loadingProgress == null)
                                                return child;
                                              return Container(
                                                color: Colors.grey[300],
                                                child: Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    value: loadingProgress
                                                                .expectedTotalBytes !=
                                                            null
                                                        ? loadingProgress
                                                                .cumulativeBytesLoaded /
                                                            loadingProgress
                                                                .expectedTotalBytes
                                                        : null,
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                              product.name,
                                              style: Constants.regularHeading,
                                            ),
                                            Text(
                                              "\$${product.price}",
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .accentColor,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Text("Size - ${cart.size}",
                                                style:
                                                    Constants.regularHeading),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }
                            return Container(
                                height: 100.0,
                                child:
                                    Center(child: CircularProgressIndicator()));
                          });
                    }).toList(),
                  );
                }
                return Center(child: CircularProgressIndicator());
              }),
          CustomActionBar(
            title: 'Cart',
            hasBackArrow: true,
          )
        ],
      ),
    );
  }
}
