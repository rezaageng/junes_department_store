import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final String title;
  final String image;

  const ProductItem({Key? key, required this.title, required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: GridTile(
        header: Material(
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                splashRadius: 24,
                icon: const Icon(Icons.favorite_outline),
                onPressed: () {},
              ),
              IconButton(
                splashRadius: 24,
                icon: const Icon(Icons.shopping_cart_outlined),
                onPressed: () {},
              ),
            ],
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Theme.of(context).cardTheme.color,
          title: Text(
            title,
            textAlign: TextAlign.center,
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
    );
  }
}
