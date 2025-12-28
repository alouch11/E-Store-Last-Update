
import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/utill/custom_themes.dart';

class ProductTrasnsactionsTabItem extends StatelessWidget {
  final String title;
  final int count;

  const ProductTrasnsactionsTabItem({
    super.key,
    required this.title,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style:titleRegular.copyWith(color:Colors.black,fontSize:14),
            overflow: TextOverflow.ellipsis,
          ),
          count > 0
              ? Container(
            margin: const EdgeInsetsDirectional.only(start: 5),
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                count > 99 ? "99+" : count.toString(),
                style: const TextStyle(
                  color: Colors.black54,
                  fontSize: 10,
                ),
              ),

            ),
          )
              : const SizedBox(width: 0, height: 0),
        ],
      ),
    );
  }
}