import 'package:flutter/material.dart';

class Spending extends StatelessWidget {
  const Spending({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Top Spending',
            style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
          Icon(
            Icons.swap_vert,
            size: 25,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}