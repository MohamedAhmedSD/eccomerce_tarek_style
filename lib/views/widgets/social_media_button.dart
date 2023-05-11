import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utilities/dimenssions.dart';

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
    // var height = MediaQuery.of(context).size.height;
    // var width = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: onPress,
      child: Container(
        //* container = Svg.P * 2

        // width: 60,
        // height: 60,
        //! use MQ inside same widget
        // width: width / 5.33,
        // height: height / 10.66,
        //! use MQ from other file
        // width: AppMediaQuery.width(context) / 5.33,
        // height: AppMediaQuery.height(context) / 10.66,
        //! use method pass MQ as on from its parameter, and give it our dimenssions
        // width: AppMediaQuery.widgetWidth(context, 6.0),
        // height: AppMediaQuery.widgetHeight(context, 10.66),
        //! use getHeight method , we try make it do calculation automatically
        width: AppMediaQuery.getWidth(context, 60),
        height: AppMediaQuery.getHeight(context, 60),

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: Colors.white,
        ),
        child: Center(
          child: SvgPicture.asset(
            iconName,
            // width: 40.0,
            // height: 40.0,
            //! use MQ inside same widget
            // width: width / 8,
            // height: height / 14.22,
            //! use MQ from other file
            // width: AppMediaQuery.width(context) / 8.0,
            // height: AppMediaQuery.height(context) / 14.22,
            //! use method pass MQ as on from its parameter, and give it our dimenssions
            // width: AppMediaQuery.widgetWidth(context, 9.0),
            // height: AppMediaQuery.widgetHeight(context, 16.0),
            //! use getHeight method , we try make it do calculation automatically
            width: AppMediaQuery.getWidth(context, 40),
            height: AppMediaQuery.getHeight(context, 40),
          ),
        ),
      ),
    );
  }
}
