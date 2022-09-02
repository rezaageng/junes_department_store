import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart';
import '../widgets/order_item.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ordersData = Provider.of<Orders>(context);

    return Center(
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: ordersData.orders.length,
        itemBuilder: (context, index) =>
            OrderItem(order: ordersData.orders[index]),
      ),
    );
  }
}
