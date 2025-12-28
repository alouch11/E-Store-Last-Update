import 'package:flutter_spareparts_store/features/tasks/taks_gloabelclass/tasks_color.dart';
import 'package:flutter_spareparts_store/features/tasks/taks_gloabelclass/tasks_fontstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/utill/images.dart';
import 'package:get/get.dart';
import '../../tasks_theme/tasks_themecontroller.dart';

class TasksGraphic extends StatefulWidget {
  const TasksGraphic({Key? key}) : super(key: key);

  @override
  State<TasksGraphic> createState() => _TasksGraphicState();
}

class _TasksGraphicState extends State<TasksGraphic> {
  dynamic size;
  double height = 0.00;
  double width = 0.00;
  int isselected = 0;
  final themedata = Get.put(TasksThemecontroler());

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title:Text("Graphic".tr,style: hsSemiBold.copyWith(fontSize: 18),) ,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width/36,vertical: height/36),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: width/1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: TasksColor.bggray
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width/36,vertical: height/66),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text("Priority".tr,style: hsSemiBold.copyWith(fontSize: 18,color: TasksColor.black),),
                          const Spacer(),
                          const CircleAvatar(
                            radius: 5,
                            backgroundColor: TasksColor.lightred,
                          ),
                          SizedBox(width: width/56,),
                          Text("Personal".tr,style: hsRegular.copyWith(fontSize: 12,color: TasksColor.black),),
                          SizedBox(width: width/26,),
                          const CircleAvatar(
                            radius: 5,
                            backgroundColor: TasksColor.purple,
                          ),
                          SizedBox(width: width/56,),
                          Text("Personal".tr,style: hsRegular.copyWith(fontSize: 12,color: TasksColor.black),),
                          SizedBox(width: width/26,),
                          const CircleAvatar(
                            radius: 5,
                            backgroundColor: TasksColor.textblue,
                          ),
                          SizedBox(width: width/56,),
                          Text("Personal".tr,style: hsRegular.copyWith(fontSize: 12,color: TasksColor.black),),
                        ],
                      ),
                      SizedBox(height: height/96,),
                      Text("Task Perday".tr,style: hsSemiBold.copyWith(fontSize: 14,color: TasksColor.textgray),),
                      SizedBox(height: height/36,),
                      Image.asset(Images.graphic,width: width/1,fit: BoxFit.fitWidth,),
                    ],
                  ),
                ),
              ),
              SizedBox(height: height/36,),
              Text("Your_Activity".tr,style: hsSemiBold.copyWith(fontSize: 18),),
              SizedBox(height: height/36,),
              Container(
                width: width/1,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: TasksColor.bggray
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width/26,vertical: height/56),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: width/26),
                        child: Image.asset(Images.graph2,width: width/1,fit: BoxFit.fitWidth,),
                      ),
                    ],
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
