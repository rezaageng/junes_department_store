import 'package:flutter/material.dart';
import 'package:junes_department_store/screens/user_product_form.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import '../widgets/user_product_item.dart';

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
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Consumer<Products>(
          builder: (context, products, child) => ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: products.items.length,
            itemBuilder: (context, index) => UserProductItem(
              title: products.items[index].title,
              image: products.items[index].image,
            ),
          ),
        ),
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
