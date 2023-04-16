import 'package:day1/controllers/database_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/product.dart';
import '../../utilities/assets.dart';
import '../widgets/list_item_home.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  //! make a widget by function way
  /// widget contain title and what under it
  /// we make it here due to we repeat use it here
  /// need refactor later => make class better than pass context
  Widget _buildHeaderOfList(
    // look we use positionsl parameter with named
    // look how we use => BuildContext context, then its constructor
    BuildContext context, {
    required String title,
    VoidCallback? onTap,
    required String description,
  }) {
    // we not use Scaffold => we use it as widget not as full page
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
                  ),
            ),
            InkWell(
              // it need onTap almost to navigate to certain page
              onTap: onTap,
              child: Text(
                'View All',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ],
        ),
        Text(
          description,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Colors.grey,
              ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    //* use stream
    final database = Provider.of<Database>(context);

    return SingleChildScrollView(
      // no Scaffold
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // element above another
          Stack(
            alignment:
                Alignment.bottomLeft, // not good for more than 2 elements
            children: [
              // when we plan we can use Placeholder with Text
              // Placeholder(
              //   fallbackWidth: double.infinity,
              //   fallbackHeight: size.height * 0.3,
              // ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(
              //       horizontal: 24.0, vertical: 16.0),
              //   child: Text(
              //     "Street Clothes",
              //     style: Theme.of(context).textTheme.headline4,
              //   ),
              // ),
              Image.network(
                AppAssets.store,
                width: double.infinity,
                height: size.height * 0.3,
                // use fit
                fit: BoxFit.cover,
              ),
              // opacity to better image overlay make better contrast with Text
              Opacity(
                opacity: 0.3,
                child: Container(
                  width: double.infinity,
                  height: size.height *
                      0.3, // same height as image which will be under him
                  color: Colors.black,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 16.0),
                child: Text(
                  'Street Clothes',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24.0),
          // we make padding under Stack
          // avoid listTile and extra size problems
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                _buildHeaderOfList(
                  context,
                  title: 'Sale',
                  description: 'Super Summer Sale!!',
                ),
                const SizedBox(height: 8.0),
                // if we use ListView.builder
                // it need context => we not need it _, and index
                // ListView.builder(itemBuilder: (_, int index {
                // })),
                // not good practice column inside list
                SizedBox(
                    height: 300,
                    //! wrap our product list with => StreamBuilder
                    child: StreamBuilder<List<Product>>(
                        stream: database.salesProductsStream(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.active) {
                            // call product from firestore
                            final products = snapshot.data;
                            // handle data
                            if (products == null || products.isEmpty) {
                              return const Text("No data available");
                            }
                            //! ** two ways **
                            //? [1] ListView
                            // return ListView(
                            //   // scrollDirection
                            //   scrollDirection: Axis.horizontal,
                            //   //! how we display list of certain model into certain widget
                            //   //? ourList.map((e) => widget display .toList()),
                            //   // children: dummyProducts

                            //   children: products
                            //       .map(
                            //         // e == element == our product
                            //         (e) => Padding(
                            //           // make space between images
                            //           padding: const EdgeInsets.all(8.0),
                            //           child: ListItemHome(product: e),
                            //         ),
                            //       )
                            //       .toList(), // don't forget toList()
                            // );
                            //? [2] ListView.builder
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: products.length,
                              itemBuilder: (_, int index) => Padding(
                                padding: const EdgeInsets.all(8),
                                child: ListItemHome(
                                  product: products[index],
                                  isNew: true,
                                ),
                              ),
                            );
                          } //! if no data back
                          return const Center(
                              child: CircularProgressIndicator());
                        })),
                // another list
                _buildHeaderOfList(
                  context,
                  title: 'New',
                  description: 'Super New Products!!',
                ),
                const SizedBox(height: 8.0),
                SizedBox(
                  height: 300,
                  child: StreamBuilder<List<Product>>(
                      stream: database.newProductsStream(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.active) {
                          // call product from firestore
                          final products = snapshot.data;
                          // handle data
                          if (products == null || products.isEmpty) {
                            return const Center(
                                child: Text("No data available"));
                          }
                          //! use ListView.builder => delete .map().toList()
                          //* we use list of products that come from stream
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: products.length,
                            itemBuilder: (_, int index) => Padding(
                              padding: const EdgeInsets.all(8),
                              child: ListItemHome(
                                product: products[index],
                                isNew: true,
                              ),
                            ),
                          );
                        }
                        return const Center(child: CircularProgressIndicator());
                      }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
