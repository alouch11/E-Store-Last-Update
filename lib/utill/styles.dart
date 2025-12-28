import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/utill/dimensions.dart';
import 'package:get/get.dart';


const rubikRegular =  TextStyle(
  fontFamily: 'Rubik',
  fontSize: Dimensions.fontSizeDefault,
  fontWeight: FontWeight.w400,
);

const robotoRegular = TextStyle(
  fontFamily: 'Ubuntu',
  fontWeight: FontWeight.w400,
  fontSize: Dimensions.fontSizeDefault,
);

const ubuntuLight = TextStyle(
  fontFamily: 'Ubuntu',
  fontWeight: FontWeight.w300,
);

const ubuntuRegular = TextStyle(
  fontFamily: 'Ubuntu',
  fontWeight: FontWeight.w400,
);

TextStyle ubuntuRegularLow = const TextStyle(
  fontFamily: 'Ubuntu',
  fontWeight: FontWeight.w400,
  fontSize: Dimensions.fontSizeSmall,
);

TextStyle ubuntuRegularMid = const TextStyle(
  fontFamily: 'Ubuntu',
  fontWeight: FontWeight.w400,
  fontSize: Dimensions.fontSizeDefault,
);

const ubuntuMedium = TextStyle(
  fontFamily: 'Ubuntu',
  fontWeight: FontWeight.w500,
);

TextStyle ubuntuMediumLow = const TextStyle(
  fontFamily: 'Ubuntu',
  fontWeight: FontWeight.w500,
  fontSize: Dimensions.fontSizeSmall,
);

TextStyle ubuntuMediumMid = const TextStyle(
  fontFamily: 'Ubuntu',
  fontWeight: FontWeight.w500,
  fontSize: Dimensions.fontSizeDefault,
);

TextStyle ubuntuMediumHigh = const TextStyle(
  fontFamily: 'Ubuntu',
  fontWeight: FontWeight.w500,
  fontSize: Dimensions.fontSizeLarge,
);



const ubuntuBold = TextStyle(
  fontFamily: 'Ubuntu',
  fontWeight: FontWeight.w700,
);

TextStyle ubuntuBoldLow = const TextStyle(
    fontFamily: 'Ubuntu',
    fontWeight: FontWeight.w700,
    fontSize: Dimensions.fontSizeSmall
);

TextStyle ubuntuBoldMid = const TextStyle(
  fontFamily: 'Ubuntu',
  fontWeight: FontWeight.w700,
  fontSize: Dimensions.fontSizeDefault
);

TextStyle ubuntuBoldHigh = const TextStyle(
    fontFamily: 'Ubuntu',
    fontWeight: FontWeight.w700,
    fontSize: Dimensions.fontSizeExtraLarge
);

List<BoxShadow>? shadow = Get.isDarkMode? null:[BoxShadow(
  offset: const Offset(0, 1),
  blurRadius: 1,
  color: Colors.black.withOpacity(0.1),
)];

List<BoxShadow>? lightShadow = [BoxShadow(
    offset: const Offset(10,5),
    color: Colors.grey[100]!, blurRadius: 7, spreadRadius: 5)];