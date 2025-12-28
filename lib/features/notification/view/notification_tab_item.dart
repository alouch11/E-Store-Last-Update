
import 'package:flutter/material.dart';

class NotificationsTabItem extends StatelessWidget {
  final String title;


  const NotificationsTabItem({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}