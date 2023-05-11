import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

//! make Svg image clickable
class SocialMediaButton extends StatelessWidget {
  const SocialMediaButton({
    Key? key,
    required this.iconName,
    required this.onPress,
  }) : super(key: key);
  final String iconName;
  final VoidCallback onPress;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        //* container = Svg.P * 2
        // height: 80,
        // width: 80,
        height: 60,
        width: 60,
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
