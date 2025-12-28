import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/features/lines/view/lines_screen.dart';
import 'package:flutter_spareparts_store/features/order/view/order_details_screen.dart';
import 'package:flutter_spareparts_store/features/sale/view/sale_details_screen.dart';
import 'package:flutter_spareparts_store/features/sale/view/sale_screen.dart';
import 'package:flutter_spareparts_store/helper/network_info.dart';
import 'package:flutter_spareparts_store/features/splash/provider/splash_provider.dart';
import 'package:flutter_spareparts_store/utill/custom_themes.dart';
import 'package:flutter_spareparts_store/utill/dimensions.dart';
import 'package:flutter_spareparts_store/basewidget/custom_exit_card.dart';
import 'package:flutter_spareparts_store/localization/language_constrants.dart';
import 'package:flutter_spareparts_store/utill/images.dart';
import 'package:flutter_spareparts_store/features/home/view/aster_theme_home_page.dart';
import 'package:flutter_spareparts_store/features/home/view/fashion_theme_home_page.dart';
import 'package:flutter_spareparts_store/features/home/view/home_screens.dart';
import 'package:flutter_spareparts_store/features/more/more_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spareparts_store/features/category/view/all_category_screen.dart';
import 'package:flutter_spareparts_store/features/brand/views/all_brand_screen.dart';
import 'package:receive_intent/receive_intent.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});


  @override
  DashBoardScreenState createState() => DashBoardScreenState();
}

class DashBoardScreenState extends State<DashBoardScreen> {
  int _pageIndex = 0;
  late List<NavigationModel> _screens ;
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();
  final PageStorageBucket bucket = PageStorageBucket();

  bool singleVendor = false;



  String? dataString;

  @override
  void initState() {
    super.initState();
    singleVendor = Provider.of<SplashProvider>(context, listen: false).configModel!.businessMode == "single";
    //String? userType =  Provider.of<ProfileProvider>(context, listen: false).userInfoModel!.seeorder ?? '';

      _screens = [
        NavigationModel(
          name: 'home',
          icon: Images.homeImage,
          screen: (Provider.of<SplashProvider>(context, listen: false).configModel!.activeTheme == "default")?
        const HomePage():
       (Provider.of<SplashProvider>(context, listen: false).configModel!.activeTheme == "theme_aster")?
        const AsterThemeHomePage(): const FashionThemeHomePage()),

        if(!singleVendor)
          //NavigationModel(name: 'inbox', icon: Images.messageImage, screen: const InboxScreen(isBackButtonExist: false)),
          NavigationModel(name: 'CATEGORY', icon: Images.category, screen: AllCategoryScreen(isBackButton:false)),
          //NavigationModel(name: 'all_brand', icon: Images.brand, screen: const AllBrandScreen()),
          //NavigationModel(name: 'lines', icon: Images.line, screen: const LinesScreen()),
          NavigationModel(name: 'assets', icon: Images.line, screen: const LinesScreen()),
          NavigationModel(name: 'services', icon: Images.serviceIcon, screen:  const SaleScreen(isBacButtonExist: false)),
          NavigationModel(name: 'more', icon: Images.moreImage, screen:  const MoreScreen()),
      ];




    NetworkInfo.checkConnectivity(context);

  }

  @override
  Widget build(BuildContext context) {
    return PopScope(canPop: false,
      onPopInvoked: (val) async {
        if(_pageIndex != 0) {
          _setPage(0);
          return;
        }else {
        showModalBottomSheet(backgroundColor: Colors.transparent,
            context: context, builder: (_)=> const CustomExitCard());
        }
        return;
      },
      child: Scaffold(
        key: _scaffoldKey,

        body: PageStorage(bucket: bucket, child: _screens[_pageIndex].screen),
        bottomNavigationBar: Container(height: 65,
          decoration: BoxDecoration(borderRadius: const BorderRadius.vertical(top: Radius.circular(Dimensions.paddingSizeLarge)),
            color: Theme.of(context).cardColor,
            boxShadow: [BoxShadow(offset: const Offset(1,1), blurRadius: 2, spreadRadius: 1, color: Theme.of(context).primaryColor.withOpacity(.125))],),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: _getBottomWidget(singleVendor),
          ),),
      ),
    );
  }


  void _setPage(int pageIndex) {
    setState(() {
      _pageIndex = pageIndex;
    });
  }

  List<Widget> _getBottomWidget(bool isSingleVendor) {
    List<Widget> list = [];
    for(int index = 0; index < _screens.length; index++) {
      list.add(Expanded(child: CustomMenuItem(
        isSelected: _pageIndex == index,
        name: _screens[index].name,
        icon: _screens[index].icon,
        onTap: () => _setPage(index),
      )));
    }
    return list;
  }

}


class CustomMenuItem extends StatelessWidget {
  final bool isSelected;
  final String name;
  final String icon;
  final VoidCallback onTap;

  const CustomMenuItem({
    super.key, required this.isSelected, required this.name, required this.icon, required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      onTap: onTap,
      child: Padding(padding: const EdgeInsets.all(8),
        child: SizedBox(width: isSelected ? 90 : 50, child: Column(crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center, mainAxisSize: MainAxisSize.min, children: [

            Image.asset(icon, color: isSelected? Theme.of(context).primaryColor: Theme.of(context).hintColor,
                width: Dimensions.menuIconSize, height: Dimensions.menuIconSize),

            isSelected ?
             Text(getTranslated(name, context)!, maxLines: 1, overflow: TextOverflow.ellipsis,
              style: textBold.copyWith(color:  Theme.of(context).primaryColor)) :

            Text(getTranslated(name, context)!, maxLines: 1, overflow: TextOverflow.ellipsis,
                style: textRegular.copyWith(color: Theme.of(context).hintColor)),

            if(isSelected)
              Container(width: 40,height: 3,
                decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.circular(Dimensions.paddingSizeDefault)),)

          ],
        )),
      ),
    );
  }

}

class NavigationModel {
  String name;
  String icon;
  Widget screen;
  NavigationModel({required this.name, required this.icon,  required this.screen});
}
