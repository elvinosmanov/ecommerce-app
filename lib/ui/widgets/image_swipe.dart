import 'package:flutter/material.dart';

class ImageSwipe extends StatefulWidget {
  final List imageList;

  const ImageSwipe({Key key, this.imageList}) : super(key: key);
  @override
  _ImageSwipeState createState() => _ImageSwipeState();
}

class _ImageSwipeState extends State<ImageSwipe> {
  int _selectedPage = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400.0,
      child: Stack(
        children: [
          PageView.builder(
            onPageChanged: (num) {
              setState(() {
                _selectedPage = num;
              });
            },
            itemCount: widget.imageList.length,
            itemBuilder: (context, index) {
              return Image.network(
                widget.imageList[index],
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    child: Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes
                            : null,
                      ),
                    ),
                  );
                },
              );
            },
          ),
          Positioned(
            bottom: 16.0,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                for (var i = 0; i < widget.imageList.length; i++)
                  AnimatedContainer(
                    curve: Curves.easeOutCubic,
                    duration: Duration(milliseconds: 300),
                    margin: EdgeInsets.all(4.0),
                    width: _selectedPage == i ? 35.0 : 10.0,
                    height: 10.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.black.withOpacity(0.5),
                    ),
                  )
              ],
            ),
          )
        ],
      ),
    );
  }
}
