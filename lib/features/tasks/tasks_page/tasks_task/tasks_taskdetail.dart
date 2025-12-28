import 'package:flutter_spareparts_store/features/tasks/taks_gloabelclass/tasks_color.dart';
import 'package:flutter_spareparts_store/features/tasks/taks_gloabelclass/tasks_fontstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/utill/images.dart';
import 'package:get/get.dart';
import '../../tasks_theme/tasks_themecontroller.dart';

class TasksTaskdetail extends StatefulWidget {
  const TasksTaskdetail({Key? key}) : super(key: key);

  @override
  State<TasksTaskdetail> createState() => _TasksTaskdetailState();
}

class _TasksTaskdetailState extends State<TasksTaskdetail> {
  dynamic size;
  double height = 0.00;
  double width = 0.00;
  List isselected = [];
  final themedata = Get.put(TasksThemecontroler());
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
        title: Text("Detail".tr,style: hsSemiBold.copyWith(fontSize: 18),),
        actions: [
          Padding(
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
                  padding: const EdgeInsets.all(6),
                  child: Image.asset(Images.moreSquare,height: height/36,),
                ),
              ),
            ),
          ),
        ],
      ),   
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width/36,vertical: height/36),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Plan_for_a_month".tr,style: hsSemiBold.copyWith(fontSize: 24),),
              Text("Personal type".tr,style: hsRegular.copyWith(fontSize: 14),),
              SizedBox(height: height/36,),
              Row(
                children: [
                  Container(
                    width: width/2.2,
                    decoration: BoxDecoration(
                        color: TasksColor.lightred,
                        borderRadius: BorderRadius.circular(14)
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: width/36,vertical: height/56),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Est. Date".tr,style: hsMedium.copyWith(fontSize: 18,color:const Color(0x80FFFFFF)),),
                          Text("4 August 2021",style: hsMedium.copyWith(fontSize: 18,color: TasksColor.white),),

                        ],
                      ),
                    ) ,
                  ),
                  const Spacer(),
                  Container(
                    width: width/2.2,
                    decoration: BoxDecoration(
                        color: TasksColor.lightred,
                        borderRadius: BorderRadius.circular(14)
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: width/36,vertical: height/56),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Est. Time".tr,style: hsMedium.copyWith(fontSize: 18,color:const Color(0x80FFFFFF)),),
                          Text("07:00 - 07:30 AM",style: hsMedium.copyWith(fontSize: 18,color: TasksColor.white),),
                        ],
                      ),
                    ) ,
                  ),
                ],
              ),
              SizedBox(height: height/36,),
              Text("Task".tr,style: hsSemiBold.copyWith(fontSize: 20),),
              SizedBox(height: height/36,),
              ListView.separated(
                itemCount:4,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return InkWell(
                      splashColor: TasksColor.transparent,
                      highlightColor: TasksColor.transparent,
                      onTap: () {
                        setState(() {
                          if(isselected.contains(index)){
                            isselected.remove(index);
                          }else{
                            isselected.add(index);
                          }
                        });
                      },
                      child: Row(
                        children: [
                          Icon(isselected.contains(index)?Icons.check_box_sharp:Icons.check_box_outline_blank,size: 22,color: isselected.contains(index)?TasksColor.appcolor:TasksColor.textgray,),
                          SizedBox(width: width/36,),
                          Text("Creating this month's work plan",style: hsRegular.copyWith(fontSize: 16,),),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider(indent: 30,);
                  },
                 ),
              SizedBox(height: height/36,),
              Text("Tag".tr,style: hsSemiBold.copyWith(fontSize: 20),),
              SizedBox(height: height/46,),
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

            ],
          ),
        ),
      ),
    );
  }
}
