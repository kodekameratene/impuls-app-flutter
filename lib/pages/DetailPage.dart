import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
      ),
      body: Column(
        children: <Widget>[
          Container(
            color: Colors.amber,
            child: Image.network(
              'http://impulsweb.genialt.no/wp-content/uploads/2015/11/Impuls_2013_AlexanderSolheim_57-1024x682.jpg',
            ),
          ),
        ],
      ),
    );
  }
}
