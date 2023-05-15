import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../controllers/database_controller.dart';
import '../../../models/add_to_cart_model.dart';
import '../../../utilities/routes.dart';
import '../../widgets/cart_list_item.dart';
import '../../widgets/main_button.dart';
import '../../widgets/order_summary_component.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  //* our total price start from 0
  int totalAmount = 0;

  //* it called after call build widget. recall with every update
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    //* use provider out to builder
    //* listen to stream of list => inside it items of list
    final myProducts = await Provider.of<Database>(context, listen: false)
        .myProductsCart()
        .first;
    //* loop through them
    for (var element in myProducts) {
      //* updata prices part
      setState(() {
        totalAmount += element.price;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //* use DB controller
    final database = Provider.of<Database>(context);

    return SafeArea(
      child: StreamBuilder<List<AddToCartModel>>(
          //* we view only that on my cart
          stream: database.myProductsCart(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              //* we need reach to our cartItems
              //* List<AddToCartModel>? cartItems
              final cartItems = snapshot.data;
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //? search icon ====================================
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox.shrink(), //! shrink sizebox
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.search),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16.0),
                      //? ============= [ title ] ==============
                      Text(
                        'My Cart',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                      ),
                      const SizedBox(height: 16.0),
                      //?============== [if no data add to cart] ==================
                      if (cartItems == null || cartItems.isEmpty)
                        Center(
                          child: Text(
                            'No Data Available!',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                      //?============== [if there are data add to cart] ==================
                      if (cartItems != null && cartItems.isNotEmpty)
                        ListView.builder(
                          itemCount: cartItems.length,
                          //* to avoid error ListView with Verticl view
                          //* because it not have certain size and take its children size
                          shrinkWrap: true,
                          //* its scrollable, and page itself has scrolle
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int i) {
                            //* I make widget accepting our cartItem data model
                            final cartItem = cartItems[i];
                            //* also update total price

                            //! don't use setState inside builder or streamBuilder
                            // setState(() {
                            // totalAmount = cartItem.price;
                            // });
                            //* complete the widget
                            return CartListItem(
                              cartItem: cartItem,
                            );
                          },
                        ),
                      const SizedBox(height: 24.0),
                      //? ================ total amount ==================
                      //* [1]
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     //! we can use stream here to deal with price only
                      //     //! you can call it with initstate => only once call
                      //     //! our didChangeDependancies => with every rebuild recall
                      //     Text(
                      //       'Total Amount:',
                      //       style: Theme.of(context)
                      //           .textTheme
                      //           .titleMedium!
                      //           .copyWith(
                      //             color: Colors.grey,
                      //           ),
                      //     ),
                      //     Text(
                      //       '$totalAmount\$',
                      //       style: Theme.of(context).textTheme.titleLarge,
                      //     ),
                      //   ],
                      // ),
                      // const SizedBox(height: 32.0),

                      //* [2]
                      OrderSummaryComponent(
                        title: 'Total Amount',
                        value: totalAmount.toString(),
                      ),
                      const SizedBox(height: 32.0),
                      //? ================ checkout btn ==================
                      MainButton(
                        text: 'Checkout',
                        //* we use rootNavigator
                        onTap: () => Navigator.of(context, rootNavigator: true)
                            .pushNamed(
                          AppRoutes.checkoutPageRoute,
                          arguments: database,
                        ),
                        hasCircularBorder: true,
                      ),
                      const SizedBox(height: 32.0),
                    ],
                  ),
                ),
              );
            }
            //? =========== waiting till data come =====================
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
