import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/basewidget/show_custom_snakbar.dart';
import 'package:flutter_spareparts_store/data/model/api_response.dart';
import 'package:flutter_spareparts_store/features/dashboard-serviceman/domain/model/dashboard_model.dart';
import 'package:flutter_spareparts_store/features/dashboard-serviceman/domain/repo/dashboard_repo.dart';
import 'package:flutter_spareparts_store/helper/date_converter.dart';
import 'package:flutter_spareparts_store/helper/api_checker.dart';
import 'package:flutter_spareparts_store/main.dart';
import 'dart:async';

enum EarningType{monthly, yearly}
class DashboardProvider with ChangeNotifier {


  final DashboardRepo? dashboardRepo;
  DashboardProvider({required this.dashboardRepo});


  EarningType  _showMonthlyEarnStatisticsChart = EarningType.monthly;
  EarningType get getChartType => _showMonthlyEarnStatisticsChart;

  TopCards _topCards= TopCards();
  get cards => _topCards;

  List<DashboardService> _service = [];
  List<DashboardService> get services => _service;

  bool _isLoading=false;
  get isLoading=> _isLoading;

  bool _isLeapYear=false;
  get isLeapYear=> _isLeapYear;


  //Monthly Stats
  List<MonthlyStats> _monthlyStatsList =[];
  List<double> _mStatsList = [];
  List<FlSpot> _monthlyChartList = [];
  List<FlSpot> get monthlyChartList =>_monthlyChartList;


  //Monthly Amounts
  List<MonthlyAmounts> _monthlyAmountsList =[];
  List<double> _mAmountsList = [];
  List<FlSpot> _monthlyAmountsChartList = [];
  List<FlSpot> get monthlyAmountsChartList =>_monthlyAmountsChartList;

  double _mmM =0;
  double get mmM => _mmM;

  double _mmM1 =0;
  double get mmM1 => _mmM1;

  String _selectedYear = DateConverter.stringYear(DateTime.now());
  String get selectedYear => _selectedYear;
  String _selectedMonth = '';
  String get selectedMonth => _selectedMonth;


  //yearly Stats
  List<YearlyStats> _yearlyStatsList =[];
  List<double> _yStatsList = [];
  List<FlSpot> _yearlyChartList = [];
  List<FlSpot> get yearlyChartList =>_yearlyChartList;

  //yearly Amounts
  List<YearlyAmounts> _yearlyAmountsList =[];
  List<double> _yAmountsList = [];
  List<FlSpot> _yearlyAmountsChartList = [];
  List<FlSpot> get yearlyAmountsChartList =>_yearlyAmountsChartList;

  double _mmY =0;
  double get mmY => _mmY;

  double _mmY1 =0;
  double get mmY1 => _mmY1;

  List<dynamic>? _services;



  void onInit(){
    getMonthlyServicesDataForChart(DateConverter.stringYear(DateTime.now()),DateTime.now().month.toString());
    getYearlyServicesDataForChart(DateConverter.stringYear(DateTime.now()));

    getMonthlyServicesAmountForChart(DateConverter.stringYear(DateTime.now()),DateTime.now().month.toString());
    getYearlyServicesAmountForChart(DateConverter.stringYear(DateTime.now()));
  }

  Future<void> getDashboardData()async{
    _isLoading=true;
    _services=[];
    _service=[];

    ApiResponse apiResponse =  await dashboardRepo!.getDashboardData();

      if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {

      _topCards = TopCards.fromJson(apiResponse.response?.data['content'][0]['top_cards']);
      _services= apiResponse.response?.data['content'][1]['services'];
      for (var serviceman in _services!) {
        _service.add(DashboardService.fromJson(serviceman));
      }
    } else{
      ApiChecker.checkApi(apiResponse);
    }
    _isLoading=false;
    notifyListeners();
  }



