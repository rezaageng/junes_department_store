import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product.dart';
import '../providers/products.dart';
import '../utilities/on_refresh.dart';
import '../widgets/filter.dart';
import '../widgets/nothing_here.dart';
import '../widgets/product_item.dart';

enum FilterOptions {
  favorite,
  all,
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  FilterOptions _showProducts = FilterOptions.all;

  void _changeFilter(FilterOptions filter) => setState(() {
        _showProducts = filter;
      });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Filter(
                title: 'All',
                onTap: () => _changeFilter(FilterOptions.all),
              ),
              const SizedBox(width: 12),
              Filter(
                  title: 'Favorite',
                  onTap: () => _changeFilter(FilterOptions.favorite))
            ],
          ),
        ),
        Expanded(
          child: FutureBuilder(
            future:
                Provider.of<Products>(context, listen: false).fetchProduct(),
            builder: (context, snapshot) {
              final Products products =
                  Provider.of<Products>(context, listen: false);
              final List<Product> filteredProducts =
                  _showProducts == FilterOptions.favorite
                      ? products.favoriteProduct
                      : products.items;

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              }
              if (snapshot.error != null) {
                Future.delayed(
                  Duration.zero,
                  () => ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Error fetching data'),
                    ),
                  ),
                );
              }
              if (snapshot.connectionState == ConnectionState.done) {
                return RefreshIndicator(
                  onRefresh: () => onRefresh(
                    context,
                    () => products.fetchProduct(),
                  ),
                  color: Theme.of(context).colorScheme.secondary,
                  child: filteredProducts.isEmpty
                      ? const NothingHere()
                      : GridView.builder(
                          padding: const EdgeInsets.all(16),
                          physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics(),
                          ),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 2 / 3,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                          ),
                          itemCount: filteredProducts.length,
                          itemBuilder: ((context, index) =>
                              ChangeNotifierProvider.value(
                                value: filteredProducts[index],
                                child: const ProductItem(),
                              )),
                        ),
                );
              } else {
                return const NothingHere();
              }
            },
          ),
        ),
      ],
    );
  }
}
