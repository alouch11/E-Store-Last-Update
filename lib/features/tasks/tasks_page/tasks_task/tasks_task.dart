import 'package:flutter_spareparts_store/features/tasks/taks_gloabelclass/tasks_color.dart';
import 'package:flutter_spareparts_store/features/tasks/taks_gloabelclass/tasks_fontstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/utill/images.dart';
import 'package:get/get.dart';
import '../../tasks_theme/tasks_themecontroller.dart';
import 'tasks_addtask.dart';

class TasksTask extends StatefulWidget {
  const TasksTask({super.key});

  @override
  State<TasksTask> createState() => _TasksTaskState();
}

class _TasksTaskState extends State<TasksTask> {
  dynamic size;
  double height = 0.00;
  double width = 0.00;
  int isselected = 0;
  final themedata = Get.put(TasksThemecontroler());

  List name = ["Cleaning Clothes","Cleaning Clothes","Cleaning Clothes"];

  List day = ["MO","TU","WE","TH","FR","SA","SU","MO","TU","WE"];
  List date = ["12","13","14","15","16","17","18","19","20","21"];

  DateTime selectedDate = DateTime.now();
  ScrollController scrollController = ScrollController();

  List<String> listOfDays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]; //List of Days


  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width/36,vertical: height/36),
          child: Column(
            children: [
              SizedBox(height: height/36,),
              TextFormField(
                  cursorColor: TasksColor.black,
                  style: hsMedium.copyWith(fontSize: 16,color: TasksColor.textgray),
                  decoration: InputDecoration(
                    hintText: 'Search for task'.tr,
                    filled: true,
                    fillColor: TasksColor.bggray,
                    prefixIcon: const Icon(
                      Icons.search,
                      size: 22,
                      color: TasksColor.grey,
                    ),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Container(
                        height: height/96,
                        width: height/96,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: TasksColor.purple
                        ),
                        child: const Icon(
                          Icons.close,
                          size: 12,
                          color: TasksColor.white,
                        ),
                      ),
                    ),
                    hintStyle: hsMedium.copyWith(fontSize: 16,color: TasksColor.textgray),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none),
                  )),
              SizedBox(height: height/26,),
              Row(
                children: [
                  Text("Task".tr,style: hsSemiBold.copyWith(fontSize: 24),),
                  const Spacer(),
                  Image.asset(Images.calendar,height: height/46,),
                  SizedBox(width: width/36,),
                  Text("August 2021",style: hsRegular.copyWith(fontSize: 12),),
                ],
              ),
              SizedBox(height: height/36,),
              SizedBox(
                height: height/8.8,
                child: ListView.builder(
                  itemCount: 31,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        isselected = index;
                        selectedDate =
                            DateTime.now().add(Duration(days: index));
                      });
                    },
                    child: Container(
                      width: width/7,
                      margin: EdgeInsets.only(bottom: width/30),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: isselected == index?TasksColor.appcolor:TasksColor.transparent
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: height/96),
                        child: Column(
                          children: [
                            Text( listOfDays[DateTime.now()
                            .add(Duration(days: index))
                            .weekday -
                            1]
                          .toString(),style: hsMedium.copyWith(fontSize: 16,color: isselected == index?TasksColor.white:themedata.isdark?TasksColor.white:TasksColor.black),),
                            SizedBox(height: height/96,),
                            Text(DateTime.now()
                                .add(Duration(days: index))
                                .day
                                .toString(),style: hsRegular.copyWith(fontSize: 14,color: isselected == index?TasksColor.white:themedata.isdark?TasksColor.white:TasksColor.black),),
                          ],
                        ),
                      ),
                    ),
                  );
                },),
              ),
              SizedBox(height: height/36,),
              Row(
                children: [
                  Text("Today".tr,style: hsSemiBold.copyWith(fontSize: 24),),
                  const Spacer(),
                  Text("09 h 45 min",style: hsRegular.copyWith(fontSize: 12),),
                ],
              ),
              SizedBox(height: height/96,),
              if(name.isEmpty)...[
                Image.asset(Images.emptytask,height: height/4,fit: BoxFit.fitHeight,),
                SizedBox(height: height/26,),
                Text("You don’t have any schedule today.\nTap the plus button to create new to-do.",textAlign: TextAlign.center,style: hsRegular.copyWith(fontSize: 14,),),
              ]else...[
                const Divider(color: TasksColor.textgray,),
                SizedBox(height: height/96,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: height/46),
                      child: Text("07:00",style: hsMedium.copyWith(fontSize: 14),),
                    ),
                    const Spacer(),
                    SizedBox(
                      height: height/5.7,
                      width: width/1.25,
                      child: ListView.builder(
                        itemCount: name.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Container(
                            width: width/1.8,
                            margin: EdgeInsets.only(right: width/36),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                color: TasksColor.bggray
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: width/36,vertical: height/66),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(name[index],style: hsMedium.copyWith(fontSize: 16,color: TasksColor.black),),
                                      const Spacer(),
                                      SizedBox(
                                        height: height/22,
                                        width: height/26,
                                        child: PopupMenuButton<int>(itemBuilder: (context) =>[
                                          PopupMenuItem(
                                            value: 1,
                                            child: Row(
                                              children: [
                                                Image.asset(Images.closeSquare,height: height/36,color: TasksColor.black,),
                                                SizedBox(width: width/36,),
                                                Text("Disable",style: hsRegular.copyWith(fontSize: 16,color: TasksColor.black),),
                                              ],
                                            ),
                                          ),
                                          PopupMenuItem(
                                            value: 2,
                                            child: Row(
                                              children: [
                                                Image.asset(Images.editSquare,height: height/36,),
                                                SizedBox(width: width/36,),
                                                Text("Edit",style: hsRegular.copyWith(fontSize: 16,color: TasksColor.black),),
                                              ],
                                            ),
                                          ),
                                          PopupMenuItem(
                                            value: 3,
                                            child: Row(
                                              children: [
                                                Image.asset(Images.delete,height: height/36,),
                                                SizedBox(width: width/36,),
                                                Text("Delete",style: hsRegular.copyWith(fontSize: 16,color: TasksColor.black),),
                                              ],
                                            ),
                                          )
                                        ],
                                          offset: const Offset(5, 50),
                                          color: TasksColor.white,
                                          constraints: BoxConstraints(
                                            maxWidth: width/2.8,
                                          ),
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                                          icon: Image.asset(Images.dot,height: height/36,fit: BoxFit.fitHeight,),
                                          elevation: 2,

                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: height/200,),
                                  Text("07:00 - 07:15",style: hsRegular.copyWith(fontSize: 14,color: TasksColor.textgray),),
                                  SizedBox(height: height/66,),
                                  Row(
                                    children: [
                                      Container(
                                          decoration: BoxDecoration(
                                              color: const Color(0x338F99EB),
                                              borderRadius: BorderRadius.circular(5)
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(horizontal: width/36,vertical: height/120),
                                            child: Text("Urgent",style: hsMedium.copyWith(fontSize: 10,color: TasksColor.appcolor),),
                                          )),
                                      SizedBox(width: width/36,),
                                      Container(
                                          decoration: BoxDecoration(
                                              color: const Color(0x338F99EB),
                                              borderRadius: BorderRadius.circular(5)
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(horizontal: width/36,vertical: height/120),
                                            child: Text("Home",style: hsMedium.copyWith(fontSize: 10,color: TasksColor.appcolor),),
                                          )),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },),
                    )
                  ],
                ),
                SizedBox(height: height/80,),
                const Divider(color: TasksColor.textgray,),
                SizedBox(height: height/96,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: height/46),
                      child: Text("08:00",style: hsMedium.copyWith(fontSize: 14),),
                    ),
                    const Spacer(),
                    SizedBox(
                      height: height/5.7,
                      width: width/1.25,
                      child: ListView.builder(
                        itemCount: 3,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Container(
                            width: width/1.8,
                            margin: EdgeInsets.only(right: width/36),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                color: TasksColor.bggray
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: width/36,vertical: height/66),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text("Cleaning Clothes",style: hsMedium.copyWith(fontSize: 16,color: TasksColor.black),),
                                      const Spacer(),
                                      SizedBox(
                                        height: height/22,
                                        width: height/26,
                                        child: PopupMenuButton<int>(itemBuilder: (context) =>[
                                          PopupMenuItem(
                                            value: 1,
                                            child: Row(
                                              children: [
                                                Image.asset(Images.closeSquare,height: height/36,color: TasksColor.black,),
                                                SizedBox(width: width/36,),
                                                Text("Disable",style: hsRegular.copyWith(fontSize: 16,color: TasksColor.black),),
                                              ],
                                            ),
                                          ),
                                          PopupMenuItem(
                                            value: 2,
                                            child: Row(
                                              children: [
                                                Image.asset(Images.editSquare,height: height/36,),
                                                SizedBox(width: width/36,),
                                                Text("Edit",style: hsRegular.copyWith(fontSize: 16,color: TasksColor.black),),
                                              ],
                                            ),
                                          ),
                                          PopupMenuItem(
                                            value: 3,
                                            child: Row(
                                              children: [
                                                Image.asset(Images.delete,height: height/36,),
                                                SizedBox(width: width/36,),
                                                Text("Delete",style: hsRegular.copyWith(fontSize: 16,color: TasksColor.black),),
                                              ],
                                            ),
                                          )
                                        ],
                                          offset: const Offset(5, 50),
                                          color: TasksColor.white,
                                          constraints: BoxConstraints(
                                            maxWidth: width/2.8,
                                          ),
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                                          icon: Image.asset(Images.dot,height: height/36,fit: BoxFit.fitHeight,),
                                          elevation: 2,

                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: height/200,),
                                  Text("07:00 - 07:15",style: hsRegular.copyWith(fontSize: 14,color: TasksColor.textgray),),
                                  SizedBox(height: height/66,),
                                  Row(
                                    children: [
                                      Container(
                                          decoration: BoxDecoration(
                                              color: const Color(0x338F99EB),
                                              borderRadius: BorderRadius.circular(5)
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(horizontal: width/36,vertical: height/120),
                                            child: Text("Urgent",style: hsMedium.copyWith(fontSize: 10,color: TasksColor.appcolor),),
                                          )),
                                      SizedBox(width: width/36,),
                                      Container(
                                          decoration: BoxDecoration(
                                              color: const Color(0x338F99EB),
                                              borderRadius: BorderRadius.circular(5)
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(horizontal: width/36,vertical: height/120),
                                            child: Text("Home",style: hsMedium.copyWith(fontSize: 10,color: TasksColor.appcolor),),
                                          )),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },),
                    )
                  ],
                ),
                SizedBox(height: height/80,),
                const Divider(color: TasksColor.textgray,),
                SizedBox(height: height/96,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("09:00",style: hsMedium.copyWith(fontSize: 14),),
                    // SizedBox(width: width/30,),
                    Text("You don’t have any schedule",style: hsRegular.copyWith(fontSize: 14,color: TasksColor.textgray),),
                    Text("or",style: hsRegular.copyWith(fontSize: 14,color: TasksColor.textgray),),
                    InkWell(
                      splashColor: TasksColor.transparent,
                      highlightColor: TasksColor.transparent,
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return const TasksAddTask();
                          },));
                        },
                        child: Text("+ Add",style: hsMedium.copyWith(fontSize: 14),)),
                    SizedBox(width: width/36,),
                  ],
                ),
                SizedBox(height: height/80,),
                const Divider(color: TasksColor.textgray,),
              ]

            ],
          ),
        ),
      ),
    );
  }
}