import 'package:flutter/material.dart';

class MyButton extends StatefulWidget {
  final String child;
  final VoidCallback onTap;

  MyButton({Key? key, required this.child, required this.onTap}) : super(key: key);

  @override
  State<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  var buttonColor = Colors.deepPurple[400];

  var whiteTextStyle = const TextStyle(
      fontWeight: FontWeight.bold, fontSize: 32, color: Colors.white);

  @override
  Widget build(BuildContext context) {

    if(widget.child == 'C') {
      buttonColor = Colors.green;
    } else if (widget.child == 'DEL') {
      buttonColor = Colors.red;
    } else if (widget.child == '=') {
      buttonColor = Colors.deepPurple;
    } else if (widget.child == 'CHECK RESULT') {
      buttonColor = Colors.green;
    } else if (widget.child == 'RESET') {
      buttonColor = Colors.red;
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Center(
            child: Text(
              widget.child,
              style: whiteTextStyle,
            ),
          ),
        ),
      ),
    );
  }
}
