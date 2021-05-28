import 'package:flutter/material.dart';

class MediaSocialIcon extends StatelessWidget {
  const MediaSocialIcon({Key key, this.facebook, this.google})
      : super(key: key);

  final Function facebook;
  final Function google;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SocialMediaIcon(
          asset: 'assets/icons/google.png',
          iconColor: Colors.red,
          onTap: facebook,
        ),
        SocialMediaIcon(
          asset: 'assets/icons/facebook.png',
          iconColor: Colors.blue,
          onTap: google,
        ),
      ],
    );
  }
}

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
