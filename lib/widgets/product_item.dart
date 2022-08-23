import 'package:flutter/material.dart';

import '../screens/product_details.dart';

class ProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String image;
  final double price;

  const ProductItem(
      {Key? key,
      required this.id,
      required this.title,
      required this.image,
      required this.price})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Material(
        child: GestureDetector(
          onTap: () => Navigator.of(context)
              .pushNamed(ProductDetails.routeName, arguments: id),
          child: GridTile(
            header: Material(
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    enableFeedback: false,
                    splashRadius: 24,
                    icon: const Icon(Icons.favorite_outline),
                    color: Colors.white,
                    onPressed: () {},
                  ),
                  IconButton(
                    enableFeedback: false,
                    splashRadius: 24,
                    icon: const Icon(Icons.shopping_cart_outlined),
                    color: Colors.white,
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            footer: GridTileBar(
              backgroundColor: Theme.of(context).cardTheme.color,
              title: Text(
                title,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              subtitle: Text(
                '\$${price.toStringAsFixed(0)}',
                style: Theme.of(context).textTheme.subtitle2,
              ),
            ),
            child: Container(
              color: Theme.of(context).cardTheme.color,
              child: Image.network(
                image,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
