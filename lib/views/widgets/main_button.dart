import 'package:flutter/material.dart';

// customized btn
// text && function
class MainButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  // final void Function()? onTap;

  const MainButton({
    Key? key,
    required this.text,
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
        ),
        child: Text(
          text,
        ),
      ),
    );
  }
}
