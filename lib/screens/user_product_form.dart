import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product.dart';
import '../providers/products.dart';

class UserProductForm extends StatefulWidget {
  static const String routeName = '/user-product-form';

  const UserProductForm({Key? key}) : super(key: key);

  @override
  State<UserProductForm> createState() => _UserProductFormState();
}

class _UserProductFormState extends State<UserProductForm> {
  final _imageUrlController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Product _product = Product(
    id: '',
    title: '',
    description: '',
    price: 0,
    image: '',
  );

  final RegExp regex = RegExp(
    r"(https?|ftp)://([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?",
    caseSensitive: false,
  );

  bool _isInit = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final productId = ModalRoute.of(context)?.settings.arguments as String?;
    if (_isInit && productId != null) {
      _product = Provider.of<Products>(context).findById(productId);
      _imageUrlController.text = _product.image;
    }
    _isInit = false;
  }

  void _saveForm() {
    final isValid = _formKey.currentState!.validate();

    if (!isValid) return;

    _formKey.currentState!.save();
    if (_product.id.isNotEmpty) {
      Provider.of<Products>(context, listen: false)
          .updateProduct(_product.id, _product);
    } else {
      Provider.of<Products>(context, listen: false).addProduct(_product);
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          enableFeedback: false,
          icon: const Icon(Icons.arrow_back_rounded),
        ),
        title: const Text('Manage Product'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    TextFormField(
                      initialValue: _product.title,
                      validator: (value) {
                        if (value!.isEmpty) return 'Title is empty';
                        return null;
                      },
                      onSaved: (value) {
                        _product = Product(
                          id: _product.id,
                          title: value!,
                          description: _product.description,
                          price: _product.price,
                          image: _product.image,
                          isFavorite: _product.isFavorite,
                        );
                      },
                      decoration: InputDecoration(
                        hintText: 'Title',
                        filled: true,
                        fillColor: Theme.of(context).cardTheme.color,
                        contentPadding: const EdgeInsets.all(16),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      initialValue:
                          _product.price <= 0 ? '' : _product.price.toString(),
                      validator: (value) {
                        if (value!.isEmpty) return 'Price is empty';
                        if (double.tryParse(value) == null) {
                          return 'Invalid value';
                        }
                        if (double.parse(value) < 0) {
                          return 'Price must be greater than or equal to 0';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _product = Product(
                          id: _product.id,
                          title: _product.title,
                          description: _product.description,
                          price: double.parse(value!),
                          image: _product.image,
                          isFavorite: _product.isFavorite,
                        );
                      },
                      decoration: InputDecoration(
                        hintText: 'Price',
                        filled: true,
                        fillColor: Theme.of(context).cardTheme.color,
                        contentPadding: const EdgeInsets.all(16),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      initialValue: _product.description,
                      validator: (value) {
                        if (value!.isEmpty) return 'Description is empty';
                        if (value.length < 20) {
                          return 'Description must be more than 10 characters';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _product = Product(
                          id: _product.id,
                          title: _product.title,
                          description: value!,
                          price: _product.price,
                          image: _product.image,
                          isFavorite: _product.isFavorite,
                        );
                      },
                      decoration: InputDecoration(
                        hintText: 'Description',
                        filled: true,
                        fillColor: Theme.of(context).cardTheme.color,
                        contentPadding: const EdgeInsets.all(16),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      keyboardType: TextInputType.multiline,
                      maxLines: 3,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardTheme.color,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: _imageUrlController.text.isEmpty
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.image_rounded,
                                      size: 64,
                                      color: Colors.white54,
                                    ),
                                    Text(
                                      'No image',
                                      style:
                                          Theme.of(context).textTheme.caption,
                                    )
                                  ],
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.network(
                                    _imageUrlController.text,
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) => Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.broken_image_rounded,
                                          size: 64,
                                          color: Colors.white54,
                                        ),
                                        Text(
                                          'Image error',
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) return 'Image url is empty';
                              if (!regex.hasMatch(value)) return 'Invalid url';
                              return null;
                            },
                            onSaved: (value) {
                              _product = Product(
                                id: _product.id,
                                title: _product.title,
                                description: _product.description,
                                price: _product.price,
                                image: value!,
                                isFavorite: _product.isFavorite,
                              );
                            },
                            controller: _imageUrlController,
                            keyboardType: TextInputType.url,
                            onChanged: (_) => setState(() {}),
                            decoration: InputDecoration(
                              hintText: 'Image Url',
                              filled: true,
                              fillColor: Theme.of(context).cardTheme.color,
                              contentPadding: const EdgeInsets.all(16),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saveForm,
                child: const Text('Save'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
