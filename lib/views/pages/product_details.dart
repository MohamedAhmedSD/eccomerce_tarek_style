
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/database_controller.dart';
import '../../models/add_to_cart_model.dart';
import '../../models/product.dart';
import '../../utilities/constants.dart';
import '../widgets/drop_down_menu.dart';
import '../widgets/main_button.dart';
import '../widgets/main_dialog.dart';

class ProductDetails extends StatefulWidget {
  final Product product;
  const ProductDetails({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  //? deal with favorite => change icon when press beside go to opposite status
  bool isFavorite = false;
  late String dropdownValue;

  //? =========== _addToCart method =======================
  //! function of add to cart => future
  Future<void> _addToCart(Database database) async {
    try {
      //* it use model to access data then add them to firestore
      final addToCartProduct = AddToCartModel(
        id: documentIdFromLocalData(),
        title: widget.product.title,
        price: widget.product.price,
        productId: widget.product.id,
        imgUrl: widget.product.imgUrl,
        size: dropdownValue,
      );
      //* pass it to FS ===============================
      await database.addToCart(addToCartProduct);
    } catch (e) {
      return MainDialog(
        context: context,
        title: 'Error',
        content: 'Couldn\'t adding to the cart, please try again!',
      ).showAlertDialog();
    }
  }

  @override
  Widget build(BuildContext context) {
    //?============= provider && MQ ============================
    final size = MediaQuery.of(context).size;
    final Database database = Provider.of<Database>(context); // accsess db

    //?============= provider && MQ && appBar ============================
    return Scaffold(
      appBar: AppBar(
        //? we can change appBar background && opacity also from here
        title: Text(
          //! call arrgs that inject from constructor, from route page
          widget.product
              .title, //* when access through stf, you must start with widget.
          // product.title, //* when access through stl
          style: Theme.of(context).textTheme.titleLarge,
        ),
        //! we can edit appbar color from here or from main file
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.share,
            ),
          ),
        ],
      ),
      //?============= image ============================
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              widget.product.imgUrl,
              width: double.infinity,
              height: size.height * 0.8, // 0.55
              fit: BoxFit.cover,
              // fit: BoxFit.fill,
            ),
            const SizedBox(height: 8.0),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              //?============= sizes , favorite btn ============================
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //*============= sizes ============================
                      Expanded(
                        child: SizedBox(
                          height: 60,
                          child: DropDownMenuComponent(
                            items: const ['S', 'M', 'L', 'XL', 'XXL'],
                            hint: 'Size',
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownValue = newValue!;
                              });
                            },
                          ),
                        ),
                      ),
                      const Spacer(),
                      //*============= favorie btn ============================
                      InkWell(
                        onTap: () {
                          setState(() {
                            //! opposite=======
                            isFavorite = !isFavorite;
                          });
                        },
                        child: SizedBox(
                          height: 60,
                          width: 60,
                          child: DecoratedBox(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border_outlined,
                                color: isFavorite
                                    ? Colors.redAccent
                                    : Colors.black45,
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24.0),
                  //?============= title && price ============================
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.product.title,
                        style:
                            Theme.of(context).textTheme.headlineSmall!.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                      ),
                      Text(
                        '\$${widget.product.price}',
                        style:
                            Theme.of(context).textTheme.headlineSmall!.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  //?============= category && details ============================
                  Text(
                    widget.product.category,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Colors.black54,
                        ),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    'This is a dummy description for this product! I think we will add it in the future! I need to add more lines, so I add these words just to have more than two lines!',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 24.0),
                  //?============= add btn ============================
                  MainButton(
                    text: 'Add to cart',
                    //! pass our chooce into DB
                    onTap: () => _addToCart(database),
                    hasCircularBorder: true,
                  ),
                  const SizedBox(height: 32.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
