import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class FullScreenImagePage extends StatelessWidget {
  FullScreenImagePage({this.img});

  final String img;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: true,
      ),
      body: Center(
        child: image(context),
      ),
    );
  }

  Widget image(context) {
    return GestureDetector(
      child: Hero(
        tag: 'imageCVP',
        child: PhotoView(
          imageProvider: NetworkImage(this.img),
        ),
      ),
    );
  }
}
