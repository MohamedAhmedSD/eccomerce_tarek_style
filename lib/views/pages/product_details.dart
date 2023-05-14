import 'package:day1/utilities/dimenssions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
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
      //! how I can change icon of back when use navigation
      appBar: AppBar(
        //* change appBar height
        toolbarHeight: AppMediaQuery.getHeight(context, 35),
        //? we can change appBar background && opacity also from here
        title: Text(
          //! call arrgs that inject from constructor, from route page
          widget.product
              .title, //* when access through stf, you must start with widget.
          // product.title, //* when access through stl
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontSize: AppMediaQuery.getHeight(context, 14),
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        //! we can edit appbar color from here or from main file
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.share,
              size: AppMediaQuery.getHeight(context, 20),
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
              height: size.height * 0.50, // 0.55
              // fit: BoxFit.cover,
              fit: BoxFit.fill,
            ),
            SizedBox(height: AppMediaQuery.getHeight(context, 20)),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppMediaQuery.getWidth(context, 16),
                vertical: AppMediaQuery.getHeight(context, 2),
              ),
              //?============= sizes , favorite btn ============================
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      //*============= sizes ============================
                      DropDownMenuComponent(
                        items: const ['S', 'M', 'L', 'XL', 'XXL'],
                        hint: 'Size',
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownValue = newValue!;
                          });
                        },
                      ),
                      SizedBox(
                        width: AppMediaQuery.getWidth(context, 30),
                      ),
                      //*============= colors ============================
                      SizedBox(
                        height: AppMediaQuery.getHeight(context, 30),
                        width: AppMediaQuery.getWidth(context, 130),
                        child: DropDownMenuComponent(
                          items: const [
                            'black',
                            'yellow',
                            'blue',
                            'white',
                            'grey'
                          ],
                          hint: 'colors',
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownValue = newValue!;
                            });
                          },
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
                          height: AppMediaQuery.getHeight(context, 30),
                          width: AppMediaQuery.getWidth(context, 30),
                          child: DecoratedBox(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: Center(
                              child: Icon(
                                isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border_outlined,
                                color: isFavorite
                                    ? Colors.redAccent
                                    : Colors.black45,
                                size: AppMediaQuery.getHeight(context, 20),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: AppMediaQuery.getHeight(context, 10)),
                  //?============= title && price ============================
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.product.title,
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: AppMediaQuery.getHeight(context, 16),
                            ),
                      ),
                      Text(
                        '\$${widget.product.price}',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: AppMediaQuery.getHeight(context, 16),
                            ),
                      ),
                    ],
                  ),
                  SizedBox(height: AppMediaQuery.getHeight(context, 2)),
                  //?============= category && details ============================
                  Text(
                    widget.product.category,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Colors.black54,
                          fontSize: AppMediaQuery.getHeight(context, 14),
                        ),
                  ),
                  SizedBox(height: AppMediaQuery.getHeight(context, 2)),
                  Row(
                    children: [
                      //? =========== rating, price & details ===================
                      //! how we use rating bar
                      RatingBarIndicator(
                        itemSize: AppMediaQuery.getHeight(context, 14),
                        //! its double not int
                        rating: widget.product.rate?.toDouble() ?? 4.0,
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
                        // '(100)',
                        widget.product.price.toString(),
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: Colors.grey,
                              fontSize: AppMediaQuery.getHeight(context, 10),
                            ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: AppMediaQuery.getHeight(context, 10),
                  ),
                  Text(
                    'This is a dummy description for this product! I think we will add it in the future! I need to add more lines, so I add these words just to have more than two lines!',
                    style: Theme.of(context).textTheme.bodyLarge,
                    maxLines: 4,
                    // overflow: ,
                  ),
                  SizedBox(height: AppMediaQuery.getHeight(context, 20)),

                  //?============= add btn ============================
                  MainButton(
                    text: 'Add to cart',
                    //! pass our chooce into DB
                    onTap: () => _addToCart(database),
                    hasCircularBorder: true,
                  ),
                  SizedBox(height: AppMediaQuery.getHeight(context, 20)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
