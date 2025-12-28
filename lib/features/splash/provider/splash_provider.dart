import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/data/model/api_response.dart';
import 'package:flutter_spareparts_store/features/splash/domain/model/config_model.dart';
import 'package:flutter_spareparts_store/features/splash/domain/repo/splash_repo.dart';
import 'package:flutter_spareparts_store/helper/api_checker.dart';
import 'package:receive_intent/receive_intent.dart';

class SplashProvider extends ChangeNotifier {
  final SplashRepo? splashRepo;
  SplashProvider({required this.splashRepo});

  ConfigModel? _configModel;
  BaseUrls? _baseUrls;
  CurrencyList? _myCurrency;
  CurrencyList? _usdCurrency;
  CurrencyList? _defaultCurrency;
  int? _currencyIndex;
  bool _hasConnection = true;
  bool _fromSetting = false;
  bool _firstTimeConnectionCheck = true;
  bool _onOff = true;
  bool get onOff => _onOff;

  String? _packagelines;
  String? _packagehours;
  String? _packagemachines;

  String?  _orderLinesFilter;
  String? _orderMachineFilter;
  String?  _orderPersonFilter;
  String?  _orderTypeFilter;
  String? _orderSupplierFilter;

  String?  _serviceLinesFilter;
  String? _serviceMachineFilter;
  String?  _servicePersonFilter;
  String?  _serviceTypeFilter;

  List<LinesMachines>? _linesMachines;

  ConfigModel? get configModel => _configModel;
  BaseUrls? get baseUrls => _baseUrls;
  CurrencyList? get myCurrency => _myCurrency;
  CurrencyList? get usdCurrency => _usdCurrency;
  CurrencyList? get defaultCurrency => _defaultCurrency;
  int? get currencyIndex => _currencyIndex;
  bool get hasConnection => _hasConnection;
  bool get fromSetting => _fromSetting;
  bool get firstTimeConnectionCheck => _firstTimeConnectionCheck;

  String? get packagelines => _packagelines;
  String? get packagehours => _packagehours;
  String? get packagemachines => _packagemachines;


  String? get orderLinesFilter => _orderLinesFilter;
  String? get orderMachineFilter => _orderMachineFilter;
  String? get orderPersonFilter => _orderPersonFilter;
  String? get orderTypeFilter => _orderTypeFilter;
  String? get orderSupplierFilter => _orderSupplierFilter;


  String? get serviceLinesFilter => _serviceLinesFilter;
  String? get serviceMachineFilter => _serviceMachineFilter;
  String? get servicePersonFilter => _servicePersonFilter;
  String? get serviceTypeFilter => _serviceTypeFilter;

  List<LinesMachines>? get linesMachines => _linesMachines;


  Future<bool> initConfig(BuildContext context) async {
    _hasConnection = true;
    ApiResponse apiResponse = await splashRepo!.getConfig();
    bool isSuccess;
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _configModel = ConfigModel.fromJson(apiResponse.response!.data);
      _baseUrls = ConfigModel.fromJson(apiResponse.response!.data).baseUrls;
      String? currencyCode = splashRepo!.getCurrency();
     for(CurrencyList currencyList in _configModel!.currencyList!) {
        if(currencyList.id == _configModel!.systemDefaultCurrency) {
          if(currencyCode == null || currencyCode.isEmpty) {
            currencyCode = currencyList.code;
          }
          _defaultCurrency = currencyList;
        }
        if(currencyList.code == 'USD') {
          _usdCurrency = currencyList;
        }
      }
      getCurrencyData(currencyCode);
      //getCurrencyData('USD');

      isSuccess = true;

      _packagelines= _configModel!.packagelines?? '';
      _packagehours= _configModel!.packagehours?? '';
      _packagemachines= _configModel!.packagemachines?? '';


       _orderLinesFilter= _configModel!.orderLinesFilter?? '';
      _orderMachineFilter=  _configModel!.orderMachinesFilter?? '';
      _orderPersonFilter= _configModel!.orderPersonsFilter?? '';
      _orderTypeFilter= _configModel!.orderTypesFilter?? '';
      _orderSupplierFilter=  _configModel!.orderSuppliersFilter?? '';


      _serviceLinesFilter= _configModel!.serviceLinesFilter?? '';
      _serviceMachineFilter=  _configModel!.serviceMachinesFilter?? '';
      _servicePersonFilter= _configModel!.servicePersonsFilter?? '';
      _serviceTypeFilter= _configModel!.serviceTypesFilter?? '';

      _linesMachines= _configModel!.linesMachines?? [];




    } else {
      isSuccess = false;
      ApiChecker.checkApi( apiResponse);
      if(apiResponse.error.toString() == 'Connection to API server failed due to internet connection') {
        _hasConnection = false;
      }
    }
    notifyListeners();
    return isSuccess;



  }


  void setFirstTimeConnectionCheck(bool isChecked) {
    _firstTimeConnectionCheck = isChecked;
  }

  void getCurrencyData(String? currencyCode) {
    for (var currency in _configModel!.currencyList!) {
      if(currencyCode == currency.code) {
        _myCurrency = currency;
        _currencyIndex = _configModel!.currencyList!.indexOf(currency);
        continue;
      }
    }
  }


  void setCurrency(int index) {
    splashRepo!.setCurrency(_configModel!.currencyList![index].code!);
    getCurrencyData(_configModel!.currencyList![index].code);
    notifyListeners();
  }

  void initSharedPrefData() {
    splashRepo!.initSharedData();
  }

  void setFromSetting(bool isSetting) {
    _fromSetting = isSetting;
  }

  bool? showIntro() {
    return splashRepo!.showIntro();
  }

  void disableIntro() {
    splashRepo!.disableIntro();
  }

  void changeAnnouncementOnOff(bool on){
    _onOff = !_onOff;
    notifyListeners();
  }



}
