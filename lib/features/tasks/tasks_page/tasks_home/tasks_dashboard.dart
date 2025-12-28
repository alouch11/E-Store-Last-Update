import 'package:flutter/material.dart';
import 'package:flutter_spareparts_store/features/tasks/taks_gloabelclass/tasks_color.dart';
import 'package:flutter_spareparts_store/utill/dimensions.dart';
import 'package:flutter_spareparts_store/utill/images.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';
import '../../tasks_theme/tasks_themecontroller.dart';
import '../tasks_graphic/tasks_graphic.dart';
import '../tasks_profile/tasks_profile.dart';
import '../tasks_task/tasks_task.dart';
import 'tasks_home.dart';

// ignore: must_be_immutable
class TasksDashboard extends StatefulWidget {
  String? index;
  TasksDashboard(this.index, {super.key});

  @override
  State<TasksDashboard> createState() => _TasksDashboardState();
}

class _TasksDashboardState extends State<TasksDashboard> {
  dynamic size;
  double height = 0.00;
  double width = 0.00;
  int selectindex = 0;
  PageController pageController = PageController();
  int _selectedItemIndex = 0;
  final themedata = Get.put(TasksThemecontroler());
  final List<Widget> _pages = const [
    Taskshome(),
    TasksTask(),
    TasksGraphic(),
    TasksProfile(),
  ];

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  Widget _bottomTabBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width/30,vertical: height/36),
      child: Container(
        decoration: BoxDecoration(
            color: themedata.isdark ? TasksColor.black : TasksColor.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: const [
            BoxShadow(color: TasksColor.textgray,blurRadius: 5)
          ]
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedItemIndex,
          onTap: _onTap,
          elevation: 0,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          backgroundColor: TasksColor.transparent,
          type: BottomNavigationBarType.fixed,
        fixedColor: themedata.isdark ? TasksColor.white : TasksColor.black,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: SvgPicture.asset(Images.home,height: height/30,width: width/30,),
              activeIcon:SvgPicture.asset(Images.homefill,height: height/35,width: width/35,),
              label: '',
            ),
            BottomNavigationBarItem(

              icon: SvgPicture.asset(Images.task,height: height/30,width: width/30,),
              activeIcon: SvgPicture.asset(Images.taskfill,height: height/30,width: width/30,),
              label: '',
            ),

            BottomNavigationBarItem(

              icon: SvgPicture.asset(Images.graphic,height: height/30,width: width/30),

              activeIcon: SvgPicture.asset(Images.graphicfill,height: height/30,width: width/30,),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(Images.folder,height: height/30,width: width/30,),
              activeIcon: SvgPicture.asset(Images.folderfill,height: height/30,width: width/30,),
              label: '',
            ),
          ],
        ),
      ),
    );
  }

  void _onTap(int index) {
    setState(() {
      _selectedItemIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return GetBuilder<TasksThemecontroler>(builder: (controller) {
      return Scaffold(
        bottomNavigationBar: _bottomTabBar(),
        body: _pages[_selectedItemIndex],
      );
    });
  }
}
