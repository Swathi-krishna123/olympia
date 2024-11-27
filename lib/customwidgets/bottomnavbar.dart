import 'package:flutter/material.dart';
import 'package:olympia/constants/colors.dart';
import 'package:olympia/constants/fonts.dart';
import 'package:olympia/constants/icons.dart';
import 'package:olympia/view/admin/homepage_admin.dart';
import 'package:olympia/view/user/attendance.dart';
import 'package:olympia/view/user/homepage.dart';
import 'package:olympia/view/user/profile.dart';
import 'package:olympia/view/user/schedule.dart';

class BottomnavbarCustom extends StatefulWidget {
  const BottomnavbarCustom({super.key});

  @override
  State<BottomnavbarCustom> createState() => _BottomnavbarCustomState();
}

class _BottomnavbarCustomState extends State<BottomnavbarCustom> {
  int _currentindex = 0;
  List<Widget> pages = [
    const HomepageAdmin(),
    const Schedule(),
    Attendance(),
    const Profile()
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
              label: 'Profile',
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
