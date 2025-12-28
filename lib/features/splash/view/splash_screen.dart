import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spareparts_store/basewidget/show_custom_snakbar.dart';
import 'package:flutter_spareparts_store/features/home/view/home_screens.dart';
import 'package:flutter_spareparts_store/features/home/widget/notifications_widget_home_page.dart';
import 'package:flutter_spareparts_store/features/lines/provider/machines_provider.dart';
import 'package:flutter_spareparts_store/features/lines/view/lines_screen.dart';
import 'package:flutter_spareparts_store/features/lines/view/machine_screen_extra.dart';
import 'package:flutter_spareparts_store/features/maintenance/update_screen.dart';
import 'package:flutter_spareparts_store/features/order/provider/order_provider.dart';
import 'package:flutter_spareparts_store/features/profile/provider/profile_provider.dart';
import 'package:flutter_spareparts_store/features/sale/provider/sale_provider.dart';
import 'package:flutter_spareparts_store/features/sale/view/sale_details_screen.dart';
import 'package:flutter_spareparts_store/localization/language_constrants.dart';
import 'package:flutter_spareparts_store/push_notification/model/notification_body.dart';
import 'package:flutter_spareparts_store/features/auth/controllers/auth_controller.dart';
import 'package:flutter_spareparts_store/features/splash/provider/splash_provider.dart';
import 'package:flutter_spareparts_store/utill/app_constants.dart';
import 'package:flutter_spareparts_store/utill/custom_themes.dart';
import 'package:flutter_spareparts_store/utill/dimensions.dart';
import 'package:flutter_spareparts_store/utill/images.dart';
import 'package:flutter_spareparts_store/basewidget/no_internet_screen.dart';
import 'package:flutter_spareparts_store/features/auth/views/auth_screen.dart';
import 'package:flutter_spareparts_store/features/dashboard/dashboard_screen.dart';
import 'package:flutter_spareparts_store/features/maintenance/maintenance_screen.dart';
import 'package:flutter_spareparts_store/features/order/view/order_details_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spareparts_store/features/chat/view/inbox_screen.dart';
import 'package:receive_intent/receive_intent.dart'as rn;
import '../../notification/view/notifications_tab_screen.dart';

class SplashScreen extends StatefulWidget {
  final NotificationBody? body;
  const SplashScreen({super.key, this.body});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  final GlobalKey<ScaffoldMessengerState> _globalKey = GlobalKey();
  late StreamSubscription<ConnectivityResult> _onConnectivityChanged;
  late StreamSubscription<ConnectivityResult> _intentSubscription;


  String? dataString ;
  //String? _receivedData;

