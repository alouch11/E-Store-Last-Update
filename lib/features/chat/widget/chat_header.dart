import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/localization/language_constrants.dart';
import 'package:flutter_spareparts_store/features/chat/provider/chat_provider.dart';
import 'package:flutter_spareparts_store/localization/provider/localization_provider.dart';
import 'package:flutter_spareparts_store/theme/provider/theme_provider.dart';
import 'package:flutter_spareparts_store/utill/custom_themes.dart';
import 'package:flutter_spareparts_store/utill/dimensions.dart';
import 'package:flutter_spareparts_store/basewidget/custom_search_widget.dart';
import 'package:flutter_spareparts_store/features/chat/widget/chat_type_button.dart';
import 'package:provider/provider.dart';


class ChatHeader extends StatefulWidget {
  const ChatHeader({super.key});

  @override
  State<ChatHeader> createState() => _ChatHeaderState();
}

class _ChatHeaderState extends State<ChatHeader> {
  final TextEditingController _textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(
        builder: (context, chat, _) {
          return Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: Container(height: 48,
                decoration: BoxDecoration(color: Provider.of<ThemeProvider>(context).darkTheme ? Theme.of(context).canvasColor :Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(Dimensions.topSpace)),

                child: Stack(children: [
                  Positioned(
                    child: Align(alignment: Alignment.centerRight,
                      child: ListView(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal, children: [
                          ChatTypeButton(text: getTranslated('seller', context), index: 0),
                        ChatTypeButton(text: getTranslated('delivery-man', context), index: 1),
                      ],
                      ),
                    ),
                  ),
                    AnimSearchBar(
                      width: MediaQuery.of(context).size.width,
                      textController: _textEditingController,
                      onSuffixTap: () {},
                      color: Theme.of(context).cardColor,
                      helpText: "Search Text...",
                      autoFocus: true,

                      style: textRegular.copyWith(color: Provider.of<ThemeProvider>(context).darkTheme ? Colors.white : Colors.black),
                      closeSearchOnSuffixTap: true,
                      onChanged: (value){
                        if(value != null){
                          chat.searchChat(context, value);
                        }
                      },
                      animationDurationInMilli: 200,
                      rtl: !Provider.of<LocalizationProvider>(context).isLtr,
                    ),
                  ],
                )),
          );
        }
    );
  }
}
