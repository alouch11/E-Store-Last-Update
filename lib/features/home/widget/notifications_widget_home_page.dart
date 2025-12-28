import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/features/notification/provider/notification_provider.dart';
import 'package:flutter_spareparts_store/features/notification/view/notification_screen.dart';
import 'package:flutter_spareparts_store/features/notification/view/notifications_tab_screen.dart';
import 'package:flutter_spareparts_store/utill/color_resources.dart';
import 'package:flutter_spareparts_store/utill/custom_themes.dart';
import 'package:flutter_spareparts_store/utill/dimensions.dart';
import 'package:flutter_spareparts_store/utill/images.dart';
import 'package:provider/provider.dart';


class NotificationsWidgetHomePage extends StatefulWidget {

    const NotificationsWidgetHomePage({super.key});

   @override
   State<NotificationsWidgetHomePage> createState() => _NotificationsWidgetHomePageState();

}class _NotificationsWidgetHomePageState extends State<NotificationsWidgetHomePage> {


  @override
  Widget build(BuildContext context) {



    return Row(
      children: [
        Consumer<NotificationProvider>(
          builder: (context, notificationProvider, _) {
                return IconButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationsTabsScreen())),
              icon: Stack(clipBehavior: Clip.none, children: [
                Image.asset(Images.notification,
                    height: Dimensions.iconSizeDefault,
                    width: Dimensions.iconSizeDefault,
                    color: ColorResources.getPrimary(context)),
                Positioned(top: -4, right: -4,
                  child: CircleAvatar(radius: 7, backgroundColor: ColorResources.red,
                    child: Text(notificationProvider.notificationModel?.newNotificationItem.toString() ?? '0',
                        style: titilliumSemiBold.copyWith(color: ColorResources.white, fontSize: Dimensions.fontSizeExtraSmall,
                        )),
                  ),
                ),

              ]),
            );
          }
        ),

        Padding(
          padding: const EdgeInsets.only(right: 12.0),
         child: IconButton(
               onPressed: () =>
                   Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationScreen()

             )),
           icon: Stack(clipBehavior: Clip.none, children: [
             Image.asset(Images.notificationService,
                  height: Dimensions.iconSizeDefault,
                  width: Dimensions.iconSizeDefault,
                 color: ColorResources.getPrimary(context)),
              Positioned(top: -4, right: -4,
               child: Consumer<NotificationProvider>(builder: (context, notificationProvider, child) {
                return CircleAvatar(radius: 7, backgroundColor: ColorResources.red,
                  child: Text(notificationProvider.notificationModel?.newNotificationServiceItem.toString() ?? '0',
                       style: titilliumSemiBold.copyWith(color: ColorResources.white, fontSize: Dimensions.fontSizeExtraSmall,
                       )),
                  );
               }),
              ),
           ]),
         ),
       )
      ],
    );
  }
}
