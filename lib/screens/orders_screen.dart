import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart';
import '../utilities/on_refresh.dart';
import '../widgets/nothing_here.dart';
import '../widgets/order_item.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    () async {
      setState(() {
        _isLoading = true;
      });
      await Provider.of<Orders>(context, listen: false).fetchOrders();
      setState(() {
        _isLoading = false;
      });
    }();
  }

  @override
  Widget build(BuildContext context) {
    final ordersData = Provider.of<Orders>(context, listen: false);

    return _isLoading
        ? const Center(
            child: CircularProgressIndicator.adaptive(),
          )
        : RefreshIndicator(
            onRefresh: () => onRefresh(
              context,
              () => ordersData.fetchOrders(),
            ),
            color: Theme.of(context).colorScheme.secondary,
            child: ordersData.orders.isEmpty
                ? const NothingHere()
                : ListView.builder(
                    physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    itemCount: ordersData.orders.length,
                    itemBuilder: (context, index) =>
                        OrderItem(order: ordersData.orders[index]),
                  ),
          );
  }
}
