import 'package:flutter_spareparts_store/features/tasks/taks_gloabelclass/tasks_color.dart';
import 'package:flutter_spareparts_store/features/tasks/taks_gloabelclass/tasks_fontstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/utill/images.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

// ignore: must_be_immutable
class TasksMyTask extends StatefulWidget {
  String? type;
  TasksMyTask(this.type, {super.key});

  @override
  State<TasksMyTask> createState() => _TasksMyTaskState();
}

class _TasksMyTaskState extends State<TasksMyTask> {
  dynamic size;
  double height = 0.00;
  double width = 0.00;
  DateTime? _selectedDay;
  String? selectdate;

  List tag = ["Office","Home","Urgent","Work"];
  List type = ["Private","Personal","Secret"];
  List shot = ["Newest","Farthest"];
  List typecolor = [
    TasksColor.purple,
    TasksColor.lightred,
    TasksColor.lightblue,
  ];

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
        title:  Text(widget.type == "Completed"
            ? "Completed Task".tr
            : widget.type == "Canceled"
            ? "Canceled".tr
            : widget.type == "Pending"
            ? "Pending".tr
            : "On_Going".tr,style: hsSemiBold.copyWith(fontSize: 18),),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width/36,vertical: height/36),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                      filter();
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
              Row(
                children: [
                  InkWell(
                    splashColor: TasksColor.transparent,
                    highlightColor: TasksColor.transparent,
                      onTap: () {
                        calendar();
                      },
                      child: Image.asset(Images.calendar,height: height/36,)),
                  SizedBox(width: width/30,),
                  Text("May 2021",style: hsMedium.copyWith(fontSize: 20),),
                ],
              ),
              SizedBox(height: height/36,),
              Text("14 May 2021",style: hsRegular.copyWith(fontSize: 14),),
              SizedBox(height: height/46,),
              SizedBox(
                height: height/5.7,
                child: ListView.builder(
                  itemCount: 3,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Container(
                      width: width/1.8,
                      margin: EdgeInsets.only(right: width/36),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: widget.type == "Completed"
                              ? TasksColor.bgsky
                              : widget.type == "Canceled"
                              ?  TasksColor.bgred
                              : widget.type == "Pending"
                              ?  TasksColor.bgpurple
                              :  TasksColor.bggreen
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: width/36,vertical: height/80),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text("Cleaning Clothes",style: hsMedium.copyWith(fontSize: 16,color: TasksColor.black),),
                                const Spacer(),
                                if(widget.type == "Completed")...[
                                  SizedBox(
                                    height: height/22,
                                    width: height/26,
                                    child: PopupMenuButton<int>(itemBuilder: (context) =>[
                                      PopupMenuItem(
                                        value: 1,
                                        child: Row(
                                          children: [
                                            Image.asset(Images.upload,height: height/36,),
                                            SizedBox(width: width/36,),
                                            Text("Restore",style: hsRegular.copyWith(fontSize: 16,color: TasksColor.black),),
                                          ],
                                        ),
                                      ),
                                      PopupMenuItem(
                                        value: 2,
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
                                ]else if(widget.type == "Canceled")...[
                                  SizedBox(
                                    height: height/22,
                                    width: height/26,
                                    child: PopupMenuButton<int>(itemBuilder: (context) =>[
                                      PopupMenuItem(
                                        value: 1,
                                        child: Row(
                                          children: [
                                            Image.asset(Images.editSquare,height: height/36,),
                                            SizedBox(width: width/36,),
                                            Text("Edit",style: hsRegular.copyWith(fontSize: 16,color: TasksColor.black),),
                                          ],
                                        ),
                                      ),
                                      PopupMenuItem(
                                        value: 2,
                                        child: Row(
                                          children: [
                                            Image.asset(Images.upload,height: height/36,),
                                            SizedBox(width: width/36,),
                                            Text("Restore",style: hsRegular.copyWith(fontSize: 16,color: TasksColor.black),),
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
                                ]else if(widget.type == "Pending")...[
                                  SizedBox(
                                    height: height/22,
                                    width: height/26,
                                    child: PopupMenuButton<int>(itemBuilder: (context) =>[
                                      PopupMenuItem(
                                        value: 1,
                                        child: Row(
                                          children: [
                                            Image.asset(Images.tickSquare,height: height/36,),
                                            SizedBox(width: width/36,),
                                            Text("Enable",style: hsRegular.copyWith(fontSize: 16,color: TasksColor.black),),
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
                                ]else...[
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
                                ]
                              ],
                            ),
                            Text("07:00 - 07:15",style: hsRegular.copyWith(fontSize: 14,color: TasksColor.textappcolor),),
                            SizedBox(height: height/46,),
                            Row(
                              children: [
                                Container(
                                    decoration: BoxDecoration(
                                        color: const Color(0xffFFE9ED),
                                        borderRadius: BorderRadius.circular(5)
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: width/36,vertical: height/120),
                                      child: Text("Urgent",style: hsMedium.copyWith(fontSize: 10,color: TasksColor.lightred),),
                                    )),
                                SizedBox(width: width/36,),
                                Container(
                                    decoration: BoxDecoration(
                                        color:  widget.type == "Completed"
                                            ? TasksColor.sky
                                            : widget.type == "Canceled"
                                            ?  TasksColor.lightorange
                                            : widget.type == "Pending"
                                            ?  TasksColor.lightpurple
                                            :  TasksColor.parrot,
                                        borderRadius: BorderRadius.circular(5)
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: width/36,vertical: height/120),
                                      child: Text("Home",style: hsMedium.copyWith(fontSize: 10,
                                        color: widget.type == "Completed"
                                            ? TasksColor.textblue
                                            : widget.type == "Canceled"
                                            ?  TasksColor.lightred
                                            : widget.type == "Pending"
                                            ?  TasksColor.purple
                                            :  TasksColor.lightgreen,),),
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },),
              ),
              SizedBox(height: height/36,),
              Text("15 May 2021",style: hsRegular.copyWith(fontSize: 14),),
              SizedBox(height: height/46,),
              SizedBox(
                height: height/5.7,
                child: ListView.builder(
                  itemCount: 3,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Container(
                      width: width/1.8,
                      margin: EdgeInsets.only(right: width/36),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: widget.type == "Completed"
                              ? TasksColor.bgsky
                              : widget.type == "Canceled"
                              ?  TasksColor.bgred
                              : widget.type == "Pending"
                              ?  TasksColor.bgpurple
                              :  TasksColor.bggreen
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: width/36,vertical: height/80),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text("Cleaning Clothes",style: hsMedium.copyWith(fontSize: 16,color: TasksColor.black),),
                                const Spacer(),
                                if(widget.type == "Completed")...[
                                  SizedBox(
                                    height: height/22,
                                    width: height/26,
                                    child: PopupMenuButton<int>(itemBuilder: (context) =>[
                                      PopupMenuItem(
                                        value: 1,
                                        child: Row(
                                          children: [
                                            Image.asset(Images.upload,height: height/36,),
                                            SizedBox(width: width/36,),
                                            Text("Restore",style: hsRegular.copyWith(fontSize: 16,color: TasksColor.black),),
                                          ],
                                        ),
                                      ),
                                      PopupMenuItem(
                                        value: 2,
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
                                ]else if(widget.type == "Canceled")...[
                                  SizedBox(
                                    height: height/22,
                                    width: height/26,
                                    child: PopupMenuButton<int>(itemBuilder: (context) =>[
                                      PopupMenuItem(
                                        value: 1,
                                        child: Row(
                                          children: [
                                            Image.asset(Images.editSquare,height: height/36,),
                                            SizedBox(width: width/36,),
                                            Text("Edit",style: hsRegular.copyWith(fontSize: 16,color: TasksColor.black),),
                                          ],
                                        ),
                                      ),
                                      PopupMenuItem(
                                        value: 2,
                                        child: Row(
                                          children: [
                                            Image.asset(Images.upload,height: height/36,),
                                            SizedBox(width: width/36,),
                                            Text("Restore",style: hsRegular.copyWith(fontSize: 16,color: TasksColor.black),),
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
                                ]else if(widget.type == "Pending")...[
                                  SizedBox(
                                    height: height/22,
                                    width: height/26,
                                    child: PopupMenuButton<int>(itemBuilder: (context) =>[
                                      PopupMenuItem(
                                        value: 1,
                                        child: Row(
                                          children: [
                                            Image.asset(Images.tickSquare,height: height/36,),
                                            SizedBox(width: width/36,),
                                            Text("Enable",style: hsRegular.copyWith(fontSize: 16,color: TasksColor.black),),
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
                                ]else...[
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
                                ]
                              ],
                            ),
                            Text("07:00 - 07:15",style: hsRegular.copyWith(fontSize: 14,color: TasksColor.textappcolor),),
                            SizedBox(height: height/46,),
                            Row(
                              children: [
                                Container(
                                    decoration: BoxDecoration(
                                        color: const Color(0xffFFE9ED),
                                        borderRadius: BorderRadius.circular(5)
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: width/36,vertical: height/120),
                                      child: Text("Urgent",style: hsMedium.copyWith(fontSize: 10,color: TasksColor.lightred),),
                                    )),
                                SizedBox(width: width/36,),
                                Container(
                                    decoration: BoxDecoration(
                                        color:  widget.type == "Completed"
                                            ? TasksColor.sky
                                            : widget.type == "Canceled"
                                            ?  TasksColor.lightorange
                                            : widget.type == "Pending"
                                            ?  TasksColor.lightpurple
                                            :  TasksColor.parrot,
                                        borderRadius: BorderRadius.circular(5)
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: width/36,vertical: height/120),
                                      child: Text("Home",style: hsMedium.copyWith(fontSize: 10,
                                        color: widget.type == "Completed"
                                            ? TasksColor.textblue
                                            : widget.type == "Canceled"
                                            ?  TasksColor.lightred
                                            : widget.type == "Pending"
                                            ?  TasksColor.purple
                                            :  TasksColor.lightgreen,),),
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },),
              ),
              SizedBox(height: height/36,),
              Text("16 May 2021",style: hsRegular.copyWith(fontSize: 14),),
              SizedBox(height: height/46,),
              SizedBox(
                height: height/5.7,
                child: ListView.builder(
                  itemCount: 3,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Container(
                      width: width/1.8,
                      margin: EdgeInsets.only(right: width/36),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: widget.type == "Completed"
                              ? TasksColor.bgsky
                              : widget.type == "Canceled"
                              ?  TasksColor.bgred
                              : widget.type == "Pending"
                              ?  TasksColor.bgpurple
                              :  TasksColor.bggreen
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: width/36,vertical: height/80),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text("Cleaning Clothes",style: hsMedium.copyWith(fontSize: 16,color: TasksColor.black),),
                                const Spacer(),
                                if(widget.type == "Completed")...[
                                  SizedBox(
                                    height: height/22,
                                    width: height/26,
                                    child: PopupMenuButton<int>(itemBuilder: (context) =>[
                                      PopupMenuItem(
                                        value: 1,
                                        child: Row(
                                          children: [
                                            Image.asset(Images.upload,height: height/36,),
                                            SizedBox(width: width/36,),
                                            Text("Restore",style: hsRegular.copyWith(fontSize: 16,color: TasksColor.black),),
                                          ],
                                        ),
                                      ),
                                      PopupMenuItem(
                                        value: 2,
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
                                ]else if(widget.type == "Canceled")...[
                                  SizedBox(
                                    height: height/22,
                                    width: height/26,
                                    child: PopupMenuButton<int>(itemBuilder: (context) =>[
                                      PopupMenuItem(
                                        value: 1,
                                        child: Row(
                                          children: [
                                            Image.asset(Images.editSquare,height: height/36,),
                                            SizedBox(width: width/36,),
                                            Text("Edit",style: hsRegular.copyWith(fontSize: 16,color: TasksColor.black),),
                                          ],
                                        ),
                                      ),
                                      PopupMenuItem(
                                        value: 2,
                                        child: Row(
                                          children: [
                                            Image.asset(Images.upload,height: height/36,),
                                            SizedBox(width: width/36,),
                                            Text("Restore",style: hsRegular.copyWith(fontSize: 16,color: TasksColor.black),),
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
                                ]else if(widget.type == "Pending")...[
                                  SizedBox(
                                    height: height/22,
                                    width: height/26,
                                    child: PopupMenuButton<int>(itemBuilder: (context) =>[
                                      PopupMenuItem(
                                        value: 1,
                                        child: Row(
                                          children: [
                                            Image.asset(Images.tickSquare,height: height/36,),
                                            SizedBox(width: width/36,),
                                            Text("Enable",style: hsRegular.copyWith(fontSize: 16,color: TasksColor.black),),
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
                                ]else...[
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
                                ]
                              ],
                            ),
                            Text("07:00 - 07:15",style: hsRegular.copyWith(fontSize: 14,color: TasksColor.textappcolor),),
                            SizedBox(height: height/46,),
                            Row(
                              children: [
                                Container(
                                    decoration: BoxDecoration(
                                        color: const Color(0xffFFE9ED),
                                        borderRadius: BorderRadius.circular(5)
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: width/36,vertical: height/120),
                                      child: Text("Urgent",style: hsMedium.copyWith(fontSize: 10,color: TasksColor.lightred),),
                                    )),
                                SizedBox(width: width/36,),
                                Container(
                                    decoration: BoxDecoration(
                                        color:  widget.type == "Completed"
                                            ? TasksColor.sky
                                            : widget.type == "Canceled"
                                            ?  TasksColor.lightorange
                                            : widget.type == "Pending"
                                            ?  TasksColor.lightpurple
                                            :  TasksColor.parrot,
                                        borderRadius: BorderRadius.circular(5)
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: width/36,vertical: height/120),
                                      child: Text("Home",style: hsMedium.copyWith(fontSize: 10,
                                        color: widget.type == "Completed"
                                            ? TasksColor.textblue
                                            : widget.type == "Canceled"
                                            ?  TasksColor.lightred
                                            : widget.type == "Pending"
                                            ?  TasksColor.purple
                                            :  TasksColor.lightgreen,),),
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

  Future<bool> filter() async {
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
                  Text("Sort_by_tag".tr,style: hsMedium.copyWith(fontSize: 15),),
                  SizedBox(height: height/56,),
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
                  Text("Sort_by_type".tr,style: hsMedium.copyWith(fontSize: 15),),
                  SizedBox(height: height/56,),
                  SizedBox(
                    height: height/21,
                    child: ListView.builder(
                      itemCount: type.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return  Container(
                          margin: EdgeInsets.only(right: width/36),
                          height: height/22,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: typecolor[index]
                          ),
                          child: Center(child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: width/20),
                            child: Text(type[index],style: hsRegular.copyWith(fontSize: 14,color: TasksColor.white),),
                          )),
                        );
                      },),
                  ),
                  SizedBox(height: height/36,),
                  Text("Sort_by".tr,style: hsMedium.copyWith(fontSize: 15),),
                  SizedBox(height: height/56,),
                  SizedBox(
                    height: height/21,
                    child: ListView.builder(
                      itemCount: shot.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return  Container(
                          margin: EdgeInsets.only(right: width/36),
                          height: height/22,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: TasksColor.bggray
                          ),
                          child: Center(child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: width/20),
                            child: Text(shot[index],style: hsRegular.copyWith(fontSize: 14,color: TasksColor.black),),
                          )),
                        );
                      },),
                  ),
                  SizedBox(height: height/26,),
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
                            child: Center(child: Text("Filter".tr,style: hsRegular.copyWith(fontSize: 14,color: TasksColor.white),)),
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
