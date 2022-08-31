import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';
import '../providers/product.dart';
import '../screens/product_details.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Product product = Provider.of<Product>(context);
    final Cart cart = Provider.of<Cart>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Material(
        child: GestureDetector(
          onTap: () => Navigator.of(context)
              .pushNamed(ProductDetails.routeName, arguments: product.id),
          child: GridTile(
            header: Material(
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Consumer<Product>(
                    builder: (context, value, child) => IconButton(
                      enableFeedback: false,
                      splashRadius: 24,
                      icon: Icon(
                        product.isFavorite
                            ? Icons.favorite_rounded
                            : Icons.favorite_outline_rounded,
                      ),
                      color: Colors.white,
                      onPressed: product.toggleFavorite,
                    ),
                  ),
                  IconButton(
                    enableFeedback: false,
                    splashRadius: 24,
                    icon: const Icon(Icons.shopping_cart_outlined),
                    color: Colors.white,
                    onPressed: () =>
                        cart.addItem(product.id, product.title, product.price),
                  ),
                ],
              ),
            ),
            footer: GridTileBar(
              backgroundColor: Theme.of(context).cardTheme.color,
              title: Text(
                product.title,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              subtitle: Text(
                '\$${product.price.toStringAsFixed(0)}',
                style: Theme.of(context).textTheme.subtitle2,
              ),
            ),
            child: Container(
              color: Theme.of(context).cardTheme.color,
              child: Image.network(
                product.image,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