  @override
  void initState() {
    super.initState();

    bool firstTime = true;
    _onConnectivityChanged = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if(!firstTime) {
        bool isNotConnected = result != ConnectivityResult.wifi && result != ConnectivityResult.mobile;
        isNotConnected ? const SizedBox() : ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: isNotConnected ? Colors.red : Colors.green,
          duration: Duration(seconds: isNotConnected ? 6000 : 3),
          content: Text(isNotConnected ? getTranslated('no_connection', context)! : getTranslated('connected', context)!,
            textAlign: TextAlign.center)));
        if(!isNotConnected) {
          _route();
        }
      }
      firstTime = false;
    });

    _route();


  }





  @override
  void dispose() {
    super.dispose();
    _onConnectivityChanged.cancel();
    _intentSubscription.cancel();

  }



  void _route() {
    Provider.of<SplashProvider>(context, listen: false).initConfig(context).then((bool isSuccess) {
      if(isSuccess) {
        Provider.of<ProfileProvider>(context, listen: false).getUserInfo(context);
        Provider.of<SplashProvider>(context, listen: false).initSharedPrefData();
        Timer(const Duration(seconds: 1), () async {
          if(Provider.of<SplashProvider>(context, listen: false).configModel!.maintenanceMode!) {
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => const MaintenanceScreen()));
          }

          else if(compareVersions(Provider.of<SplashProvider>(context, listen: false).configModel!.userAppVersionControl!.forAndroid!.version!, AppConstants.appVersion) == 1) {
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => const UpdateScreen()));
          }

          else if(Provider.of<AuthController>(context, listen: false).isLoggedIn()){
            Provider.of<AuthController>(context, listen: false).updateToken(context);
            if(widget.body != null){
              if (widget.body!.type == 'order') {
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) =>  OrderDetailsScreen(orderId: widget.body!.orderId,isNotification: true,)));
              }
              else if (widget.body!.type == 'sale') {
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) =>  SaleDetailsScreen(saleId: widget.body!.saleId,isNotification: true,)));
              }
              else if(widget.body!.type == 'notification'){
                //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) =>  const NotificationScreen()));
                //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) =>  const NotificationsTabsScreen()));
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) =>  const NotificationsWidgetHomePage()));
              }
              else if(widget.body!.type == 'chatting') {
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => const InboxScreen(isBackButtonExist: true,)));

              }
            }
            else{
              try {

                final initialIntent = await rn.ReceiveIntent.getInitialIntent();


                /*rn.ReceiveIntent.receivedIntentStream.listen(
                      (rn.Intent? intent) {
                    if (intent != null) {
                      setState(() {
                        _receivedData = intent.data;
                      });
                    }
                  },
                  onError: (err) {
                    print("Error listening to intent stream: $err");
                  },
                );*/



                if (initialIntent != null) {
                   dataString = initialIntent.data ??'No data';
                   }

                /*else if (_receivedData != null) {
                dataString = _receivedData ??'No data';
                }
                */
                else {
                  dataString = 'No data';
                }
                print("Initial Intent Data: $dataString");
                if(dataString != 'No data'){
                  String qrcode =dataString!.replaceAll("qr.spestore://","");
                  List<String> parts = qrcode.split('/') ?? [];
                  String type = parts[0].trim() ?? '';
                  String id = parts[1].trim() ?? '';
                  switch (type) {

                    case "order":
                       //Provider.of<OrderProvider>(context, listen: false).trackYourOrder(orderNo: id.toString(), orderType: '').then((value) {
                        Provider.of<OrderProvider>(context, listen: false).getOrderDetails(id).then((value) {
                        if (value.response != null && value.response!.statusCode == 200) {
                          int? orderId = value.response!.data[0]['BLMASKODU'];
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) =>  OrderDetailsScreen(orderId: orderId,isNotification: true,)));

                        }
                        else
                        {
                          showCustomSnackBar('Order Not Found', context);
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) =>  const DashBoardScreen()));
                        }
                      });
                       break;

                    case "sale":
                           //Provider.of<SaleProvider>(context, listen: false).trackYourSale(saleNo: id.toString()).then((value) {
                          //Provider.of<SaleProvider>(context, listen: false).getServiceInfo(int.parse(id)).then((value) {
                            Provider.of<SaleProvider>(context, listen: false).getSaleDetails(id).then((value) {
                          if (value.response != null && value.response!.statusCode == 200) {
                          int? saleId = value.response!.data[0]['BLMASKODU'];
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) =>  SaleDetailsScreen(saleId: saleId,isNotification: true,)));
                          }
                        else
                        {
                          showCustomSnackBar('Sale Not Found', context);
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) =>  const DashBoardScreen()));
                        }
                      });
                         break;

                    case "asset":
                           Provider.of<MachinesProvider>(context, listen: false).searchAsset(assetCode:id).then((value) {
                        if (value.response != null  && value.response!.statusCode == 200 && value.response!.data.isNotEmpty) {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => MachineScreenExtra(machineModel:Provider.of<MachinesProvider>(context, listen: false).machinesSearch,isNotification: true,)));
                        }
                        else
                          {
                            showCustomSnackBar('No Asset Found', context);
                           Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) =>  const DashBoardScreen()));
                          }
                      });
                      break;

                    default:
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) =>  const DashBoardScreen()));
                       }
                }
                else {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => const DashBoardScreen()));
                }
              }
              on PlatformException {
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) =>   const DashBoardScreen()));
              }
            }
          }
          else{
            if(Provider.of<AuthController>(context, listen: false).getGuestToken() != null && Provider.of<AuthController>(context, listen: false).getGuestToken() != '1'){
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => const DashBoardScreen()));
            }else{
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => const AuthScreen()));
            }
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      key: _globalKey,
      body: Provider.of<SplashProvider>(context).hasConnection ?
      Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
        SizedBox(width: 100, child: Image.asset(Images.icon, width: 100.0)),
        Text(AppConstants.appName,style: textRegular.copyWith(fontSize: Dimensions.fontSizeOverLarge, color: Colors.white)),
        Padding(padding: const EdgeInsets.only(top: Dimensions.paddingSizeSmall),
            child: Text(AppConstants.slogan,style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault, color: Colors.white)))]),
      ) : const NoInternetOrDataScreen(isNoInternet: true, child: SplashScreen()),
    );
  }

}


int compareVersions(String version1, String version2) {
  List<String> v1Components = version1.split('.');
  List<String> v2Components = version2.split('.');
  for (int i = 0; i < v1Components.length; i++) {
    int v1Part = int.parse(v1Components[i]);
    int v2Part = int.parse(v2Components[i]);
    if (v1Part > v2Part) {
      return 1;
    } else if (v1Part < v2Part) {
      return -1;
    }
  }
  return 0;
}


