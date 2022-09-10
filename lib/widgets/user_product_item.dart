import 'package:flutter/material.dart';
import 'package:junes_department_store/providers/products.dart';
import 'package:provider/provider.dart';

import '../screens/user_product_form.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String image;

  const UserProductItem({
    Key? key,
    required this.id,
    required this.title,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: AspectRatio(
            aspectRatio: 1,
            child: Image.network(
              image,
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: Text(title),
        trailing: FittedBox(
          fit: BoxFit.fill,
          child: Row(
            children: [
              IconButton(
                onPressed: () => Navigator.of(context)
                    .pushNamed(UserProductForm.routeName, arguments: id),
                enableFeedback: false,
                icon: const Icon(Icons.edit_rounded),
              ),
              IconButton(
                onPressed: () => Provider.of<Products>(context, listen: false)
                    .deleteProduct(id),
                enableFeedback: false,
                icon: const Icon(Icons.delete_rounded),
                color: Theme.of(context).colorScheme.error,
              )
            ],
          ),
        ),
      ),
    );
  }
}
