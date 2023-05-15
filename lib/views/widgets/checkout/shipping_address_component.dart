import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controllers/database_controller.dart';
import '../../../models/shipping_address.dart';
import '../../../utilities/routes.dart';

class ShippingAddressComponent extends StatelessWidget {
  //* we need use ShippingAddress model
  final ShippingAddress shippingAddress;
  const ShippingAddressComponent({
    Key? key,
    required this.shippingAddress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<Database>(context);

    //* we use card to display name nd address
    //* we can make another page to add these data
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  shippingAddress.fullName,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                InkWell(
                  onTap: () => Navigator.of(context).pushNamed(
                    AppRoutes.shippingAddressesRoute,
                    arguments: database,
                  ),
                  child: Text(
                    'Change',
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: Colors.redAccent,
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Text(
              shippingAddress.address,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              '${shippingAddress.city}, ${shippingAddress.state}, ${shippingAddress.country}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}
