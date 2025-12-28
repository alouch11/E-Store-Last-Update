import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/utill/color_resources.dart';
import 'package:flutter_spareparts_store/utill/custom_themes.dart';
import 'package:provider/provider.dart';

import '../../product/provider/search_provider.dart';

class SearchTypeButton extends StatelessWidget {
  final String? text;
  final String index;


  const SearchTypeButton({super.key, required this.text, required this.index});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextButton(
        onPressed: () => Provider.of<SearchProvider>(context, listen: false).setIndex(index),
        style: TextButton.styleFrom(padding: const EdgeInsets.all(0)),
        child: Container(
          height: 35,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Provider.of<SearchProvider>(context, listen: false).searchTypeIndex == index ? ColorResources.getPrimary(context) : Theme.of(context).primaryColor.withOpacity(0.07),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(text!,
                  style: titilliumBold.copyWith(color: Provider.of<SearchProvider>(context, listen: false).searchTypeIndex == index
                      ? Theme.of(context).highlightColor : ColorResources.getReviewRattingColor(context))),
              const SizedBox(width: 5),
            ],
          ),
        ),
      ),
    );
  }
}