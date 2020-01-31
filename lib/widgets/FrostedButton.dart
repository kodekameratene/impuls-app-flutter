import 'package:flutter/material.dart';

class FrostedButton extends StatelessWidget {
  final Function onTap;
  final String text;

  FrostedButton({@required this.onTap, @required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(color: Colors.white30),
      child: InkWell(
        onTap: this.onTap,
        child: Container(padding: EdgeInsets.all(10), child: Text('$text')),
      ),
    );
  }
}
