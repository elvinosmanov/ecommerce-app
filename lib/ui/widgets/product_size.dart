import 'package:flutter/material.dart';

class ProductSize extends StatefulWidget {
  final List sizeList;
  final Function(String) onSelected;

  const ProductSize({Key key, this.sizeList, this.onSelected})
      : super(key: key);
  @override
  _ProductSizeState createState() => _ProductSizeState();
}

class _ProductSizeState extends State<ProductSize> {
  int _selectedSize = 0;

  @override
  Widget build(BuildContext context) {
    List _sizeList = widget.sizeList ?? ['0'];
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Row(
        children: <Widget>[
          for (int i = 0; i < _sizeList.length; i++)
            GestureDetector(
              onTap: () {
                setState(() {
                  widget.onSelected("${_sizeList[i]}");
                  _selectedSize = i;
                });
              },
              child: Container(
                margin: EdgeInsets.only(left: 4.0, right: 4.0, bottom: 24.0),
                decoration: BoxDecoration(
                  color: _selectedSize == i
                      ? Theme.of(context).accentColor
                      : Color(0xFFDCDCDC),
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                width: 42.0,
                height: 42.0,
                child: Text(
                  "${_sizeList[i]}",
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: _selectedSize == i ? Colors.white : Colors.black),
                ),
              ),
            )
        ],
      ),
    );
  }
}
