import 'package:flutter/material.dart';

class ShippingAddressComponent extends StatelessWidget {
  const ShippingAddressComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  'Tarek Alabd',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                InkWell(
                  onTap: () {},
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
              '13 Mossaddak Street',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              'Dokki, Giza, Egypt',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}
