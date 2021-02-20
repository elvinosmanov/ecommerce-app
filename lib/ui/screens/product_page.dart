import 'package:ecommmerce_app/constants.dart';
import 'package:ecommmerce_app/core/services/firebase_services.dart';
import 'package:ecommmerce_app/core/viewmodels/my_provider.dart';
import 'package:ecommmerce_app/ui/widgets/custom_action_bar.dart';
import 'package:ecommmerce_app/ui/widgets/custom_button.dart';
import 'package:ecommmerce_app/ui/widgets/image_swipe.dart';
import 'package:ecommmerce_app/ui/widgets/product_size.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key key}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  FirebaseServices _firebaseServices = FirebaseServices();
  String selectedSize = "0";
  bool hasAddedToCart = false;
  bool btnLoading = false;
  bool firstTime = true;
  @override
  Widget build(BuildContext context) {
    final myProvider = Provider.of<MyProvider>(context);
    if (firstTime) {
      selectedSize = myProvider.product.sizes[0];
    }
    void addToCart() async {
      setState(() {
        btnLoading = true;
      });
      await _firebaseServices.usersRef
          .doc(_firebaseServices.getUserId())
          .collection('Cart')
          .doc(myProvider.product.id)
          .set({"size": selectedSize});
      setState(() {
        btnLoading = false;
      });
    }

    void addToSaved() async {
      await _firebaseServices.usersRef
          .doc(_firebaseServices.getUserId())
          .collection('Saved')
          .doc(myProvider.product.id)
          .set({"size": selectedSize});
    }

    return Scaffold(
        body: Stack(
      children: [
        ListView(children: [
          ImageSwipe(
            imageList: myProvider.product.images,
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 24.0, left: 24.0, right: 24.0, bottom: 4.0),
            child: Text(
              myProvider.product.name ?? 'Product name',
              style: Constants.boldHeading,
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 4.0, horizontal: 24.0),
            child: Text(
              '\$${myProvider.product.price}' ?? 'Product price',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).accentColor,
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
            child: Text(
              myProvider.product.description ?? 'Description',
              style: TextStyle(fontSize: 16.0),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 24.0, horizontal: 24.0),
            child: Text('Select Size', style: Constants.regularDarkText),
          ),
          ProductSize(
            sizeList: myProvider.product.sizes,
            onSelected: (String num) {
              selectedSize = num;
            },
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Row(
              children: [
                Builder(
                  builder: (context) => GestureDetector(
                    onTap: () {
                      addToSaved();
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Saved successfully'),
                        ),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 24),
                      width: 65.0,
                      height: 65.0,
                      decoration: BoxDecoration(
                        color: Color(0xFFDCDCDC),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      alignment: Alignment.center,
                      child: Image.asset(
                        'assets/images/tab_saved.png',
                        height: 22.0,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Builder(
                    builder: (context) {
                      return CustomButton(
                        isLoading: btnLoading,
                        onPressed: () async {
                          addToCart();
                          Scaffold.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Cart Added successfully'),
                            ),
                          );
                        },
                        text: hasAddedToCart ? 'Added To Cart' : 'Add To Cart',
                        outlineBtn: false,
                      );
                    },
                  ),
                ),
              ],
            ),
          )
        ]),
        CustomActionBar(
          hasBackground: false,
          hasBackArrow: true,
          hasTitle: false,
        )
      ],
    ));
  }
}
