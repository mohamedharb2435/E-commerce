import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SocialMediaButton extends StatelessWidget {
  const SocialMediaButton({
    super.key,
    required this.iconName,
    required this.onPress,
  });
  final String iconName;
  final VoidCallback onPress;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        height: 80,
        width: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: Colors.white,
        ),
        child: Center(
          child: SvgPicture.asset(
            iconName,
            width: 40.0,
            height: 40.0,
          ),
        ),
      ),
    );
  }
}