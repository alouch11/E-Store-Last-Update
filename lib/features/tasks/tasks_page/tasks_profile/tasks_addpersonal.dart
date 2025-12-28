import 'package:flutter_spareparts_store/features/tasks/taks_gloabelclass/tasks_color.dart';
import 'package:flutter_spareparts_store/features/tasks/taks_gloabelclass/tasks_fontstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/utill/images.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../tasks_theme/tasks_themecontroller.dart';

// ignore: must_be_immutable
class TasksAddPersonal extends StatefulWidget {
  String? type;
  TasksAddPersonal(this.type, {super.key});

  @override
  State<TasksAddPersonal> createState() => _TasksAddPersonalState();
}

class _TasksAddPersonalState extends State<TasksAddPersonal> {
  dynamic size;
  double height = 0.00;
  double width = 0.00;
  int isselected = 0;
  int selecttime = 0;
  DateTime? _selectedDay;
  String? selectdate;
  final themedata = Get.put(TasksThemecontroler());
  List type = ["Personal","Private","Secret"];

  List tag = ["Office","Home","Urgent","Work"];

  List color = [
    TasksColor.bgpurple,
    TasksColor.bgred,
    const Color(0xffFFE9ED),
    TasksColor.bgsky,
  ];

  List textcolor = [
    TasksColor.purple,
    TasksColor.lightred,
    TasksColor.lightred,
    TasksColor.textblue,
  ];

