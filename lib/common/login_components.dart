import 'package:flutter/material.dart';

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  bool isPassword = false,
  String? Function(String?)? validate,
  String? label,
  IconData? prefix,
  required Color colors,
  IconData? suffix,
  VoidCallback? suffixPressed,
  VoidCallback? onTab,
  bool enable = true,
  onSaved,
  void Function(String)? onChanged,

}) => TextFormField(
  controller: controller,
  keyboardType: type,
  obscureText: isPassword,
  validator: validate,
  enabled: enable,
  onSaved: onSaved,
  onTap: onTab,
  onChanged: onChanged,

  decoration: InputDecoration(
    labelText: label,
    labelStyle: TextStyle(
        color: colors,
        fontSize: 15.0,
        fontWeight: FontWeight.bold),
    prefixIcon: prefix != null ? Icon (prefix, color: colors, size: 20.0) : null,
    suffixIcon:  suffix != null ? IconButton(
        onPressed: suffixPressed,
        icon : Icon(suffix), color: colors, iconSize: 20.0) : null ,
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide:  BorderSide(color: colors, width: 1.0) ),
    errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide:  const BorderSide(color: Colors.red, width: 1.0)),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(color: Colors.blueGrey, width: 1.0)),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(color: Colors.blue, width: 1.0)),
    focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(color: Colors.red, width: 1.0)),
    errorStyle: const TextStyle(color: Colors.red),

  ),
);