import 'package:ecommmerce_app/constants.dart';
import 'package:ecommmerce_app/core/services/firebase_services.dart';
import 'package:ecommmerce_app/ui/widgets/custom_action_bar.dart';
import 'package:ecommmerce_app/ui/widgets/custom_button.dart';
import 'package:ecommmerce_app/ui/widgets/image_swipe.dart';
import 'package:ecommmerce_app/ui/widgets/product_size.dart';
import 'package:flutter/material.dart';

class ProductPage extends StatefulWidget {
  final Map productData;
  final String productId;

  const ProductPage({Key key, this.productId, this.productData})
      : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  FirebaseServices _firebaseServices = FirebaseServices();
  bool _addToCartBtnLoading = false;

  String selectedSize;
  List productSizeList;
  List imageList;
  bool hasAddedToCart = false;
  @override
  void initState() {
    productSizeList = widget.productData['size'];
    imageList = widget.productData['images'];
    selectedSize = productSizeList[0];

    super.initState();
  }

  void addToCart() async {
    setState(() {
      _addToCartBtnLoading = true;
    });
    await _firebaseServices.usersRef
        .doc(_firebaseServices.getUserId())
        .collection('Cart')
        .doc(widget.productId)
        .set({"size": selectedSize});
    setState(() {
      _addToCartBtnLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        ListView(children: [
          ImageSwipe(
            imageList: imageList,
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 24.0, left: 24.0, right: 24.0, bottom: 4.0),
            child: Text(
              widget.productData['name'] ?? 'Product name',
              style: Constants.boldHeading,
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 4.0, horizontal: 24.0),
            child: Text(
              '\$${widget.productData['price']}' ?? 'Product price',
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
              widget.productData['description'] ?? 'Description',
              style: TextStyle(fontSize: 16.0),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 24.0, horizontal: 24.0),
            child: Text('Select Size', style: Constants.regularDarkText),
          ),
          ProductSize(
            sizeList: productSizeList,
            onSelected: (num) {
              selectedSize = num;
            },
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {},
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
                Expanded(
                  child: Builder(
                    builder: (context) {
                      return CustomButton(
                        isLoading: _addToCartBtnLoading,
                        onPressed: () async {
                          addToCart();
                          Scaffold.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Saved successfully'),
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