  Future<void> getMonthlyServicesDataForChart(String year,String month,{bool isRefresh=false}) async {
    if(isRefresh){
      _selectedYear = DateConverter.stringYear(DateTime.now());
    }
    _monthlyStatsList = [];
    ApiResponse apiResponse = await dashboardRepo!.getMonthlyChartData(year,month);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _monthlyStatsList = [];
      _mStatsList = [];
      _monthlyChartList = [];
      List<dynamic> monthlyDynamicList= apiResponse.response?.data['content'][0]['service_stats'];
      for (var element in monthlyDynamicList) {
        _monthlyStatsList.add(MonthlyStats.fromJson(element));
      }


      if(month == '2'){
        int lip=0;
        bool isLeapYear(yer) => (yer % 4 == 0) && ((yer % 100 != 0) || (yer % 400 == 0));
        bool leapYear = isLeapYear(int.tryParse(year));
        if(leapYear == true){
          _isLeapYear=true;
          lip=30;
        }else {
          lip=29;
        }
        for(int i = 0; i<lip; i++){
          _mStatsList.add(0);
        }
      }else if(month == '4' || month == '6' || month == '9' || month == '11'){
        for(int i = 0; i<31; i++){
          _mStatsList.add(0);
        }
      }else if(month == '1' || month == '3' || month == '5' || month == '7' || month == '8' || month == '10' || month == '12'){
        for(int i = 0; i<32; i++){
          _mStatsList.add(0);
        }
      }

      for(int i = 0; i< _monthlyStatsList.length; i++){
        _mStatsList[_monthlyStatsList[i].day!] = _monthlyStatsList[i].total!.toDouble();
      }

      _monthlyChartList = _mStatsList.asMap().entries.map((e) {
        return FlSpot(e.key.toDouble(), e.value);
      }).toList();
      _mStatsList.sort();

      _mmM = _mStatsList[_mStatsList.length-1];
      _isLoading = false;

    }else {
       ApiChecker.checkApi(apiResponse);
    }
    if(apiResponse.response?.data["response_code"] != "default_200"){
      showCustomSnackBar(apiResponse.response?.data["errors"][0]["message"], Get.context!);

    }
    notifyListeners();
  }



  Future<void> getYearlyServicesDataForChart(String year,{bool isRefresh=false}) async {
    if(isRefresh){
      _selectedYear = DateConverter.stringYear(DateTime.now());
    }
    _yearlyStatsList = [];
    ApiResponse apiResponse = await dashboardRepo!.getYearlyChartData(year) ;
      if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _yearlyStatsList = [];
      _yStatsList = [];
      _yearlyChartList = [];
      List<dynamic> yearlyDynamicList= apiResponse.response?.data['content'][0]['service_stats'];
      for (var element in yearlyDynamicList) {
        _yearlyStatsList.add(YearlyStats.fromJson(element));
      }
      for(int i =0; i<13; i++){
        _yStatsList.add(0);
      }
      for(int i = 0; i< _yearlyStatsList.length; i++){
        _yStatsList[_yearlyStatsList[i].month!] = _yearlyStatsList[i].total!.toDouble();
      }
      _yearlyChartList = _yStatsList.asMap().entries.map((e) {
        return FlSpot(e.key.toDouble(), e.value);
      }).toList();
      _yStatsList.sort();
      _mmY = _yStatsList[_yStatsList.length-1];
      _isLoading = false;
    }else {
      ApiChecker.checkApi(apiResponse);
    }
    if(apiResponse.response?.data["response_code"] != "default_200"){
      showCustomSnackBar(apiResponse.response?.data["errors"][0]["message"],Get.context!);
    }
    notifyListeners();
  }



  void changeDashboardDropdownValue(String value,String type){
    if(type=="Year"){
      _selectedYear=value;
      if(_selectedYear !="Select" && _showMonthlyEarnStatisticsChart == EarningType.yearly){
        getYearlyServicesDataForChart(_selectedYear);
        getYearlyServicesAmountForChart(_selectedYear);
      }
    }else if(type=="Month"){
      _selectedMonth=value;
      if(_selectedYear !="Select"){
        getMonthlyServicesDataForChart(_selectedYear,value);
        getMonthlyServicesAmountForChart(_selectedYear,value);
      }
    }
   notifyListeners();
  }



