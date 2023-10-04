import 'package:flutter/material.dart';
import 'package:todo/myTheme.dart';

class TextFormShape extends StatelessWidget {
  String? Function(String?) validation;

  TextEditingController controllertext;
  static bool ofsecure = true;
  IconButton? icon;
  TextInputType keyboard;
  bool secure;

  String text;

  TextFormShape(
      {required this.text,
      this.keyboard = TextInputType.text,
      this.secure = false,
      this.icon,
      required this.controllertext,
      required this.validation});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        decoration: InputDecoration(
          suffixIcon: icon,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide(color: MyTheme.primaryLight, width: 3)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(width: 7, color: MyTheme.primaryLight),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(width: 3, color: MyTheme.primaryLight),
          ),
          label: Text(text),
          labelStyle:
              Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 17),
          //hintText: text,
          //hintStyle: Theme.of(context).textTheme.titleMedium,
        ),
        keyboardType: keyboard,
        obscureText: secure,
        controller: controllertext,
        validator: validation,
      ),
    );
  }
}
