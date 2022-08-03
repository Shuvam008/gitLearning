import 'package:flutter/material.dart';

class HomeTabs extends StatelessWidget {
  final String title;
  const HomeTabs(this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tab(
      // height: 70,
      // text: 'STATISTICS',
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
