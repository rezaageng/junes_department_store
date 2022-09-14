import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart';
import '../utilities/on_refresh.dart';
import '../widgets/nothing_here.dart';
import '../widgets/order_item.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<Orders>(context, listen: false).fetchOrders(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }
        if (snapshot.error != null) {
          Future.delayed(
            Duration.zero,
            () => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Error fetching data'),
              ),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return Consumer<Orders>(
            builder: (context, ordersData, child) => RefreshIndicator(
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
                      itemBuilder: (context, index) => OrderItem(
                        order: ordersData.orders[index],
                      ),
                    ),
            ),
          );
        } else {
          return const NothingHere();
        }
      },
    );
  }
}
