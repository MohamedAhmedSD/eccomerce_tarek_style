import 'package:flutter/material.dart';

//? customized btn
//* text && function
//! with choice to add border or not to it ================================

class MainButton extends StatelessWidget {
  final String text;
  final bool hasCircularBorder;
  final VoidCallback onTap; //? or use => final void Function()? onTap;

  const MainButton({
    Key? key,
    required this.text,
    this.hasCircularBorder = false,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //* use SizedBox is better with size [H && W] more than Container
    return SizedBox(
      //* always width take size as possible but height should be determain
      width: double.infinity,
      // height: 50,
      height: 40,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).primaryColor,
          // foregroundColor: Theme.of(context).primaryColor,
          //! how we add border or not
          //? we need add border to btn on =>
          shape: hasCircularBorder
              ? RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.0),
                )
              : null,
        ),
        child: Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
    );
  }
}