  List hour = ["05","06","07","08","09","10","11","12"];
  List min = ["25","26","27","28","29","30","31","32"];
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(10),
          child: InkWell(
            splashColor: TasksColor.transparent,
            highlightColor: TasksColor.transparent,
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              height: height/20,
              width: height/20,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: TasksColor.white,
                  boxShadow: const [
                    BoxShadow(color: TasksColor.textgray,blurRadius: 5)
                  ]
              ),
              child: Padding(
                padding: EdgeInsets.only(left: width/56),
                child: const Icon(
                  Icons.arrow_back_ios,
                  size: 18,
                  color: TasksColor.black,
                ),
              ),
            ),
          ),
        ),
        title:  Text(widget.type == "personal"
            ? "Add_personal".tr
            : widget.type == "work"
            ?  "Add_work".tr
            : widget.type == "private"
            ?  "Add_private".tr:widget.type == "event"?"Add_Events".tr
            :  "Add_metting".tr,style: hsSemiBold.copyWith(fontSize: 18),),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width/36,vertical: height/36),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Tittle".tr,style: hsSemiBold.copyWith(fontSize: 14,color: TasksColor.textgray),),
              TextField(
                style: hsMedium.copyWith(fontSize: 16,color: themedata.isdark?TasksColor.white:TasksColor.black),
                decoration: InputDecoration(
                    hintStyle: hsMedium.copyWith(fontSize: 16,color: TasksColor.textgray),
                    hintText: "Plan for a month",
                    border: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: TasksColor.greyy)
                    )
                ),
              ),
              SizedBox(height: height/36,),
              Text("Date".tr,style: hsSemiBold.copyWith(fontSize: 14,color: TasksColor.textgray),),
              TextField(
                style: hsMedium.copyWith(fontSize: 16,color: themedata.isdark?TasksColor.white:TasksColor.black),
                decoration: InputDecoration(
                    hintStyle: hsMedium.copyWith(fontSize: 16,color: TasksColor.textgray),
                    hintText: "4 August 2021",
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(12),
                      child: InkWell(
                          splashColor: TasksColor.transparent,
                          highlightColor: TasksColor.transparent,
                          onTap: () {
                            calendar();
                          },
                          child: Image.asset(Images.calendar,height: height/36,color: TasksColor.textgray)),
                    ),
                    border: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: TasksColor.greyy)
                    )
                ),
              ),
              SizedBox(height: height/36,),
              Text("Time".tr,style: hsSemiBold.copyWith(fontSize: 14,color: TasksColor.textgray),),
              Row(
                children: [
                  SizedBox(
                    width: width/2.2,
                    child: InkWell(
                      splashColor: TasksColor.transparent,
                      highlightColor: TasksColor.transparent,
                      onTap: () {
                        edittime();
                      },
                      child: TextField(
                        enabled: false,
                        style: hsMedium.copyWith(fontSize: 16,color: themedata.isdark?TasksColor.white:TasksColor.black),
                        decoration: InputDecoration(
                            hintStyle: hsMedium.copyWith(fontSize: 16,color: TasksColor.textgray),
                            hintText: "07:00 AM",
                            border: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(color: TasksColor.greyy)
                            )
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: width/2.2,
                    child: TextField(
                      style: hsMedium.copyWith(fontSize: 16,color: themedata.isdark?TasksColor.white:TasksColor.black),
                      decoration: InputDecoration(
                          hintStyle: hsMedium.copyWith(fontSize: 16,color: TasksColor.textgray),
                          hintText: "07:30 AM",
                          border: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: TasksColor.greyy)
                          )
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: height/36,),
              Text("Description".tr,style: hsSemiBold.copyWith(fontSize: 14,color: TasksColor.textgray),),
              TextField(
                style: hsMedium.copyWith(fontSize: 16,color: themedata.isdark?TasksColor.white:TasksColor.black),
                decoration: InputDecoration(
                    hintStyle: hsMedium.copyWith(fontSize: 16,color: TasksColor.textgray),
                    hintText: "Creating this month's work plan",
                    border: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: TasksColor.greyy)
                    )
                ),
              ),
              SizedBox(height: height/36,),
              Text("Type".tr,style: hsSemiBold.copyWith(fontSize: 14,color: TasksColor.textgray),),
              SizedBox(height: height/36,),
              SizedBox(
                height: height/26,
                child: ListView.builder(
                  itemCount: type.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(right: width/20),
                      child: InkWell(
                        splashColor: TasksColor.transparent,
                        highlightColor: TasksColor.transparent,
                        onTap: () {
                          setState(() {
                            isselected = index;
                          });
                        },
                        child: Row(
                          children: [
                            Icon(isselected == index?Icons.check_box_sharp:Icons.check_box_outline_blank,size: 22,color: isselected == index?TasksColor.appcolor:TasksColor.textgray,),
                            SizedBox(width: width/36,),
                            Text(type[index],style: hsRegular.copyWith(fontSize: 16,),),
                          ],
                        ),
                      ),
                    );
                  },),
              ),
              SizedBox(height: height/36,),
              Text("Tags".tr,style: hsSemiBold.copyWith(fontSize: 14,color: TasksColor.textgray),),
              SizedBox(height: height/36,),
              SizedBox(
                height: height/21,
                child: ListView.builder(
                  itemCount: tag.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return  Container(
                      margin: EdgeInsets.only(right: width/36),
                      height: height/22,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: color[index]
                      ),
                      child: Center(child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: width/20),
                        child: Text(tag[index],style: hsRegular.copyWith(fontSize: 14,color: textcolor[index]),),
                      )),
                    );
                  },),
              ),
              SizedBox(height: height/36,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                      splashColor: TasksColor.transparent,
                      highlightColor: TasksColor.transparent,
                      onTap: () {
                        newtag();
                      },
                      child: Text("+ Add new tag".tr,style: hsMedium.copyWith(fontSize: 14,color: TasksColor.textappcolor),)),
                ],
              ),
              SizedBox(height: height/26,),
              InkWell(
                splashColor: TasksColor.transparent,
                highlightColor: TasksColor.transparent,
                /*onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return TasksDashboard("0");
                  },));
                },*/
                child: Container(
                  width: width/1,
                  height: height/15,
                  decoration: BoxDecoration(
                      color: TasksColor.appcolor,
                      borderRadius: BorderRadius.circular(14)
                  ),
                  child: Center(child: Text("Create".tr,style: hsSemiBold.copyWith(fontSize: 16,color: TasksColor.white),)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> calendar() async {
    return await showDialog(
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            Column(
              children: [
                TableCalendar(
                  firstDay: DateTime.now(),
                  focusedDay: DateTime.now(),
                  lastDay: DateTime.utc(2050, 3, 14),
                  headerVisible: true,
                  daysOfWeekVisible: true,
                  calendarStyle: const CalendarStyle(
                    todayDecoration: BoxDecoration(
                      color: TasksColor.appcolor,
                      shape: BoxShape.circle,
                    ),
                    todayTextStyle: TextStyle(
                      color: TasksColor.white,
                    ),
                    selectedDecoration: BoxDecoration(
                      color: TasksColor.appcolor,
                      shape: BoxShape.circle,
                    ),
                    selectedTextStyle: TextStyle(
                      color: TasksColor.white,
                    ),
                  ),
                  shouldFillViewport: false,
                  currentDay: _selectedDay,
                  calendarFormat: CalendarFormat.month,
                  pageAnimationEnabled: false,
                  headerStyle: HeaderStyle(
                      leftChevronIcon: SizedBox(
                        height: height / 26,
                        width: height / 26,
                        child: const Icon(
                          Icons.chevron_left,
                          color: TasksColor.textgray,
                        ),
                      ),
                      rightChevronIcon: SizedBox(
                          height: height / 26,
                          width: height / 26,
                          child: const Icon(Icons.chevron_right,
                            color:TasksColor.textgray,)),
                      formatButtonVisible: false,
                      decoration: const BoxDecoration(
                        color: TasksColor.transparent,
                      ),
                      titleCentered: true,
                      titleTextStyle: hsBold.copyWith(
                        fontSize: 16,
                        color: TasksColor.black,
                      )),
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {

                      _selectedDay = selectedDay;
                      /*  String convertdate = FormatedDate(_selectedDay.toString());
                      selectdate = convertdate;*/
                      // Navigator.pop(context);
                    });
                  },
                ),
                SizedBox(height: height/36,),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        splashColor: TasksColor.transparent,
                        highlightColor: TasksColor.transparent,
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: height/20,
                          width: width/4,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: TasksColor.appcolor)
                          ),
                          child: Center(child: Text("Cancel".tr,style: hsRegular.copyWith(fontSize: 14,color: TasksColor.appcolor),)),
                        ),
                      ),
                      SizedBox(width: width/36,),
                      Container(
                        height: height/20,
                        width: width/4,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: TasksColor.appcolor
                        ),
                        child: Center(child: Text("Save".tr,style: hsRegular.copyWith(fontSize: 14,color: TasksColor.white),)),
                      )
                    ],
                  ),
                ),
                SizedBox(height: height/56,),
              ],
            )
          ],
        ),
        context: context);
  }

  Future<bool> newtag() async {
    return await showDialog(
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width/56,vertical: height/96),
              child: Column(
                children: [
                  Text("New_Tag".tr,style: hsSemiBold.copyWith(fontSize: 22)),
                  SizedBox(height: height/36,),
                  SizedBox(
                    height: height/14,
                    child: TextFormField(
                        cursorColor: TasksColor.black,
                        style: hsMedium.copyWith(fontSize: 16,color: TasksColor.black),
                        decoration: InputDecoration(
                          hintText: 'Add tag'.tr,
                          filled: true,
                          fillColor: TasksColor.bggray,
                          hintStyle: hsMedium.copyWith(fontSize: 16,color: TasksColor.textgray),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none),
                        )),
                  ),
                  SizedBox(height: height/36,),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          splashColor: TasksColor.transparent,
                          highlightColor: TasksColor.transparent,
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: height/20,
                            width: width/4,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(color: TasksColor.appcolor)
                            ),
                            child: Center(child: Text("Cancel".tr,style: hsRegular.copyWith(fontSize: 14,color: TasksColor.appcolor),)),
                          ),
                        ),
                        SizedBox(width: width/36,),
                        Container(
                          height: height/20,
                          width: width/4,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: TasksColor.appcolor
                          ),
                          child: Center(child: Text("Save".tr,style: hsRegular.copyWith(fontSize: 14,color: TasksColor.white),)),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: height/56,),
                ],
              ),
            )
          ],
        ),
        context: context);
  }

  Future<bool> edittime() async {
    return await showDialog(
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width/56,vertical: height/96),
              child: Column(
                children: [
                  Text("Edit_Time".tr,style: hsSemiBold.copyWith(fontSize: 22)),
                  SizedBox(height: height/36,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width/36),
                    child: SizedBox(
                      height: height/5,
                      child: ListView.builder(
                        itemCount: hour.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding:  EdgeInsets.only(bottom: height/200),
                            child: InkWell(
                              splashColor: TasksColor.transparent,
                              highlightColor: TasksColor.transparent,
                              onTap: () {
                                setState(() {
                                  selecttime = index;
                                });
                              },
                              child: Row(
                                children: [
                                  Text(hour[index],style: selecttime == index?hsMedium.copyWith(fontSize: 26,color: TasksColor.appcolor):hsMedium.copyWith(fontSize: 22,color: TasksColor.textgray),),
                                  SizedBox(width: width/36,),
                                  Text("h".tr,style: hsSemiBold.copyWith(fontSize: 22,color:selecttime == index ? TasksColor.appcolor:TasksColor.transparent)),
                                  const Spacer(),
                                  Text(min[index],style: selecttime == index?hsMedium.copyWith(fontSize: 26,color: TasksColor.appcolor):hsMedium.copyWith(fontSize: 22,color: TasksColor.textgray),),
                                  SizedBox(width: width/36,),
                                  Text("m".tr,style: hsSemiBold.copyWith(fontSize: 22,color:selecttime == index ? TasksColor.appcolor:TasksColor.transparent)),
                                ],
                              ),
                            ),
                          );
                        },),
                    ),
                  ),
                  SizedBox(height: height/96,),
                  const Divider(),
                  SizedBox(height: height/96,),
                  Row(
                    children: [
                      Text("Reminder_Mode".tr,style: hsMedium.copyWith(fontSize: 16)),
                      const Spacer(),
                      Text("Ring".tr,style: hsMedium.copyWith(fontSize: 14)),
                      SizedBox(width: width/36,),
                      const Icon(Icons.arrow_forward_ios,size: 14,),
                    ],
                  ),
                  SizedBox(height: height/96,),
                  const Divider(),
                  SizedBox(height: height/66,),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          splashColor: TasksColor.transparent,
                          highlightColor: TasksColor.transparent,
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: height/20,
                            width: width/4,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(color: TasksColor.appcolor)
                            ),
                            child: Center(child: Text("Cancel".tr,style: hsRegular.copyWith(fontSize: 14,color: TasksColor.appcolor),)),
                          ),
                        ),
                        SizedBox(width: width/36,),
                        Container(
                          height: height/20,
                          width: width/4,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: TasksColor.appcolor
                          ),
                          child: Center(child: Text("Save".tr,style: hsRegular.copyWith(fontSize: 14,color: TasksColor.white),)),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: height/56,),
                ],
              ),
            )
          ],
        ),
        context: context);
  }

}
