import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../providers/orders.dart';

class OrderItem extends StatefulWidget {
  final Order order;

  const OrderItem({Key? key, required this.order}) : super(key: key);

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool isExpand = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            visualDensity: const VisualDensity(vertical: -4),
            title: Text('\$${widget.order.amount}'),
            subtitle:
                Text(DateFormat('dd MMM yyyy  h:ma').format(widget.order.date)),
            trailing: IconButton(
              onPressed: () {
                setState(() {
                  isExpand = !isExpand;
                });
              },
              enableFeedback: false,
              icon: Icon(
                isExpand
                    ? Icons.expand_less_rounded
                    : Icons.expand_more_rounded,
              ),
            ),
          ),
          if (isExpand)
            SizedBox(
              height: min(widget.order.products.length * 20, 240),
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: widget.order.products.length,
                itemBuilder: (context, index) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.order.products[index].title),
                    Text(
                      '${widget.order.products[index].price} x ${widget.order.products[index].quantity}',
                    )
                  ],
                ),
              ),
            )
        ],
      ),
    );
  }
}
