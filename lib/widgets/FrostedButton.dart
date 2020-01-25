import 'package:flutter/material.dart';

class FrostedButton extends StatelessWidget {
  final Function onTap;

  FrostedButton({@required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(color: Colors.white30),
      child: InkWell(
        onTap: this.onTap,
        child: Container(
            padding: EdgeInsets.all(10), child: Text('Fetch Arrangements')),
      ),
    );
  }
}
