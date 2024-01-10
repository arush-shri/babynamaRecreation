import 'package:babynama/consult_page.dart';
import 'package:babynama/file_handler.dart';
import 'package:babynama/qna_page.dart';
import 'package:babynama/vaccine_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'customWidgets/dashboard_card.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    )
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  late FileHandler fileHandler;
  late List<Map<String, dynamic>> vaccineData;

  @override
  void initState() {
    fileHandler = FileHandler();
    getVaccineData();
    super.initState();
  }

  void getVaccineData() async {
    vaccineData = await fileHandler.readFile();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(450, 800),
      builder: (context, child) {
        return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(40.h),
              child: AppBar(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Arush | M',
                        style: GoogleFonts.lexendDeca(
                          textStyle: TextStyle(
                            fontSize: 19.sp,
                            color: Colors.orangeAccent,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Text(
                        '2022-01-14',
                        style: GoogleFonts.lexendDeca(
                          textStyle: TextStyle(
                            fontSize: 19.sp,
                            color: Colors.orangeAccent,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  )
              ),
            ),
            drawer: Drawer(
              child: Column(
                children: [
                  Container(
                    height: 200.h,
                    width: 450.w,
                    color: Colors.deepPurpleAccent,
                    child: Center(
                      child: Text(
                        'Notifications',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: 34.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                          Icons.history,
                        size: 34.w,
                      ),
                      Text(
                        'Appointment History',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: 24.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),

                    ],
                  )
                ],
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              selectedItemColor: Colors.lightBlue,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: 'Profiles',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.verified_user_sharp),
                    label: 'Account',
                  ),
                ]
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 15.h,),
                    DashBoardCard(
                      title: 'Question and Answer',
                      imageString: 'images/qna.png',
                      onPressed: () {
                        Navigator.push(context,
                          MaterialPageRoute(builder: (context) => const AskQuestionsPage())
                        );
                      },
                      cardColor: Colors.blueAccent,
                    ),
                    SizedBox(height: 10.h,),
                    DashBoardCard(
                      title: 'Consult a Doctor',
                      imageString: 'images/doc.png',
                      onPressed: () {
                        Navigator.push(
                          context, MaterialPageRoute(
                            builder: (context) => const ConsultPage()
                          )
                        );
                      },
                      cardColor: Colors.blueAccent,
                    ),
                    SizedBox(height: 10.h,),
                    DashBoardCard(
                      title: 'Join Community',
                      imageString: 'images/comm.png',
                      onPressed: () {
                        // Add logic for Join Community
                      },
                      cardColor: Colors.blueAccent,
                    ),
                    SizedBox(height: 10.h,),
                    DashBoardCard(
                      title: 'Milestone',
                      imageString: 'images/kid.png',
                      onPressed: () {
                        // Add logic for Milestone
                      },
                      cardColor: Colors.blueAccent,
                    ),
                    SizedBox(height: 10.h,),
                    DashBoardCard(
                      title: 'Track Growth',
                      imageString: 'images/growth.png',
                      onPressed: () {
                        // Add logic for Track Growth
                      },
                      cardColor: Colors.blueAccent,
                    ),
                    SizedBox(height: 10.h,),
                    DashBoardCard(
                      title: 'Track Vaccination',
                      imageString: 'images/injection.png',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VaccinePage(vaccineData: vaccineData),
                          ),
                        );
                      },
                      cardColor: Colors.blueAccent,
                    ),
                    SizedBox(height: 10.h,),
                    DashBoardCard(
                      title: 'Autism Detection',
                      imageString: 'images/autism.png',
                      onPressed: () {
                        // Add logic for Autism Detection
                      },
                      cardColor: Colors.blueAccent,
                    ),
                  ],
                ),
              ),
            ),
          );
      },
    );
  }
}

