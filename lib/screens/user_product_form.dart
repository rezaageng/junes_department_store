import 'package:flutter/material.dart';

import '../providers/product.dart';

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

  void _saveForm() => _formKey.currentState!.save();

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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              TextFormField(
                onSaved: (value) {
                  _product = Product(
                    id: _product.id,
                    title: value!,
                    description: _product.description,
                    price: _product.price,
                    image: _product.image,
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
                onSaved: (value) {
                  _product = Product(
                    id: _product.id,
                    title: _product.title,
                    description: _product.description,
                    price: double.parse(value!),
                    image: _product.image,
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
                onSaved: (value) {
                  _product = Product(
                    id: _product.id,
                    title: _product.title,
                    description: value!,
                    price: _product.price,
                    image: _product.image,
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
                        ? const Center(
                            child: Text('No Image'),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.network(
                              _imageUrlController.text,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextFormField(
                      onSaved: (value) {
                        _product = Product(
                          id: _product.id,
                          title: _product.title,
                          description: _product.description,
                          price: _product.price,
                          image: value!,
                        );
                      },
                      controller: _imageUrlController,
                      keyboardType: TextInputType.url,
                      onEditingComplete: () => setState(() {}),
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
              Container(
                margin: const EdgeInsets.only(top: 16),
                child: ElevatedButton(
                  onPressed: _saveForm,
                  child: const Text('Save'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
