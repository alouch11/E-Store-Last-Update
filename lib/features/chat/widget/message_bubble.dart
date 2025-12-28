import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/features/chat/domain/model/message_model.dart';
import 'package:flutter_spareparts_store/features/chat/provider/chat_provider.dart';
import 'package:flutter_spareparts_store/features/profile/provider/profile_provider.dart';
import 'package:flutter_spareparts_store/localization/provider/localization_provider.dart';
import 'package:flutter_spareparts_store/utill/app_constants.dart';
import 'package:flutter_spareparts_store/utill/color_resources.dart';
import 'package:flutter_spareparts_store/utill/custom_themes.dart';
import 'package:flutter_spareparts_store/utill/dimensions.dart';
import 'package:flutter_spareparts_store/basewidget/custom_image.dart';
import 'package:flutter_spareparts_store/basewidget/image_diaglog.dart';
import 'package:provider/provider.dart';


class MessageBubble extends StatelessWidget {
  final Message message;
  final String? image;
  const MessageBubble({super.key, required this.message, this.image});

  @override
  Widget build(BuildContext context) {

    bool isMe = message.sentByCustomer!;
    int? from = message.userId;
    int? to = message.userId2;
    int? user=Provider.of<ProfileProvider>(context, listen: false).userInfoModel!.id;
    //bool isMe =true;
    //String? baseUrl = Provider.of<ChatProvider>(context, listen: false).userTypeIndex == 0 ?Provider.of<SplashProvider>(context, listen: false).baseUrls!.shopImageUrl:Provider.of<SplashProvider>(context, listen: false).baseUrls!.deliveryManImageUrl;
    //String? baseUrl = Provider.of<SplashProvider>(context, listen: false).baseUrls!.customerImageUrl;

    //String? image = Provider.of<ChatProvider>(context, listen: false).userTypeIndex == 0 ? message.sellerInfo != null? message.sellerInfo?.shops![0].image :'' : message.deliveryMan?.image;
    //String? image = message.user?.image;
    //'${Provider.of<SplashProvider>(context, listen: false).baseUrls!.customerImageUrl}/${widget.user!.image}'

    List<Attachment> images = [];
    List<Attachment> files = [];

    if(message.attachment != null) {
      for(Attachment attachment in message.attachment!){
        if(attachment.type == 'media'){
          images.add(attachment);

        }else if (attachment.type == 'file') {
          files.add(attachment);
        }
      }
    }
    return Consumer<ChatProvider>(
        builder: (context, chatProvider,child) {
    return Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall),
      child: Column(crossAxisAlignment: user==from ? CrossAxisAlignment.end:CrossAxisAlignment.start, children: [
          Row(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: user==from ? MainAxisAlignment.end : MainAxisAlignment.start, children: [
              user==from ? const SizedBox.shrink() : Container( width: 40, height: 40,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(color: Theme.of(context).primaryColor)),
                child: ClipRRect(borderRadius: BorderRadius.circular(20.0),
                  child: CustomImage(fit: BoxFit.cover, width: 40, height: 40, image: '$image')

                )),
              if(message.message != null && message.message!.isNotEmpty)

                Flexible(child: InkWell(
                  onTap: (){
                    chatProvider.toggleOnClickMessage(onMessageTimeShowID : message.id.toString());
                  },
                  child: Container(
                margin: user==from ?  const EdgeInsets.fromLTRB(70, 5, 10, 5) : const EdgeInsets.fromLTRB(10, 5, 70, 5),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(10),
                        bottomLeft: user==from ? const Radius.circular(10) : const Radius.circular(0),
                        bottomRight: user==from ? const Radius.circular(0) : const Radius.circular(10),
                        topRight: const Radius.circular(10),),
                      color: user==from ? ColorResources.getImageBg(context) : ColorResources.chattingSenderColor(context)),
                    child: (message.message != null && message.message!.isNotEmpty) ? Text(message.message!,
                        textAlign: TextAlign.justify,
                        style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault, color : user==from? Colors.white: Theme.of(context).textTheme.bodyLarge?.color)) :
                    const SizedBox.shrink(),
                ),
                )),

            ],
          ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
          child: AnimatedContainer(
            curve: Curves.fastOutSlowIn,
            duration: const Duration(milliseconds: 500),
            height: chatProvider.onMessageTimeShowID == message.id.toString() ? 25.0 : 0.0,
            child: Padding(
              padding: EdgeInsets.only(
                top: chatProvider.onMessageTimeShowID == message.id.toString() ?
                Dimensions.paddingSizeExtraSmall : 0.0,
              ),
              child: Text(chatProvider.getOnPressChatTime(message) ?? "", style: textRegular.copyWith(
                  fontSize: Dimensions.fontSizeSmall
              )),
            ),
          ),
        ),

        if(message.attachment!.isNotEmpty) const SizedBox(height: Dimensions.paddingSizeSmall),
        message.attachment!.isNotEmpty?
        Directionality(textDirection:Provider.of<LocalizationProvider>(context, listen: false).isLtr ? user==from ?
        TextDirection.rtl : TextDirection.ltr : user==from ? TextDirection.ltr : TextDirection.rtl,
          child: GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 1, crossAxisCount: 3,
              mainAxisSpacing: Dimensions.paddingSizeSmall, crossAxisSpacing: Dimensions.paddingSizeSmall),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: message.attachment!.length,
            itemBuilder: (BuildContext context, index) {


              return  InkWell(onTap: () => showDialog(context: context, builder: (ctx)  =>  ImageDialog(
                  imageUrl: '${AppConstants.baseUrl}/storage/app/public/chatting/${message.attachment![index]}')),
                child: ClipRRect(borderRadius: BorderRadius.circular(5),
                    child:CustomImage(height: 100, width: 100, fit: BoxFit.cover,
                        image: '${AppConstants.baseUrl}/storage/app/public/chatting/${message.attachment![index]}')),);

            },),
        ):
        const SizedBox.shrink(),
        ],
      ),
    );});
  }


}
