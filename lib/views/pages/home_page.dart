import 'package:e_commerce/controllers/database_controller.dart';
import 'package:e_commerce/models/product.dart';
import 'package:e_commerce/utilities/assets.dart';
import 'package:e_commerce/views/widgets/list_item_home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  /// ToDo:  Temp CODE Till refactor to a separate class with a separate context
  Widget _buildHeadlineOfList(
    BuildContext context, {
    required String title,
    VoidCallback? onTap,
    required String description,
  }) {
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
                    fontSize: 40,
                  ),
            ),
            InkWell(
              onTap: onTap,
              child: Text(
                'View All ',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ],
        ),
        Text(
          description,
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: Colors.grey),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final database = Provider.of<Database>(context);
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Image.network(
                AppAssets.topBannerHomepageAssets,
                width: double.infinity,
                height: size.height * 0.3,
                fit: BoxFit.cover,
              ),
              Opacity(
                opacity: 0.5,
                child: Container(
                  width: double.infinity,
                  height: size.height * 0.3,
                  color: Colors.black,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 32,
                ),
                child: Text(
                  'Street Clothes',
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 24,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                _buildHeadlineOfList(
                  context,
                  title: 'Sale',
                  description: 'Super Summer Sale!',
                ),
                const SizedBox(
                  height: 8,
                ),
                SizedBox(
                  height: 320,
                  child: StreamBuilder<List<Product>>(
                      stream: database.sealsProductsStream(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.active) {
                          final products = snapshot.data;
                          if (products == null || products.isEmpty) {
                            return const Center(
                              child: Text('No Data Available!'),
                            );
                          }
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: products.length,
                            itemBuilder: (_, int index) =>
                                ListItemHome(product: products[index] ,isNew: true,),
                          );
                        }
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }),
                ),
                const SizedBox(
                  height: 24,
                ),
                _buildHeadlineOfList(
                  context,
                  title: 'New',
                  description: 'Super New Sale!',
                ),
                const SizedBox(
                  height: 8,
                ),
                SizedBox(
                  height: 320,
                  child: StreamBuilder<List<Product>>(
                      stream: database.newProductsStream(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.active) {
                          final products = snapshot.data;
                          if (products == null || products.isEmpty) {
                            return const Center(
                              child: Text('No Data Available!'),
                            );
                          }
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: products.length,
                            itemBuilder: (_, int index) =>
                                ListItemHome(product: products[index] ,isNew: true,),
                          );
                        }
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
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
