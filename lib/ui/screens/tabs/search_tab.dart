import 'package:ecommmerce_app/constants.dart';
import 'package:ecommmerce_app/core/navigator/generate_route.dart';
import 'package:ecommmerce_app/core/viewmodels/CRUDModelOfProduct.dart';
import 'package:ecommmerce_app/core/viewmodels/my_provider.dart';
import 'package:ecommmerce_app/ui/widgets/custom_input.dart';
import 'package:ecommmerce_app/ui/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchTab extends StatefulWidget {
  @override
  _SearchTabState createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  String _searchString = "";

  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<CRUDModelOfProduct>(context);
    final myProvider = Provider.of<MyProvider>(context);
    return Stack(
      children: [
        if (_searchString.isNotEmpty)
          FutureBuilder(
            future: _provider.searchProducts(_searchString),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Container(
                  child: Center(child: Text("Error:" + snapshot.error)),
                );
              }
              if (snapshot.connectionState == ConnectionState.done) {
                return Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: ListView(
                    padding: EdgeInsets.only(top: 100.0),
                    children: snapshot.data.map<Widget>(
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
                  ),
                );
              }
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          )
        else
          Center(
            child: Text(
              "Search Results",
              style: Constants.regularDarkText,
            ),
          ),
        Padding(
          padding: const EdgeInsets.only(top: 45.0, left: 4, right: 4),
          child: CustomInput(
            onSubmitted: (value) {
              setState(() {
                _searchString = value;
              });
            },
            hintText: "Search here ...",
          ),
        ),
      ],
    );
  }
}
