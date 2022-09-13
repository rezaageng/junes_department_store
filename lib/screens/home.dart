import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product.dart';
import '../providers/products.dart';
import '../widgets/filter.dart';
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
  bool _isInit = true;
  bool _isLoading = false;

  FilterOptions _showProducts = FilterOptions.all;

  void _changeFilter(FilterOptions filter) => setState(() {
        _showProducts = filter;
      });

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      await Provider.of<Products>(context).fetchProduct();
      setState(() {
        _isLoading = false;
      });
    }
    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    final Products products = Provider.of<Products>(context);
    final List<Product> filteredProducts =
        _showProducts == FilterOptions.favorite
            ? products.favoriteProduct
            : products.items;

    return _isLoading
        ? const Center(
            child: CircularProgressIndicator.adaptive(),
          )
        : Column(
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
                child: filteredProducts.isEmpty
                    ? const Center(
                        child: Text('Nothing here :('),
                      )
                    : GridView.builder(
                        padding: const EdgeInsets.all(16),
                        physics: const BouncingScrollPhysics(),
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
              ),
            ],
          );
  }
}
