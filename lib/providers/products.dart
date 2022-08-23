import 'package:flutter/material.dart';

import 'product.dart';

class Products with ChangeNotifier {
  final List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Television',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. A condimentum vitae sapien pellentesque habitant morbi tristique senectus. Eleifend mi in nulla posuere sollicitudin aliquam ultrices sagittis. Ornare massa eget egestas purus viverra. Id semper risus in hendrerit gravida rutrum quisque non. Consectetur adipiscing elit pellentesque habitant morbi tristique senectus. Nec feugiat in fermentum posuere urna nec tincidunt praesent. Malesuada fames ac turpis egestas maecenas pharetra. Ultrices dui sapien eget mi proin sed. Imperdiet nulla malesuada pellentesque elit eget gravida. Interdum consectetur libero id faucibus. Aliquam purus sit amet luctus venenatis lectus magna fringilla urna. Urna nunc id cursus metus aliquam eleifend mi in. Justo donec enim diam vulputate ut pharetra sit. In ornare quam viverra orci sagittis eu volutpat odio facilisis.',
      price: 120,
      image:
          'https://cdnb.artstation.com/p/assets/images/images/029/446/953/large/antonio-mg-3.jpg?1597588635',
    ),
    Product(
      id: 'p2',
      title: 'Kuma',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. A condimentum vitae sapien pellentesque habitant morbi tristique senectus. Eleifend mi in nulla posuere sollicitudin aliquam ultrices sagittis. Ornare massa eget egestas purus viverra. Id semper risus in hendrerit gravida rutrum quisque non. Consectetur adipiscing elit pellentesque habitant morbi tristique senectus. Nec feugiat in fermentum posuere urna nec tincidunt praesent. Malesuada fames ac turpis egestas maecenas pharetra. Ultrices dui sapien eget mi proin sed. Imperdiet nulla malesuada pellentesque elit eget gravida. Interdum consectetur libero id faucibus. Aliquam purus sit amet luctus venenatis lectus magna fringilla urna. Urna nunc id cursus metus aliquam eleifend mi in. Justo donec enim diam vulputate ut pharetra sit. In ornare quam viverra orci sagittis eu volutpat odio facilisis.',
      price: 25,
      image:
          'https://static.wikia.nocookie.net/megamitensei/images/5/59/PQ2_Teddie.png/revision/latest?cb=20180901221207',
    ),
    Product(
      id: 'p3',
      title: 'Scooter',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. A condimentum vitae sapien pellentesque habitant morbi tristique senectus. Eleifend mi in nulla posuere sollicitudin aliquam ultrices sagittis. Ornare massa eget egestas purus viverra. Id semper risus in hendrerit gravida rutrum quisque non. Consectetur adipiscing elit pellentesque habitant morbi tristique senectus. Nec feugiat in fermentum posuere urna nec tincidunt praesent. Malesuada fames ac turpis egestas maecenas pharetra. Ultrices dui sapien eget mi proin sed. Imperdiet nulla malesuada pellentesque elit eget gravida. Interdum consectetur libero id faucibus. Aliquam purus sit amet luctus venenatis lectus magna fringilla urna. Urna nunc id cursus metus aliquam eleifend mi in. Justo donec enim diam vulputate ut pharetra sit. In ornare quam viverra orci sagittis eu volutpat odio facilisis.',
      price: 1500,
      image:
          'https://assets.reedpopcdn.com/persona-4-golden-social-stats-increase-knowledge-diligence-courage-expression-understanding-7035-1593446229177.jpg/BROK/thumbnail/1200x1200/quality/100/persona-4-golden-social-stats-increase-knowledge-diligence-courage-expression-understanding-7035-1593446229177.jpg',
    ),
    Product(
      id: 'p4',
      title: 'School Uniform',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. A condimentum vitae sapien pellentesque habitant morbi tristique senectus. Eleifend mi in nulla posuere sollicitudin aliquam ultrices sagittis. Ornare massa eget egestas purus viverra. Id semper risus in hendrerit gravida rutrum quisque non. Consectetur adipiscing elit pellentesque habitant morbi tristique senectus. Nec feugiat in fermentum posuere urna nec tincidunt praesent. Malesuada fames ac turpis egestas maecenas pharetra. Ultrices dui sapien eget mi proin sed. Imperdiet nulla malesuada pellentesque elit eget gravida. Interdum consectetur libero id faucibus. Aliquam purus sit amet luctus venenatis lectus magna fringilla urna. Urna nunc id cursus metus aliquam eleifend mi in. Justo donec enim diam vulputate ut pharetra sit. In ornare quam viverra orci sagittis eu volutpat odio facilisis.',
      price: 24,
      image: 'https://st.cdjapan.co.jp/pictures/l/00/44/NEOGDS-4181_3.jpg?v=1',
    )
  ];

  List<Product> get items => [..._items];

  Product findById(id) => _items.firstWhere((item) => item.id == id);

  void addProduct(Product product) {
    _items.add(product);
    notifyListeners();
  }
}
