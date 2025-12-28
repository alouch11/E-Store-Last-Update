import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/features/auth/controllers/auth_controller.dart';
import 'package:flutter_spareparts_store/features/profile/provider/profile_provider.dart';
import 'package:flutter_spareparts_store/features/sale/view/sale_details_screen.dart';
import 'package:flutter_spareparts_store/features/sale/view/service_details_screen.dart';
import 'package:flutter_spareparts_store/helper/date_converter.dart';
import 'package:flutter_spareparts_store/localization/language_constrants.dart';
import 'package:flutter_spareparts_store/features/notification/provider/notification_provider.dart';
import 'package:flutter_spareparts_store/features/splash/provider/splash_provider.dart';
import 'package:flutter_spareparts_store/utill/color_resources.dart';
import 'package:flutter_spareparts_store/utill/custom_themes.dart';
import 'package:flutter_spareparts_store/utill/dimensions.dart';
import 'package:flutter_spareparts_store/utill/images.dart';
import 'package:flutter_spareparts_store/basewidget/custom_app_bar.dart';
import 'package:flutter_spareparts_store/basewidget/custom_image.dart';
import 'package:flutter_spareparts_store/basewidget/no_internet_screen.dart';
import 'package:flutter_spareparts_store/basewidget/paginated_list_view.dart';
import 'package:flutter_spareparts_store/features/dashboard/dashboard_screen.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class NotificationScreen extends StatefulWidget {
  final bool fromNotification;
  const NotificationScreen({super.key, this.fromNotification = false});
  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  ScrollController scrollController = ScrollController();

  @override
   initState(){
        Provider.of<NotificationProvider>(context, listen: false).getNotificationList(1,'external_service');
        Provider.of<NotificationProvider>(context, listen: false).notificationType='external_service';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar:  CustomAppBar(title: getTranslated('services_closed_by_others_technicians', context), onBackPressed: (){
        if(Navigator.of(context).canPop()){
          Navigator.of(context).pop();
        }else{
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => const DashBoardScreen()));

        }
      },),
      body: Consumer<NotificationProvider>(
        builder: (context, notification, child) {


          return
            //saleProvider.saleModel != null ? (saleProvider.saleModel!.sales != null && saleProvider.saleModel!.sales!.isNotEmpty)?

          /*RefreshIndicator(
            onRefresh: () async {
              await Provider.of<NotificationProvider>(context, listen: false).getNotificationList(1,'external_service');

            },*/
           // Expanded( child:
              notification.notificationModel != null ? (notification.notificationModel!.notification != null && notification.notificationModel!.notification!.isNotEmpty) ?
            SingleChildScrollView(
              controller: scrollController,
              child: PaginatedListView(
                 scrollController: scrollController,
                onPaginate: (int? offset) async {
                  await Provider.of<NotificationProvider>(context, listen: false).getNotificationList(offset!,'external_service');
                },
                totalSize: notification.notificationModel?.totalSize,
                offset:  notification.notificationModel?.offset,
                itemView: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: notification.notificationModel!.notification!.length,
                  padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                  itemBuilder: (context, index) {

                    //late String? user_id=notification.notificationModel!.notification![index].sentBy;



                    return InkWell(
                      onTap:(){
                        notification.seenNotification(notification.notificationModel!.notification![index].id!);

                        if(notification.notificationModel!.notification![index].notificationType=='external_service') {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => SaleDetailsScreen(saleId: notification.notificationModel!.notification![index].sourceId!)));
                        }
                        else{
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => ServiceDetailsScreen( serviceId: notification.notificationModel!.notification![index].sourceId!)));
                        }


                      },
                      child:

                    Consumer<ProfileProvider>(
                   builder: (context,profile,_)
                    {
                      return
                        Container(
                          color: Theme .of(context) .cardColor,
                          child: ListTile(
                            leading: Stack(children: [

                              /*ClipRRect(borderRadius: BorderRadius.circular(40),
                                child: Container(decoration: BoxDecoration(
                                  border: Border.all(color: Theme.of(context).primaryColor.withOpacity(.15), width: .35),
                                  borderRadius: BorderRadius.circular(40)),
                                  child: CustomImage(width: 50,height: 50,
                                    image: '${Provider.of<SplashProvider>(context, listen: false).baseUrls!.notificationImageUrl}/${notification.notificationModel!.notification![index].image}'),
                                ),),*/


                           ClipRRect(
                                  borderRadius: BorderRadius.circular(0),
                                  child:  Provider.of<AuthController>(
                                        context, listen: false).isLoggedIn() ?
                                    CustomImage(image: '${Provider
                                        .of<SplashProvider>(
                                        context, listen: false) .baseUrls! .customerImageUrl}/'
                                         '${notification.notificationModel!.notification![index].userImage}',

                                        width: 55,
                                        height: 55,
                                        fit: BoxFit.cover,
                                        placeholder: Images.guestProfile) :
                                       Image.asset(Images.guestProfile),),


                              if(notification.notificationModel!
                                  .notification![index].seen == null)
                                CircleAvatar(backgroundColor: Theme
                                    .of(context)
                                    .colorScheme
                                    .error
                                    .withOpacity(.75), radius: 3)
                            ],
                            ),
                            /*title: Text(notification.notificationModel!.notification![index].title??'',
                              style: titilliumRegular.copyWith(
                            fontSize: Dimensions.fontSizeSmall,
                          )),*/
                            title: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(notification.notificationModel!
                                      .notification![index].title ?? '',
                                      style: titilliumRegular.copyWith(
                                        fontSize: Dimensions.fontSizeSmall,
                                      )),
                                  if(notification.notificationModel!.notification![index].service !=null)
                                  Text(notification.notificationModel!
                                      .notification![index].service!.machine ??
                                      '',
                                      style: titilliumRegular.copyWith(color: Theme.of(context).primaryColor,
                                        fontSize: Dimensions.fontSizeSmall,
                                      )),
                                  if(notification.notificationModel!.notification![index].service !=null)
                                  Text(notification.notificationModel!
                                      .notification![index].service!
                                      .serviceman ?? '',
                                      style: titilliumRegular.copyWith(color: ColorResources.yellow,
                                        fontSize: Dimensions.fontSizeSmall,
                                      )),
                                ]),
                            subtitle: Text(
                              DateConverter.localDateToIsoStringAMPM(
                                  DateTime.parse(notification.notificationModel!
                                      .notification![index].createdAt!)),
                              style: titilliumRegular.copyWith(
                                  fontSize: Dimensions.fontSizeExtraSmall,
                                  color: ColorResources.getHint(context)),
                            ),
                          ),
                        );
                    })
                    );
                  },
                ),
              ),
            )
                : const NoInternetOrDataScreen(isNoInternet: false, message: 'no_notification', icon: Images.noNotification,)
                : const NotificationShimmer()
              ;

           // );
        },
      )
    );
  }
}

class NotificationShimmer extends StatelessWidget {
  const NotificationShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      padding: const EdgeInsets.all(0),
      itemBuilder: (context, index) {
        return Container(
          height: 80,
          margin: const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
          color: ColorResources.getGrey(context),
          alignment: Alignment.center,
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            //enabled: Provider.of<NotificationProvider>(context).notificationModel == null,
            enabled: true,
            child: ListTile(
              leading: const CircleAvatar(child: Icon(Icons.notifications)),
              title: Container(height: 20, color: ColorResources.white),
              subtitle: Container(height: 10, width: 50, color: ColorResources.white),
            ),
          ),
        );
      },
    );
  }
}

