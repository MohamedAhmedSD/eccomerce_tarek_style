import 'package:flutter/material.dart';

import '../order_summary_component.dart';

class CheckoutOrderDetails extends StatelessWidget {
  const CheckoutOrderDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //* to make bottom part of the checkout page
    return Column(
      children: const [
        OrderSummaryComponent(title: 'Order', value: '125\$'),
        SizedBox(height: 8.0),
        OrderSummaryComponent(title: 'Delivery', value: '15\$'),
        SizedBox(height: 8.0),
        OrderSummaryComponent(title: 'Summary', value: '140\$'),
      ],
    );
  }
}
