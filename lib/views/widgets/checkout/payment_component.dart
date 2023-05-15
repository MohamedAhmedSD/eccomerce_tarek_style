import 'package:flutter/material.dart';

import '../../../utilities/assets.dart';

class PaymentComponent extends StatelessWidget {
  const PaymentComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //* just a row of img and text
    return Row(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(16.0)),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Image.network(
              AppAssets.mc,
              // AppAssets.mastercardIcon,
              fit: BoxFit.cover,
              height: 30,
            ),
          ),
        ),
        const SizedBox(width: 16.0),
        const Text('**** **** **** 2718'),
      ],
    );
  }
}
