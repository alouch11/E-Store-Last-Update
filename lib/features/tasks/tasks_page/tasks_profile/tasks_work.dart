import 'package:flutter_spareparts_store/features/tasks/taks_gloabelclass/tasks_color.dart';
import 'package:flutter_spareparts_store/features/tasks/taks_gloabelclass/tasks_fontstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/utill/images.dart';
import 'package:get/get.dart';
import '../tasks_task/tasks_taskdetail.dart';
import 'tasks_addpersonal.dart';

class TasksWork extends StatefulWidget {
  const TasksWork({Key? key}) : super(key: key);

  @override
  State<TasksWork> createState() => _TasksWorkState();
}

class _TasksWorkState extends State<TasksWork> {
  dynamic size;
  double height = 0.00;
  double width = 0.00;
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
        title:  Text("Work".tr,style: hsSemiBold.copyWith(fontSize: 18),),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width/36,vertical: height/36),
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: width/1.35,
                    child: TextFormField(
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
                                  color: TasksColor.textgray
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
                  ),
                  const Spacer(),
                  InkWell(
                    splashColor: TasksColor.transparent,
                    highlightColor: TasksColor.transparent,
                    onTap: () {
                      // filter();
                    },
                    child: Container(
                        height: height/13,
                        width: height/13,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: TasksColor.bggray,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(13),
                          child: Image.asset(Images.filter,height: height/36,),
                        )
                    ),
                  ),
                ],
              ),
              SizedBox(height: height/36,),
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
                          color: TasksColor.bgsky
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
                                        color: const Color(0x2637C5FF),
                                        borderRadius: BorderRadius.circular(5)
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: width/36,vertical: height/120),
                                      child: Text("Urgent",style: hsMedium.copyWith(fontSize: 10,color: TasksColor.textblue),),
                                    )),
                                SizedBox(width: width/36,),
                                Container(
                                    decoration: BoxDecoration(
                                        color: const Color(0x2637C5FF),
                                        borderRadius: BorderRadius.circular(5)
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: width/36,vertical: height/120),
                                      child: Text("Home",style: hsMedium.copyWith(fontSize: 10,color: TasksColor.textblue),),
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: TasksColor.appcolor,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return TasksAddPersonal("work");
          },));
        },
        child: const Icon(Icons.add,size: 22,color: TasksColor.white,),
      ),
    );
  }
}
