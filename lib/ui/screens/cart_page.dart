import 'package:ecommmerce_app/core/models/cart.dart';
import 'package:ecommmerce_app/core/models/product.dart';
import 'package:ecommmerce_app/core/viewmodels/CRUDModelOfCart.dart';
import 'package:ecommmerce_app/core/viewmodels/CRUDModelOfProduct.dart';
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

    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder(
              future: cartProvider.fetchCarts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  List<Cart> carts = snapshot.data;
                  return ListView(
                    padding: EdgeInsets.only(top: 108.0),
                    children: carts.map<Widget>((cart) {
                      return FutureBuilder(
                          future: productProvider.getProductById(cart.id),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              Product product = snapshot.data;
                              return ListTile(
                                leading: Image.network(
                                  product.images[0],
                                  width: 100,
                                  height: 140,
                                  fit: BoxFit.cover,
                                ),
                                title: Text(product.name),
                                subtitle: Text("Size - " + cart.size),
                              );
                            }
                            return Center(child: CircularProgressIndicator());
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
