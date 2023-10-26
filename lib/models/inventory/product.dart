import 'package:flutter/material.dart';

class Product {
  final String productCode;
  final String productNameAra;
  final String productNameEng;
  final double price;
  final int UnitCode;
  final String  UnitName;
  final String image;
  bool isNotActive;

  final IconData icon;
  final Color color;
  final Color nextColor;

  Product(this.productCode, this.productNameAra, this.productNameEng,
      this.price,this.UnitCode,this.UnitName,this.image,this.isNotActive,this.color,this.nextColor,this.icon);
}
