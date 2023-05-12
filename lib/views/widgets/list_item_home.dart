import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../../controllers/database_controller.dart';
import '../../models/product.dart';
import '../../utilities/dimenssions.dart';
import '../../utilities/routes.dart';

class ListItemHome extends StatelessWidget {
  final Product product;
  final bool isNew;
  final VoidCallback? addToFavorites;
  final bool isFavorite; //? I make it final
  const ListItemHome({
    //? I make it const
    Key? key,
    required this.product,
    required this.isNew,
    this.addToFavorites,
    this.isFavorite = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //* MQ
    // final size = MediaQuery.of(context).size;
    final database = Provider.of<Database>(context);

    //* able to click
    //? InkWell => Stack =>
    return InkWell(
      //? =========== rootVavigator =====================================
      //! look at Nav here
      //* rootNavigator, when nav with bottom navBar
      //* we need tell it, Nav here seprated from that on navBar
      //? new page not depend on it

      onTap: () => Navigator.of(context, rootNavigator: true)
          .pushNamed(AppRoutes.productDetailsRoute,
              //! we send data when nav, we recive it on route first
              arguments: {
            'product': product,
            'database': database,
          }),
      //? =========== stack =====================================
      //! look at Nav here
      child: Stack(
        children: [
          //? =========== stack =====================================
          Stack(
            children: [
              //? =========== build card of project ======================
              //* =========== Image =====================================
              ClipRRect(
                borderRadius:
                    BorderRadius.circular(AppMediaQuery.getHeight(context, 4)),
                child: Image.network(
                  product.imgUrl,
                  // width: 200,
                  // height: 200,
                  width: AppMediaQuery.getWidth(context, 140),
                  height: AppMediaQuery.getHeight(context, 160),
                  fit: BoxFit.cover,
                  // color: Colors.grey,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(AppMediaQuery.getHeight(context, 8)),
                child: SizedBox(
                  width: AppMediaQuery.getWidth(context, 40),
                  height: AppMediaQuery.getHeight(context, 20),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          AppMediaQuery.getHeight(context, 16)),
                      color: isNew ? Colors.black : Colors.red,
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.all(AppMediaQuery.getHeight(context, 2)),
                      child: Center(
                        child: Text(
                          //* ========== New or have discount ================
                          isNew ? 'NEW' : '${product.discountValue}%',
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: Colors.white,
                                  ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          //? =========== add to favorite =====================================
          Positioned(
            // left: size.width * 0.29,
            // bottom: size.height * 0.1,
            left: AppMediaQuery.getWidth(context, 104.4),
            bottom: AppMediaQuery.getHeight(context, 64.0),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    blurRadius: AppMediaQuery.getHeight(context, 5),
                    color: Colors.grey,
                    spreadRadius: AppMediaQuery.getHeight(context, 2),
                  )
                ],
              ),
              //! add to favorite
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: AppMediaQuery.getHeight(context, 16),
                child: InkWell(
                  onTap: addToFavorites,
                  child: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_outline,
                    size: AppMediaQuery.getHeight(context, 16),
                    color: isFavorite ? Colors.red : Colors.grey,
                  ),
                ),
              ),
            ),
          ),
          //? =========== rating =====================================
          Positioned(
            // bottom: AppMediaQuery.getHeight(context, 5),
            bottom: AppMediaQuery.getHeight(context, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    //? =========== rating, price & details ===================
                    //! how we use rating bar
                    RatingBarIndicator(
                      itemSize: AppMediaQuery.getHeight(context, 14),
                      //! its double not int
                      rating: product.rate?.toDouble() ?? 4.0,
                      // rating: 4.0,
                      itemCount: 5, //* it default 5

                      //! we cann't change icon color if not choose unrated color
                      unratedColor: Colors.grey,
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        //* first use unrated color to apply changes to icon color
                        color: Colors.amber,
                      ),
                      direction: Axis.horizontal,
                    ),
                    Text(
                      '(100)',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Colors.grey,
                            fontSize: AppMediaQuery.getHeight(context, 10),
                          ),
                    ),
                  ],
                ),
                Text(
                  product.category,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Colors.grey,
                        fontSize: AppMediaQuery.getHeight(context, 10),
                      ),
                ),
                // const SizedBox(height: 4.0),
                Text(
                  product.title,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.w900,
                        fontSize: AppMediaQuery.getHeight(context, 14),
                        letterSpacing: AppMediaQuery.getHeight(context, 1),
                      ),
                ),
                // const SizedBox(height: 4.0),
                isNew
                    ? Text(
                        '${product.price}\$',
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: Colors.grey,
                            fontSize: AppMediaQuery.getHeight(context, 10)),
                      )
                    : Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: '${product.price}\$  ',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                    color: Colors.grey,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                            ),
                            TextSpan(
                              text:
                                  '  ${product.price * (product.discountValue!) / 100}\$',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                    color: Colors.red,
                                  ),
                            ),
                          ],
                        ),
                      ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
