import 'package:ecommmerce_app/constants.dart';
import 'package:ecommmerce_app/core/models/product.dart';
import 'package:ecommmerce_app/core/navigator/generate_route.dart';
import 'package:ecommmerce_app/core/viewmodels/CRUDModelOfProduct.dart';
import 'package:ecommmerce_app/core/viewmodels/my_provider.dart';
import 'package:ecommmerce_app/ui/widgets/custom_action_bar.dart';
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
                    return GestureDetector(
                      onTap: () {
                        myProvider.setProduct(product);

                        Navigator.pushNamed(
                            context, GenerateRoute.productPageRoute);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12)),
                        height: 350.0,
                        margin: EdgeInsets.symmetric(
                          vertical: 12.0,
                          horizontal: 24.0,
                        ),
                        child: Stack(
                          children: [
                            Container(
                              height: 350.0,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  product.images[0],
                                  fit: BoxFit.cover,
                                  loadingBuilder: (BuildContext context,
                                      Widget child,
                                      ImageChunkEvent loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Container(
                                      color: Colors.grey[300],
                                      child: Center(
                                        child: CircularProgressIndicator(
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
                            Positioned(
                              bottom: 0.0,
                              left: 0,
                              right: 0,
                              child: Padding(
                                padding: const EdgeInsets.all(24.0),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 4.0, horizontal: 8.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.4),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        product.name ?? 'Product Name',
                                        style: Constants.boldHeading,
                                      ),
                                      Text(
                                        '\$${product.price}' ?? 'Price',
                                        style: TextStyle(
                                          fontSize: 22.0,
                                          fontWeight: FontWeight.w600,
                                          color: Theme.of(context).accentColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
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
