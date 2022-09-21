import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import '../utilities/on_refresh.dart';
import '../widgets/nothing_here.dart';
import '../widgets/user_product_item.dart';
import 'user_product_form.dart';

class UserProducts extends StatelessWidget {
  static const String routeName = '/user-products';

  const UserProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          enableFeedback: false,
          icon: const Icon(Icons.arrow_back_rounded),
        ),
        title: const Text('User Products'),
      ),
      body: FutureBuilder(
        future:
            Provider.of<Products>(context, listen: false).fetchProduct(true),
        builder: (context, snapshot) {
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
                () => Provider.of<Products>(context, listen: false)
                    .fetchProduct(true),
              ),
              color: Theme.of(context).colorScheme.secondary,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Consumer<Products>(
                  builder: (context, products, child) =>
                      products.userItems.isEmpty
                          ? const NothingHere()
                          : ListView.builder(
                              physics: const BouncingScrollPhysics(
                                  parent: AlwaysScrollableScrollPhysics()),
                              itemCount: products.userItems.length,
                              itemBuilder: (context, index) => UserProductItem(
                                id: products.userItems[index].id,
                                title: products.userItems[index].title,
                                image: products.userItems[index].image,
                              ),
                            ),
                ),
              ),
            );
          } else {
            return const NothingHere();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Navigator.of(context).pushNamed(UserProductForm.routeName),
        enableFeedback: false,
        child: const Icon(
          Icons.add_rounded,
          color: Colors.white,
        ),
      ),
    );
  }
}
