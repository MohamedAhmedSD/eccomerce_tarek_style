import 'package:day1/utilities/dimenssions.dart';
import 'package:flutter/material.dart';

class HeaderOfList extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final String description;
  const HeaderOfList({
    Key? key,
    required this.title,
    required this.description,
    this.onTap,
  }) : super(key: key);
  //! T-shirt             view all[on tap text]
  //! it ........................
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: AppMediaQuery.getHeight(context, 28),
                    letterSpacing: 2,
                  ),
            ),
            InkWell(
              onTap: onTap,
              child: Text(
                'View All',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontSize: AppMediaQuery.getHeight(context, 12)),
              ),
            ),
          ],
        ),
        //! description out from Row =============================
        Text(
          description,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Colors.grey,
                fontSize: AppMediaQuery.getHeight(context, 12),
              ),
        ),
      ],
    );
  }
}
