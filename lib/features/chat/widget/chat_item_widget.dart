import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/features/chat/provider/chat_provider.dart';

import 'package:flutter_spareparts_store/features/chat/view/chat_screen.dart';
import 'package:flutter_spareparts_store/features/profile/domain/model/user_info_model.dart';
import 'package:flutter_spareparts_store/helper/date_converter.dart';
import 'package:flutter_spareparts_store/localization/language_constrants.dart';
import 'package:flutter_spareparts_store/main.dart';
import 'package:flutter_spareparts_store/features/splash/provider/splash_provider.dart';
import 'package:flutter_spareparts_store/utill/color_resources.dart';
import 'package:flutter_spareparts_store/utill/custom_themes.dart';
import 'package:flutter_spareparts_store/utill/dimensions.dart';
import 'package:flutter_spareparts_store/basewidget/custom_image.dart';
import 'package:flutter_spareparts_store/basewidget/show_custom_snakbar.dart';

import 'package:provider/provider.dart';

class ChatItemWidget extends StatefulWidget {
  final UserInfoModel? user;
  final ChatProvider chatProvider;
  const ChatItemWidget({super.key, this.user, required this.chatProvider});

  @override
  State<ChatItemWidget> createState() => _ChatItemWidgetState();
}

class _ChatItemWidgetState extends State<ChatItemWidget> {
  String? baseUrl = '', image = '', call = '', name = '';
  int? id;
  @override
  void initState() {
     baseUrl = widget.chatProvider.userTypeIndex == 0 ?
    Provider.of<SplashProvider>(context, listen: false).baseUrls!.shopImageUrl:
    Provider.of<SplashProvider>(context, listen: false).baseUrls!.deliveryManImageUrl;

     /*    image = widget.chatProvider.userTypeIndex == 0 ?

    widget.user!.sellerInfo != null? widget.user!.sellerInfo?.shops![0].image :'' : widget.user!.deliveryMan?.image??'';

     call = widget.chatProvider.userTypeIndex == 0 ?
    '' : '${widget.user!.deliveryMan?.code}${widget.user!.deliveryMan?.phone}';

     id = widget.chatProvider.userTypeIndex == 0 ?
    widget.user!.id : widget.user!.deliveryManId;
     name = widget.chatProvider.userTypeIndex == 0 ?
    widget.user!.sellerInfo != null ? widget.user!.sellerInfo!.shops![0].name??'' : 'Shop not found': "${widget.user!.deliveryMan?.fName??''} ${widget.user!.deliveryMan?.lName??''}";
*/

    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Column(children: [
        ListTile(leading: Stack(
          children: [
            Container(width: 50,height: 50,decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).primaryColor.withOpacity(.25),width: .5),
                borderRadius: BorderRadius.circular(100)),
                  child: ClipRRect(borderRadius: BorderRadius.circular(100),
                    //child: CustomImage(image: '$baseUrl/$image', height: 50,width: 50, fit: BoxFit.cover)
                      child:  CustomImage(width: 50,height: 50,
                      image: '${Provider.of<SplashProvider>(context, listen: false).baseUrls!.customerImageUrl}/${widget.user!.image}'),
                  )),

          ],
        ),

          title: Text(widget.user!.name ?? '', style: titilliumSemiBold),

          subtitle: Text(widget.user!.email??'', maxLines: 4,overflow: TextOverflow.ellipsis,
              style: titilliumRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall)),

          trailing: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,crossAxisAlignment: CrossAxisAlignment.end, children: [
            Text(widget.user!.phone??'', maxLines: 4,overflow: TextOverflow.ellipsis,
                style: titilliumRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall)),
           if(widget.user!.name != null)
            Container(padding:const EdgeInsets.all(3) ,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Theme.of(context).primaryColor,
              border: Border.all(color: Theme.of(context).hintColor.withOpacity(.25)),
                shape: BoxShape.rectangle,
              ),
                child: Text(getTranslated('${widget.user!.userType}', context)!,
                    style: textRegular.copyWith(color: Colors.white, fontSize: Dimensions.fontSizeSmall))
            ),
          ]),
          onTap: (){
            Navigator.push(Get.context!, MaterialPageRoute(builder: (_) =>
                  //ChatScreen(id:widget.user!.id, name: name, image: '${Provider.of<SplashProvider>(context, listen: false).baseUrls!.customerImageUrl}/${widget.user!.image}', isDelivery: widget.chatProvider.userTypeIndex == 1, phone: call)
                ChatScreen(id:widget.user!.id , name: widget.user!.name,image:'${Provider.of<SplashProvider>(context, listen: false).baseUrls!.customerImageUrl}/${widget.user!.image}',phone: widget.user!.phone,)

            ));
         // }
        }),

        const Divider(height: 1, color: ColorResources.chatIconColor),
      ],
    );
  }
}
