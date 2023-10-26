import 'package:flutter/material.dart';

double getProportionateScreenHeight(context,double inputHeight) {
  double screenHeight = MediaQuery.of(context).size.height;
  // 812 is the layout height that designer use
  return (inputHeight / screenHeight) * screenHeight;
}

// Get the proportionate height as per screen size
double getProportionateScreenWidth(context,double inputWidth) {
  double screenWidth = MediaQuery.of(context).size.width;
  // 375 is the layout width that designer use
  return (inputWidth / screenWidth) * screenWidth;
}