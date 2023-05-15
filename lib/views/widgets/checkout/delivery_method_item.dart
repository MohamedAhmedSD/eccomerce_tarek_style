import 'package:flutter/material.dart';

import '../../../models/delivery_method.dart';

class DeliveryMethodItem extends StatelessWidget {
  //* we use DeliveryMethod class to access its properties to make this widget
  //* so when call it we need make an object from DeliveryMethod first to pass its 
  //* properties to DeliveryMethodItem
  final DeliveryMethod deliveryMethod;
  const DeliveryMethodItem({
    Key? key,
    required this.deliveryMethod,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        //* images with delivery days expected
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.network(
            deliveryMethod.imgUrl,
            fit: BoxFit.cover,
            // fit: BoxFit.fill,
            height: 20,
            width: 40,
          ),
          const SizedBox(height: 6.0),
          Text(
            '${deliveryMethod.days} days',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ]),
      ),
    );
  }
}
