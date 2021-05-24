import 'package:flutter/material.dart';

class SocialMediaIcon extends StatelessWidget {
  final String asset;
  final Color iconColor;
  final Function onTap;
  final double imageHeight;
  final double imageWidth;

  const SocialMediaIcon(
      {Key key,
      @required this.asset,
      this.iconColor = Colors.white,
      @required this.onTap,
      this.imageHeight = 16,
      this.imageWidth = 16})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: Colors.white,
          ),
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: Image.asset(
          asset,
          color: iconColor,
          height: imageHeight,
          width: imageWidth,
        ),
      ),
    );
  }
}
