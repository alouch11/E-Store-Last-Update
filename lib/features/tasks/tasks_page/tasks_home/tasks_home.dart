import 'package:flutter_spareparts_store/features/auth/controllers/auth_controller.dart';
import 'package:flutter_spareparts_store/features/profile/provider/profile_provider.dart';
import 'package:flutter_spareparts_store/features/tasks/taks_gloabelclass/tasks_color.dart';
import 'package:flutter_spareparts_store/features/tasks/taks_gloabelclass/tasks_fontstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../../../utill/images.dart';
import '../tasks_task/tasks_taskdetail.dart';
import 'tasks_mytask.dart';
import 'package:flutter_spareparts_store/basewidget/custom_app_bar.dart';

class Taskshome extends StatefulWidget {
  const Taskshome({Key? key}) : super(key: key);

  @override
  State<Taskshome> createState() => _TaskshomeState();
}

class _TaskshomeState extends State<Taskshome> {

  @override
  void initState() {
    if(Provider.of<AuthController>(context, listen: false).isLoggedIn()) {
      Provider.of<ProfileProvider>(context, listen: false).getUserInfo(context);
    }
    super.initState();
  }

  dynamic size;
  double height = 0.00;
  double width = 0.00;
  @override
  Widget build(BuildContext context) {
    bool isGuestMode = !Provider.of<AuthController>(context, listen: false).isLoggedIn();
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      appBar: const CustomAppBar(title: "Tasks Management"),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width/36,vertical: height/36),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height/96,),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(!isGuestMode?
                      'Hi,${Provider.of<ProfileProvider>(context, listen: false).userInfoModel?.fName??''} ${Provider.of<ProfileProvider>(context, listen: false).userInfoModel?.lName??''}' : 'Guest',
                          style: hsSemiBold.copyWith(fontSize: 26),),
                      Text("Let’s make this day productive".tr,style: hsRegular.copyWith(fontSize: 14),),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    width: height/16,
                    height: height/16,
                    decoration:  BoxDecoration(
                      color: TasksColor.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: const [
                          BoxShadow(color: TasksColor.textgray,blurRadius: 5)
                        ]
                    ),
                    child: Image.asset(Images.avtar,height: height/36,),
                  )
                ],
              ),
              SizedBox(height: height/36,),
              Text("My Task".tr,style: hsSemiBold.copyWith(fontSize: 24),),
              SizedBox(height: height/36,),
              Row(
                children: [
                  Column(
                    children: [
                      InkWell(
                        splashColor: TasksColor.transparent,
                        highlightColor: TasksColor.transparent,
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return TasksMyTask("Completed");
                          },));
                        },
                        child: Container(
                          height: height/4.5,
                          width: width/2.2,
                          decoration: BoxDecoration(
                              color: TasksColor.lightblue,
                            borderRadius: BorderRadius.circular(14)
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: width/36,vertical: height/66),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset(Images.iMac,height: height/10,fit: BoxFit.fitHeight,),
                                    const Spacer(),
                                    const Icon(Icons.arrow_forward,color: TasksColor.black,size: 22,)
                                  ],
                                ),
                                SizedBox(height: height/66,),
                                Text("Completed".tr,style: hsMedium.copyWith(fontSize: 16,color: TasksColor.black),),
                                SizedBox(height: height/120,),
                                Text("86 Task",style: hsRegular.copyWith(fontSize: 14,color: TasksColor.black),),

                              ],
                            ),
                          ) ,
                        ),
                      ),
                      SizedBox(height: height/56,),
                      InkWell(
                        splashColor: TasksColor.transparent,
                        highlightColor: TasksColor.transparent,
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return TasksMyTask("Canceled");
                          },));
                        },
                        child: Container(
                          height: height/6,
                          width: width/2.2,
                          decoration: BoxDecoration(
                              color: TasksColor.lightred,
                              borderRadius: BorderRadius.circular(14)
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: width/36,vertical: height/66),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset(Images.closeSquare,height: height/21,fit: BoxFit.fitHeight,),
                                    const Spacer(),
                                    const Icon(Icons.arrow_forward,color: TasksColor.white,size: 22,)
                                  ],
                                ),
                                SizedBox(height: height/66,),
                                Text("Canceled".tr,style: hsMedium.copyWith(fontSize: 16,color: TasksColor.white),),
                                SizedBox(height: height/120,),
                                Text("15 Task",style: hsRegular.copyWith(fontSize: 14,color: TasksColor.white),),

                              ],
                            ),
                          ) ,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Column(
                    children: [
                      InkWell(
                        splashColor: TasksColor.transparent,
                        highlightColor: TasksColor.transparent,
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return TasksMyTask("Pending");
                          },));
                        },
                        child: Container(
                          height: height/6,
                          width: width/2.2,
                          decoration: BoxDecoration(
                              color: TasksColor.purple,
                              borderRadius: BorderRadius.circular(14)
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: width/36,vertical: height/66),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset(Images.timeSquare,height: height/21,fit: BoxFit.fitHeight,),
                                    const Spacer(),
                                    const Icon(Icons.arrow_forward,color: TasksColor.white,size: 22,)
                                  ],
                                ),
                                SizedBox(height: height/66,),
                                Text("Pending".tr,style: hsMedium.copyWith(fontSize: 16,color: TasksColor.white),),
                                SizedBox(height: height/120,),
                                Text("15 Task",style: hsRegular.copyWith(fontSize: 14,color: TasksColor.white),),

                              ],
                            ),
                          ) ,
                        ),
                      ),
                      SizedBox(height: height/56,),
                      InkWell(
                        splashColor: TasksColor.transparent,
                        highlightColor: TasksColor.transparent,
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return TasksMyTask("OnGoing");
                          },));
                        },
                        child: Container(
                          height: height/4.5,
                          width: width/2.2,
                          decoration: BoxDecoration(
                              color: TasksColor.lightgreen,
                              borderRadius: BorderRadius.circular(14)
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: width/36,vertical: height/66),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset(Images.iMac,height: height/10,fit: BoxFit.fitHeight,),
                                    const Spacer(),
                                    const Icon(Icons.arrow_forward,color: TasksColor.black,size: 22,)
                                  ],
                                ),
                                SizedBox(height: height/66,),
                                Text("On_Going".tr,style: hsMedium.copyWith(fontSize: 16,color: TasksColor.black),),
                                SizedBox(height: height/120,),
                                Text("67 Task",style: hsRegular.copyWith(fontSize: 14,color: TasksColor.black),),

                              ],
                            ),
                          ) ,
                        ),
                      ),

                    ],
                  )
                ],
              ),
              SizedBox(height: height/26,),
              Row(
                children: [
                  Text("Today_Task".tr,style: hsSemiBold.copyWith(fontSize: 24),),
                  const Spacer(),
                  Text("View_all".tr,style: hsRegular.copyWith(fontSize: 12,color: TasksColor.appcolor),),
                ],
              ),
              ListView.builder(
                itemCount: 3,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                return InkWell(
                  splashColor: TasksColor.transparent,
                  highlightColor: TasksColor.transparent,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return const TasksTaskdetail();
                    },));
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: height/46),
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
                              Image.asset(Images.dot,height: height/36,)
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
                  ),
                );
              },)

            ],
          ),
        ),
      ),
    );
  }
}
