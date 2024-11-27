import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:olympia/constants/colors.dart';
import 'package:olympia/controller/attendanceprovider.dart';
import 'package:olympia/controller/auth_provider.dart';
import 'package:olympia/controller/coursesprovider.dart';
import 'package:olympia/controller/imgstorageprovider.dart';
import 'package:olympia/controller/user_provider.dart';
import 'package:olympia/customwidgets/admin_bottomnavbar.dart';
import 'package:olympia/customwidgets/bottomnavbar.dart';
import 'package:olympia/firebase_options.dart';
import 'package:olympia/view/admin/attendance_admin.dart';
import 'package:olympia/view/admin/displaydates.dart';
import 'package:olympia/view/admin/homepage_admin.dart';
import 'package:olympia/view/admin/notificationadmin.dart';
import 'package:olympia/view/admin/profile_admin.dart';
import 'package:olympia/view/admin/schedule_admin.dart';

import 'package:olympia/view/user/attendance.dart';
import 'package:olympia/view/user/forgot_password.dart';
import 'package:olympia/view/user/notification.dart';
import 'package:olympia/view/user/profile.dart';
import 'package:olympia/view/user/schedule.dart';
import 'package:olympia/view/user/signin.dart';
import 'package:olympia/view/user/signup.dart';
import 'package:olympia/view/user/splash.dart';
import 'package:provider/provider.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AttendanceProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ImgStorageProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => Coursesprovider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
        
      ],
      child: MaterialApp(
        theme: ThemeData(
            appBarTheme: AppBarTheme(
                toolbarHeight: 70,
                actionsIconTheme: IconThemeData(color: Appcolors.primarycolor),
                backgroundColor: Appcolors.secondarycolor,
                iconTheme: const IconThemeData(
                  size: 50,
                )),
            scaffoldBackgroundColor: Appcolors.secondarycolor),
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const Splash(),
          // '/splash': (context) => const Splash2(),
          '/signIn': (context) => const Signin(),
          '/signUp': (context) => const SignUp(),
          '/forgotpassword': (context) => ForgotPassword(),
          // '/otpverification': (context) => const OtpVerification(),
          // '/otpconfirm': (context) => const Otpconfirm(),
          // '/homepage': (context) => const Homepage(),

          '/schedule': (context) => const Schedule(),
          '/attendance': (context) => Attendance(),
          '/profile': (context) => const Profile(),
          '/bottomnavbar': (context) => const BottomnavbarCustom(),
          '/notification': (context) => const NotificationPage(),

          ///////////////////////////////ADMIN//////////////////////////////

          // '/splashadmin': (context) => const SplashAdmin(),
          // '/loginadmin': (context) => LoginAdmin(),
          '/homepageadmin': (context) => const HomepageAdmin(),
          '/bottomnavbaradmin': (context) => const AdminBottomnavbarCustom(),
          // '/scheduleadmin': (context) => const ScheduleAdmin(),
          '/attendanceadmin': (context) => AttendanceAdmin(),
          '/profileadmin': (context) => const ProfileAdmin(),
          '/studentslist': (context) => const ProfileAdmin(),
          '/notificationadmin': (context) => const NotificationAdminPage(),
          '/displaydates': (context) => const DatesListPage(),
        },
      ),
    );
  }
}
