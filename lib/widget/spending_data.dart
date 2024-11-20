import 'package:flutter/material.dart';

import '../data/model/add_data.dart';

class SpendingData extends StatelessWidget {
  const SpendingData({
    super.key,
    required this.add,
  });

  final List<Add_data> add;

  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildBuilderDelegate(
              (context, index) {
            return ListTile(
              leading: ClipRRect(
                /// image
                borderRadius: BorderRadius.circular(5),
                child: Image.asset('images/${add[index].name}.png', height: 40),
              ),
              ///name
              title: Text(
                add[index].name,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
              ///date
              subtitle: Text(
                ' ${add[index].datetime.day}-${add[index].datetime.month}-${add[index].datetime.year}',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              /// display amount
              trailing: Text(

                add[index].amount,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 19,
                  color: add[index].IN == 'Income' ? Colors.green : Colors.red,
                ),
              ),
            );
          },
          childCount: add.length,
        ));
  }
}