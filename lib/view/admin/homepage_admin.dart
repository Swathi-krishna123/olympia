import 'package:flutter/material.dart';
import 'package:olympia/constants/colors.dart';
import 'package:olympia/constants/fonts.dart';
import 'package:olympia/constants/icons.dart';
import 'package:olympia/controller/auth_provider.dart';
import 'package:olympia/view/admin/acheivementsadmin.dart';
import 'package:olympia/view/admin/coursesadmin.dart';
import 'package:provider/provider.dart';

class HomepageAdmin extends StatefulWidget {
  const HomepageAdmin({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomepageAdminState createState() => _HomepageAdminState();
}

class _HomepageAdminState extends State<HomepageAdmin> {
  bool isLoading = false; // Track loading state

  @override
  Widget build(BuildContext context) {
    final authprovider = Provider.of<AuthProvider>(context);
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('OLYMPIA', style: Appfonts.olympia),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/notificationadmin');
              },
              icon: Icon(
                Appicons.notification,
                size: 28,
              ),
            ),
            Builder(builder: (context) {
              return IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: Icon(
                  Appicons.menu,
                  size: 28,
                ),
              );
            }),
            const SizedBox(width: 10),
          ],
          bottom: TabBar(
            indicatorColor: Appcolors.primarycolor,
            dividerColor: Colors.transparent,
            labelStyle: Appfonts.normalheading,
            overlayColor: WidgetStatePropertyAll(Appcolors.themecolor),
            tabs: const <Widget>[
              Tab(text: 'Achievements'),
              Tab(text: 'Courses'),
            ],
          ),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Appcolors.themecolor,
                ),
                child: Text('OLYMPIA', style: Appfonts.headline),
              ),
              ListTile(
                leading: Icon(Appicons.profile),
                title: Text('Profile', style: Appfonts.hinttext),
                onTap: () {
                  Navigator.pushNamed(context, '/profileadmin');
                },
              ),
              ListTile(
                leading: Icon(Appicons.profile),
                title: Text('Attendance History', style: Appfonts.hinttext),
                onTap: () {
                  Navigator.pushNamed(context, '/displaydates');
                },
              ),
              ListTile(
                leading: Icon(Appicons.settings),
                title: Text('Settings', style: Appfonts.hinttext),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Appicons.payment),
                title: Text('Payment', style: Appfonts.hinttext),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Appicons.Privacy),
                title: Text('Privacy Policy', style: Appfonts.hinttext),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Appicons.Termsandcondition),
                title: Text('Terms and Conditions', style: Appfonts.hinttext),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Appicons.logout),
                title: Text('Logout', style: Appfonts.hinttext),
                onTap: () async {
                  setState(() {
                    isLoading = true; // Show loading indicator
                  });
                  
                  try {
                    Navigator.pop(context);
                    await authprovider.signOut();
                    // Wait for 1 second before navigating to the sign-in page
                    await Future.delayed(const Duration(seconds: 1),() =>  Navigator.pushReplacementNamed(context, '/signIn'),);
                   
                  } catch (e) {
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Failed to logout')),
                    );
                  } finally {
                    setState(() {
                      isLoading = false; // Hide loading indicator after logout
                    });
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context); // Close the drawer after state update
                  }
                },
              ),
            ],
          ),
        ),
        body: Stack(
          children: [
            const SizedBox(
              child: TabBarView(
                children: [AcheivementsAdmin(), CoursesAdmin()],
              ),
            ),
            if (isLoading)
              Container(
                color: Colors.black.withOpacity(0.5), // Optional dark background
                child: Center(
                  child: Container(height: 60,width: 60,color: Appcolors.secondarycolor,
                    child:  Center(
                      child: CircularProgressIndicator(color: Appcolors.themecolor,), // Show loading spinner
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
