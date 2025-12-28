import 'package:flutter_spareparts_store/basewidget/custom_image.dart';
import 'package:flutter_spareparts_store/features/auth/controllers/auth_controller.dart';
import 'package:flutter_spareparts_store/features/profile/provider/profile_provider.dart';
import 'package:flutter_spareparts_store/features/splash/provider/splash_provider.dart';
import 'package:flutter_spareparts_store/features/tasks/taks_gloabelclass/tasks_color.dart';
import 'package:flutter_spareparts_store/features/tasks/taks_gloabelclass/tasks_fontstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/utill/images.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../tasks_theme/tasks_themecontroller.dart';
import 'tasks_event.dart';
import 'tasks_meeting.dart';
import 'tasks_personal.dart';
import 'tasks_private.dart';
import 'tasks_work.dart';

class TasksProfile extends StatefulWidget {
  const TasksProfile({Key? key}) : super(key: key);

  @override
  State<TasksProfile> createState() => _TasksProfileState();
}

class _TasksProfileState extends State<TasksProfile> {
  dynamic size;
  double height = 0.00;
  double width = 0.00;
  int isselected = 0;
  final themedata = Get.put(TasksThemecontroler());
  List type = ["Personal","Private","Secret"];

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
              SizedBox(height: height/50,),
              Container(width: 70,height: 70,  decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                border: Border.all(color: Colors.white, width: 3),
                shape: BoxShape.circle,),
                child: Provider.of<AuthController>(context, listen: false).isLoggedIn()?
                CustomImage(image: '${Provider.of<SplashProvider>(context,listen: false).baseUrls!.customerImageUrl}/'
                    '${Provider.of<ProfileProvider>(context, listen: false).userInfoModel?.image}', width: 70,height: 70,fit: BoxFit.cover,placeholder: Images.guestProfile):
                Image.asset(Images.guestProfile),),

              Text(
              '${Provider.of<ProfileProvider>(context, listen: false).userInfoModel?.fName??''} ${Provider.of<ProfileProvider>(context, listen: false).userInfoModel?.lName??''}' ,
                style: hsSemiBold.copyWith(fontSize: 26),),
              SizedBox(height: height/36,),
              Row(
                children: [
                  InkWell(
                    splashColor: TasksColor.transparent,
                    highlightColor: TasksColor.transparent,
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return const TasksPersonal();
                      },));
                    },
                    child: Container(
                      height: height/4.9,
                      width: width/2.2,
                      decoration: BoxDecoration(
                          color: TasksColor.bgpurple,
                          borderRadius: BorderRadius.circular(14)
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: width/36,vertical: height/36),
                        child: Column(
                          children: [
                            Container(
                                height: height/15,
                                width: height/15,
                                decoration: BoxDecoration(
                                    color: TasksColor.purple,
                                    borderRadius: BorderRadius.circular(14)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Image.asset(Images.profile,height: height/36,fit: BoxFit.fitHeight,),
                                )
                            ),
                            SizedBox(height: height/56,),
                            Text("Personal".tr,style: hsMedium.copyWith(fontSize: 14,color: TasksColor.black),),
                            Text("6 Task",style: hsMedium.copyWith(fontSize: 14,color: TasksColor.black),),

                          ],
                        ),
                      ) ,
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    splashColor: TasksColor.transparent,
                    highlightColor: TasksColor.transparent,
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return const TasksWork();
                      },));
                    },
                    child: Container(
                      height: height/4.9,
                      width: width/2.2,
                      decoration: BoxDecoration(
                          color: TasksColor.bgsky,
                          borderRadius: BorderRadius.circular(14)
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: width/36,vertical: height/36),
                        child: Column(
                          children: [
                            Container(
                                height: height/15,
                                width: height/15,
                                decoration: BoxDecoration(
                                    color: TasksColor.lightblue,
                                    borderRadius: BorderRadius.circular(14)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Image.asset(Images.work,height: height/36,fit: BoxFit.fitHeight,),
                                )
                            ),
                            SizedBox(height: height/56,),
                            Text("Work".tr,style: hsMedium.copyWith(fontSize: 14,color: TasksColor.black),),
                            Text("8 Task",style: hsMedium.copyWith(fontSize: 14,color: TasksColor.black),),

                          ],
                        ),
                      ) ,
                    ),
                  ),
                ],
              ),
              SizedBox(height: height/36,),
              Row(
                children: [
                  InkWell(
                    splashColor: TasksColor.transparent,
                    highlightColor: TasksColor.transparent,
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return const TasksPrivate();
                      },));
                    },
                    child: Container(
                      height: height/4.9,
                      width: width/2.2,
                      decoration: BoxDecoration(
                          color: TasksColor.bgred,
                          borderRadius: BorderRadius.circular(14)
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: width/36,vertical: height/36),
                        child: Column(
                          children: [
                            Container(
                                height: height/15,
                                width: height/15,
                                decoration: BoxDecoration(
                                    color: TasksColor.lightred,
                                    borderRadius: BorderRadius.circular(14)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Image.asset(Images.lock,height: height/36,fit: BoxFit.fitHeight,),
                                )
                            ),
                            SizedBox(height: height/56,),
                            Text("Private".tr,style: hsMedium.copyWith(fontSize: 14,color: TasksColor.black),),
                            Text("3 Task",style: hsMedium.copyWith(fontSize: 14,color: TasksColor.black),),
                          ],
                        ),
                      ) ,
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    splashColor: TasksColor.transparent,
                    highlightColor: TasksColor.transparent,
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return const TasksMeeting();
                      },));
                    },
                    child: Container(
                      height: height/4.9,
                      width: width/2.2,
                      decoration: BoxDecoration(
                          //color: TasksColor.bggreen,
                          color: TasksColor.lightgreenbg,
                          borderRadius: BorderRadius.circular(14)
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: width/36,vertical: height/36),
                        child: Column(
                          children: [
                            Container(
                                height: height/15,
                                width: height/15,
                                decoration: BoxDecoration(
                                    color: TasksColor.lightgreen,
                                    borderRadius: BorderRadius.circular(14)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Image.asset(Images.users,height: height/36,fit: BoxFit.fitHeight,),
                                )
                            ),
                            SizedBox(height: height/56,),
                            Text("Meeting".tr,style: hsMedium.copyWith(fontSize: 14,color: TasksColor.black),),
                            Text("4 Task",style: hsMedium.copyWith(fontSize: 14,color: TasksColor.black),),

                          ],
                        ),
                      ) ,
                    ),
                  ),
                ],
              ),
              SizedBox(height: height/36,),
              Row(
                children: [
                  InkWell(
                    splashColor: TasksColor.transparent,
                    highlightColor: TasksColor.transparent,
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return const TasksEvent();
                      },));
                    },
                    child: Container(
                      height: height/4.9,
                      width: width/2.2,
                      decoration: BoxDecoration(
                          color: TasksColor.bgpurple,
                          borderRadius: BorderRadius.circular(14)
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: width/36,vertical: height/36),
                        child: Column(
                          children: [
                            Container(
                                height: height/15,
                                width: height/15,
                                decoration: BoxDecoration(
                                    color: TasksColor.purple,
                                    borderRadius: BorderRadius.circular(14)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Image.asset(Images.calendar,height: height/36,fit: BoxFit.fitHeight,color: TasksColor.white),
                                )
                            ),
                            SizedBox(height: height/56,),
                            Text("Events".tr,style: hsMedium.copyWith(fontSize: 14,color: TasksColor.black),),
                            Text("4 Task",style: hsMedium.copyWith(fontSize: 14,color: TasksColor.black),),
                          ],
                        ),
                      ) ,
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    splashColor: TasksColor.transparent,
                    highlightColor: TasksColor.transparent,
                    onTap: () {
                      createBoard();
                    },
                    child: Container(
                      height: height/4.9,
                      width: width/2.2,
                      decoration: BoxDecoration(
                          color: TasksColor.redbglight,
                          borderRadius: BorderRadius.circular(14)
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: width/36,vertical: height/36),
                        child: Column(
                          children: [
                            Container(
                                height: height/15,
                                width: height/15,
                                decoration: BoxDecoration(
                                    color: const Color(0xffF0A58E),
                                    borderRadius: BorderRadius.circular(14)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Image.asset(Images.plus,height: height/36,fit: BoxFit.fitHeight,),
                                )
                            ),
                            SizedBox(height: height/56,),
                            Text("Create_Board".tr,style: hsMedium.copyWith(fontSize: 14,color: TasksColor.black),),
                            Text("6 Task",style: hsMedium.copyWith(fontSize: 14,color: TasksColor.black),),

                          ],
                        ),
                      ) ,
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }

  Future<bool> logout() async {
    return await showDialog(
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width/56,vertical: height/96),
              child: Column(
                children: [
                  Text("Log_Out".tr,style: hsSemiBold.copyWith(fontSize: 22)),
                  SizedBox(height: height/56,),
                  Text("Are_you_sure_to_log_out_fromthis_account".tr,textAlign: TextAlign.center,maxLines: 2,overflow: TextOverflow.ellipsis,style: hsRegular.copyWith(fontSize: 16)),
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
                          child: Center(child: Text("Sure".tr,style: hsRegular.copyWith(fontSize: 14,color: TasksColor.white),)),
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

  Future<bool> createBoard() async {
    return await showDialog(
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width/56,vertical: height/96),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Create_Board".tr,style: hsSemiBold.copyWith(fontSize: 22)),
                  SizedBox(height: height/56,),
                  Text("Board_Name".tr,style: hsMedium.copyWith(fontSize: 14)),
                  SizedBox(height: height/96,),
                  SizedBox(
                    height: height/14,
                    child: TextFormField(
                        cursorColor: TasksColor.black,
                        style: hsMedium.copyWith(fontSize: 16,color: TasksColor.black),
                        decoration: InputDecoration(
                          hintText: 'Board_Name'.tr,
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
                  SizedBox(height: height/46,),
                  Text("Type".tr,style: hsMedium.copyWith(fontSize: 14),),
                  SizedBox(height: height/96,),
                  SizedBox(
                    height: height/30,
                    child: ListView.builder(
                      itemCount: type.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(right: width/26),
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
                                Icon(isselected == index?Icons.check_box_sharp:Icons.check_box_outline_blank,size: 18,color: isselected == index?TasksColor.appcolor:TasksColor.textgray,),
                                SizedBox(width: width/36,),
                                Text(type[index],style: hsRegular.copyWith(fontSize: 14,),),
                              ],
                            ),
                          ),
                        );
                      },),
                  ),
                  SizedBox(height: height/30,),
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
                          child: Center(child: Text("Create".tr,style: hsRegular.copyWith(fontSize: 14,color: TasksColor.white),)),
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
