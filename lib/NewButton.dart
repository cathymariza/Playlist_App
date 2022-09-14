import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class NewButton extends StatelessWidget{

  NewButton({required this.onPressed});

  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return new RawMaterialButton(
      fillColor: Colors.blueGrey,
      splashColor: Colors.grey,
      shape: const StadiumBorder(),
      onPressed: onPressed,
      child: Text("NEXT")
      ); 
  }

}