//////////////////////////////////Amounts/////////////////////////////


  Future<void> getMonthlyServicesAmountForChart(String year,String month,{bool isRefresh=false}) async {
    if(isRefresh){
      _selectedYear = DateConverter.stringYear(DateTime.now());
    }
    _monthlyAmountsList = [];
    ApiResponse apiResponse = await dashboardRepo!.getMonthlyChartAmount(year,month);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _monthlyAmountsList = [];
      _mAmountsList = [];
      _monthlyAmountsChartList = [];
      List<dynamic> monthlyDynamicList= apiResponse.response?.data['content'][0]['service_amount'];
      for (var element in monthlyDynamicList) {
        _monthlyAmountsList.add(MonthlyAmounts.fromJson(element));
      }


      if(month == '2'){
        int lip=0;
        bool isLeapYear(yer) => (yer % 4 == 0) && ((yer % 100 != 0) || (yer % 400 == 0));
        bool leapYear = isLeapYear(int.tryParse(year));
        if(leapYear == true){
          _isLeapYear=true;
          lip=30;
        }else {
          lip=29;
        }
        for(int i = 0; i<lip; i++){
          _mAmountsList.add(0);
        }
      }else if(month == '4' || month == '6' || month == '9' || month == '11'){
        for(int i = 0; i<31; i++){
          _mAmountsList.add(0);
        }
      }else if(month == '1' || month == '3' || month == '5' || month == '7' || month == '8' || month == '10' || month == '12'){
        for(int i = 0; i<32; i++){
          _mAmountsList.add(0);
        }
      }

      for(int i = 0; i< _monthlyAmountsList.length; i++){
        _mAmountsList[_monthlyAmountsList[i].day!] = _monthlyAmountsList[i].total!.toDouble();
      }

      _monthlyAmountsChartList = _mAmountsList.asMap().entries.map((e) {
        return FlSpot(e.key.toDouble(), e.value);
      }).toList();
      _mAmountsList.sort();

      _mmM1 = _mAmountsList[_mAmountsList.length-1];
      _isLoading = false;

    }else {
      ApiChecker.checkApi(apiResponse);
    }
    if(apiResponse.response?.data["response_code"] != "default_200"){
      showCustomSnackBar(apiResponse.response?.data["errors"][0]["message"], Get.context!);

    }
    notifyListeners();
  }



  Future<void> getYearlyServicesAmountForChart(String year,{bool isRefresh=false}) async {
    if(isRefresh){
      _selectedYear = DateConverter.stringYear(DateTime.now());
    }
    _yearlyAmountsList = [];
    ApiResponse apiResponse = await dashboardRepo!.getYearlyChartAmount(year) ;
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _yearlyAmountsList = [];
      _yAmountsList = [];
      _yearlyAmountsChartList = [];
      List<dynamic> yearlyDynamicList= apiResponse.response?.data['content'][0]['service_amount'];
      for (var element in yearlyDynamicList) {
        _yearlyAmountsList.add(YearlyAmounts.fromJson(element));
      }
      for(int i =0; i<13; i++){
        _yAmountsList.add(0);
      }
      for(int i = 0; i< _yearlyAmountsList.length; i++){
        _yAmountsList[_yearlyAmountsList[i].month!] = _yearlyAmountsList[i].total!.toDouble();
      }
      _yearlyAmountsChartList = _yAmountsList.asMap().entries.map((e) {
        return FlSpot(e.key.toDouble(), e.value);
      }).toList();
      _yAmountsList.sort();
      _mmY1 = _yAmountsList[_yAmountsList.length-1];
      _isLoading = false;
    }else {
      ApiChecker.checkApi(apiResponse);
    }
    if(apiResponse.response?.data["response_code"] != "default_200"){
      showCustomSnackBar(apiResponse.response?.data["errors"][0]["message"],Get.context!);
    }
    notifyListeners();
  }



  void changeToYearlyEarnStatisticsChart(EarningType selectedType){
    _showMonthlyEarnStatisticsChart = selectedType;
    _selectedYear = DateConverter.stringYear(DateTime.now());
  //  notifyListeners();
  }


}
