import 'package:flutter/material.dart';
import 'package:olympia/constants/colors.dart';
import 'package:olympia/constants/fonts.dart';
import 'package:olympia/constants/icons.dart';
import 'package:olympia/view/admin/attendance_admin.dart';
import 'package:olympia/view/admin/homepage_admin.dart';
import 'package:olympia/view/admin/profile_admin.dart';
import 'package:olympia/view/admin/schedule_admin.dart';
import 'package:olympia/view/admin/studentslist.dart';
import 'package:olympia/view/user/schedule.dart';


class AdminBottomnavbarCustom extends StatefulWidget {
  const AdminBottomnavbarCustom({super.key});

  @override
  State<AdminBottomnavbarCustom> createState() => _AdminBottomnavbarCustomState();
}

class _AdminBottomnavbarCustomState extends State<AdminBottomnavbarCustom> {
  int _currentindex = 0;
  List<Widget> pages = [
    const HomepageAdmin(),
    const Schedule(),
    AttendanceAdmin(),
    const Studentslist()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_currentindex],
      bottomNavigationBar: Expanded(
        child: BottomNavigationBar(
          showUnselectedLabels: true,
          unselectedItemColor: Appcolors.primarycolor,
          fixedColor: Appcolors.themecolor,
          selectedLabelStyle: Appfonts.normaltext,
          unselectedLabelStyle: Appfonts.normaltext,
          elevation: 10,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Appicons.home,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Appicons.schedule,
              ),
              label: 'Schedule',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Appicons.attendance,
              ),
              label: 'Attendance',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Appicons.profile,
              ),
              label: 'Students',
            ),
          ],
          currentIndex: _currentindex,
          onTap: (int index) {
            setState(() {
              _currentindex = index;
            });
          },
        ),
      ),
    );
  }
}
