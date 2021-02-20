import 'package:ecommmerce_app/core/models/product.dart';
import 'package:ecommmerce_app/core/navigator/generate_route.dart';
import 'package:ecommmerce_app/core/viewmodels/CRUDModelOfProduct.dart';
import 'package:ecommmerce_app/core/viewmodels/my_provider.dart';
import 'package:ecommmerce_app/ui/widgets/custom_action_bar.dart';
import 'package:ecommmerce_app/ui/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<CRUDModelOfProduct>(context);
    final myProvider = Provider.of<MyProvider>(context);

    return Stack(
      children: [
        FutureBuilder<List<Product>>(
          future: _provider.fetchProducts(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Container(
                child: Center(child: Text("Error:" + snapshot.error)),
              );
            }
            if (snapshot.connectionState == ConnectionState.done) {
              return ListView(
                padding: EdgeInsets.only(top: 100.0),
                children: snapshot.data.map(
                  (product) {
                    return ProductCard(
                      product: product,
                      onPressed: () {
                        myProvider.setProduct(product);
                        Navigator.pushNamed(
                            context, GenerateRoute.productPageRoute);
                      },
                    );
                  },
                ).toList(),
              );
            }
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        ),
        CustomActionBar(
          title: "Home",
        ),
      ],
    );
  }
}
