// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

// customized btn
// text && function
class MainButton extends StatelessWidget {
  final String text;
  final bool hasCircularBorder;

  final VoidCallback onTap;
  // final void Function()? onTap;

  const MainButton({
    Key? key,
    required this.text,
    this.hasCircularBorder = false,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // use SizedBox is better with size than Container
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).primaryColor,
          // foregroundColor: Theme.of(context).primaryColor,
          shape: hasCircularBorder
              ? RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.0),
                )
              : null,
        ),
        child: Text(
          text,
        ),
      ),
    );
  }
}
