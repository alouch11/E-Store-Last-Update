import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/features/notification/provider/notification_provider.dart';
import 'package:flutter_spareparts_store/features/notification/view/notification_screen_read.dart';
import 'package:flutter_spareparts_store/features/notification/view/notification_screen_unread.dart';
import 'package:flutter_spareparts_store/features/notification/view/notification_service_screen_unread.dart';
import 'package:flutter_spareparts_store/features/notification/view/notification_tab_item.dart';
import 'package:flutter_spareparts_store/utill/color_resources.dart';
import 'package:provider/provider.dart';
import '../../../localization/language_constrants.dart';
import '../../../main.dart';
import '../../../utill/custom_themes.dart';
import '../../../utill/dimensions.dart';
import '../../auth/controllers/auth_controller.dart';


class NotificationsTabsScreen extends StatefulWidget {
  final bool fromNotification;

  const NotificationsTabsScreen({super.key,this.fromNotification = false});
  @override
  State<NotificationsTabsScreen> createState() => _NotificationsTabsScreenState();

}

  class _NotificationsTabsScreenState extends State<NotificationsTabsScreen> {
  ScrollController scrollController  = ScrollController();
  bool isGuestMode = !Provider.of<AuthController>(Get.context!, listen: false).isLoggedIn();

  @override
  initState(){
    super.initState();
  }



  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length:2,
      child: Scaffold(
        appBar: AppBar(
          title:
          Text('${getTranslated('notification', context)}'),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(40),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: Container(
                alignment: Alignment.center,
                height: 40,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.transparent,
                ),

                child:  TabBar(
                   isScrollable: true,
                  padding: const EdgeInsets.all(0),
                  labelColor: ColorResources.blue,
                unselectedLabelColor: ColorResources.black,
                indicatorColor: ColorResources.blue,
                indicatorWeight: 3,
                indicatorPadding: const EdgeInsets.symmetric(horizontal:3),
                unselectedLabelStyle: textRegular.copyWith(
                    fontSize: Dimensions.fontSizeLarge,
                    fontWeight: FontWeight.w400),
                labelStyle: textRegular.copyWith(
                  fontSize: Dimensions.fontSizeLarge,
                  fontWeight: FontWeight.w900,
                ),
                  indicatorSize: TabBarIndicatorSize.label,
                  dividerColor: Colors.transparent,
                  tabs:   [

                    NotificationsTabItem(title: '${getTranslated('unread', context)}'),

                  //  NotificationsTabItem(title: '${getTranslated('service', context)}'),

                    NotificationsTabItem(title: '${getTranslated('read', context)}'),
                  ],
                ),

              ),
            ),
          ),
        ),
        body:  const TabBarView(
          children: [
             Padding(padding: EdgeInsets.fromLTRB( Dimensions.paddingSizeSmall,  Dimensions.paddingSizeSmall,  Dimensions.paddingSizeSmall,0),
                  child: NotificationScreenUnread()
             ),

           /* Padding(padding: EdgeInsets.fromLTRB( Dimensions.paddingSizeSmall,  Dimensions.paddingSizeSmall,  Dimensions.paddingSizeSmall,0),
                child: NotificationServiceScreenUnread()
            ),
*/

            Padding(padding: EdgeInsets.fromLTRB( Dimensions.paddingSizeSmall,  Dimensions.paddingSizeSmall,  Dimensions.paddingSizeSmall,0),
                child: NotificationScreenRead()
            ),
          ],
        ),
      ),
    );
  }

}

