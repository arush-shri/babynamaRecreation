import 'package:babynama/customWidgets/vaccination_card.dart';
import 'package:babynama/file_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class VaccinePage extends StatefulWidget {
  final List<Map<String, dynamic>> vaccineData;
  const VaccinePage({super.key, required this.vaccineData});

  @override
  State<VaccinePage> createState() => _VaccinePageState();
}

class _VaccinePageState extends State<VaccinePage> with TickerProviderStateMixin {

  bool allVaccineVisible = false;
  bool dueVaccineVisible = false;
  bool upcomingVaccineVisible = true;
  bool takenVaccineVisible = false;
  late AnimationController _arrowAnimationController1;
  late AnimationController _arrowAnimationController2;
  late AnimationController _arrowAnimationController3;
  late AnimationController _arrowAnimationController4;

  @override
  void initState() {
    super.initState();
    _arrowAnimationController1 = AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
    _arrowAnimationController2 = AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
    _arrowAnimationController3 = AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
    _arrowAnimationController4 = AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
  }

  @override
  Widget build(BuildContext context) {

    return PopScope(
      canPop: true,
      onPopInvoked: (bool it){
        if(it){
          FileHandler().storeFile(widget.vaccineData);
        }
      },
      child: ScreenUtilInit(
        designSize: const Size(450, 800),
        builder: (context, child){
          return Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(8.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          'Vaccination History',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: 28.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),

                      dropDownWidget("Upcoming Doses", _arrowAnimationController1, Colors.yellow, (){
                        upcomingVaccineVisible = !upcomingVaccineVisible;
                      }),
                      dropDownWidget("Past Due Vaccines", _arrowAnimationController2, Colors.red, (){
                        dueVaccineVisible = !dueVaccineVisible;
                      }),
                      dropDownWidget("Taken Doses", _arrowAnimationController3, const Color(0xFF0DC626), (){
                        takenVaccineVisible = !takenVaccineVisible;
                      }),
                      dropDownWidget("All Vaccine Status", _arrowAnimationController4, Colors.blue, (){
                        allVaccineVisible = !allVaccineVisible;
                      }),

                      Visibility(
                        visible: allVaccineVisible,
                        child: Column(
                          children: widget.vaccineData.map((data) {
                            return VaccinationCard(
                              question: data['question'],
                              choices: Map<String, bool>.from(data['choices']), cardColor: Colors.blue,
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget dropDownWidget(String data, AnimationController arrowAnimController, Color colorPrimary, Function callback){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      child: InkWell(
        onTap: (){
          setState(() {
            arrowAnimController.isDismissed
                ? arrowAnimController.forward()
                : arrowAnimController.reverse();
            callback();
          });
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(data,
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontSize: 22.sp,
                  color: colorPrimary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            RotationTransition(
              turns: Tween(begin: 0.0, end: 0.5).animate(arrowAnimController),
              child: Icon(Icons.keyboard_arrow_down_sharp, size: 24.h, color: colorPrimary),
            ),
          ],
        ),
      ),
    );
  }
}

