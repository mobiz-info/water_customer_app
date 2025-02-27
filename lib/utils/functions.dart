import 'package:flutter/material.dart';

String getImageUrl(String productName) {
  print(productName);
  switch (productName.toLowerCase()) {
    case '5 gallon':
      return 'Assets/Images/Watercan.png';
    case 'dispenser':
      return 'Assets/Images/Home/custody/dispenser.png';
    case 'electronic pump':
      return 'Assets/Images/noImage.jpg';
    case 'hand pump':
      return 'Assets/Images/noImage.jpg';
    case 'hot and cold dispenser':
      return 'Assets/Images/Home/custody/dispenser.png';
    case 'second hand cooler':
      return 'Assets/Images/noImage.jpg';
    case 'pet (250ml x 24) - 1ctn':
      return 'Assets/Images/Home/outstanding/pet.webp';

    case 'table dispenser':
      return 'Assets/Images/Home/custody/dispenser.png';
    // Add more cases as needed
    default:
      return 'Assets/Images/noImage.jpg'; // A default image for unknown products
  }
}
bool isLandscape(BuildContext context) {
  return MediaQuery.of(context).orientation == Orientation.landscape;
}
