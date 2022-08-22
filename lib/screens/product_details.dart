import 'package:flutter/material.dart';

class ProductDetails extends StatelessWidget {
  static const routeName = '/product-details';

  const ProductDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: const Center(
        child: Text('Product Details'),
      ),
    );
  }
}
