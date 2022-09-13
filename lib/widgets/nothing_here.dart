import 'package:flutter/material.dart';

class NothingHere extends StatelessWidget {
  const NothingHere({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      slivers: [
        SliverFillRemaining(
          child: Center(
            child: Text('Nothing here 😔'),
          ),
        )
      ],
    );
  }
}
