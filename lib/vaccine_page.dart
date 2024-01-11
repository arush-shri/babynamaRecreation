import 'package:babynama/file_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

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

  Map<int, Map<String, dynamic>> dueVaccineData = {};
  Map<int, Map<String, dynamic>> upcomingVaccineData ={};
  Map<int, Map<String, dynamic>> takenVaccineData = {};

  final DateTime DOB = DateTime.parse("2023-12-01");

  @override
  void initState() {
    super.initState();
    loadMapData();
    _arrowAnimationController1 = AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
    _arrowAnimationController2 = AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
    _arrowAnimationController3 = AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
    _arrowAnimationController4 = AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
  }

  bool isVaccineUpcoming(String fullDuration){

    List <String> durationList = fullDuration.split(':');
    double duration = double.parse(durationList[1].substring(0, durationList[1].length - 1));
    String durationType = durationList[1][durationList[1].length-1];

    if(durationType == "w"){
      DateTime newDate = DOB.add(Duration(days: duration.toInt()*7));
      DateTime nextWeek = DateTime.now().add(const Duration(days: 7));
      return newDate.isBefore(nextWeek) && newDate.isAfter(DateTime.now());
    }
    if(durationType == "m"){
      DateTime newDate = DOB.add(Duration(days: duration.toInt()*30));
      DateTime nextWeek = DateTime.now().add(const Duration(days: 7));
      return newDate.isBefore(nextWeek) && newDate.isAfter(DateTime.now());
    }
    if(durationType == "y"){
      DateTime newDate = DOB.add(Duration(days: duration.toInt()*365));
      DateTime nextWeek = DateTime.now().add(const Duration(days: 7));
      return newDate.isBefore(nextWeek) && newDate.isAfter(DateTime.now());
    }
    return false;
  }

  String dueDate(String fullDuration){
    List <String> durationList = fullDuration.split(':');
    double duration = double.parse(durationList[1].substring(0, durationList[1].length - 1));
    String durationType = durationList[1][durationList[1].length-1];

    if(durationType == "w"){
      DateTime newDate = DOB.add(Duration(days: duration.toInt()*7));
      return DateFormat('dd/MM/yy').format(newDate) ;
    }
    if(durationType == "m"){
      DateTime newDate = DOB.add(Duration(days: duration.toInt()*30));
      return DateFormat('dd/MM/yy').format(newDate) ;
    }
    if(durationType == "y"){
      DateTime newDate = DOB.add(Duration(days: duration.toInt()*365));
      return DateFormat('dd/MM/yy').format(newDate) ;
    }
    return DateFormat('dd/MM/yy').format(DateTime.now()) ;
  }

  void loadMapData(){
    int index = 0;
    for(var doses in widget.vaccineData){
      String currQue = "";
      doses.forEach((key, value){
        if(value.runtimeType != String){
          Map<String, bool> tmp1 = {};
          Map<String, bool> tmp2 = {};
          Map<String, bool> tmp3 = {};
          value.forEach((key2, value2) {
            if(value2){
              tmp3[key2] = value2;
            }
            else {
              tmp1[key2] = value2;
            }
            print("$currQue $key2");
            if(isVaccineUpcoming(key2) && !value2){
              tmp2[key2] = value2;
            }
          });
          if(tmp1.isNotEmpty){
            dueVaccineData[index] = {
              'question': currQue,
              'choices': tmp1,
            };
          }
          if(tmp2.isNotEmpty){
            upcomingVaccineData[index] = {
              'question': currQue,
              'choices': tmp2,
            };
          }
          if(tmp3.isNotEmpty){
            takenVaccineData[index] = {
              'question': currQue,
              'choices': tmp3,
            };
          }
        }
        else {
          currQue = value;
        }
      });
      index++;
    }
    print(dueVaccineData);
    print(takenVaccineData);
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
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: (){
                                Navigator.of(context).pop();
                              },
                              child: Icon(
                                Icons.arrow_back,
                                color: Colors.black,
                                size: 32.w,
                              ),
                            ),
                            SizedBox(width: 14.w,),
                            Text(
                              'Vaccination History',
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  fontSize: 28.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16.h),

                      dropDownWidget("Upcoming Doses", _arrowAnimationController1, Colors.yellow, (){
                        upcomingVaccineVisible = !upcomingVaccineVisible;
                      }),
                      Visibility(
                        visible: upcomingVaccineVisible,
                        child: upcomingVaccineData.isEmpty? Text("No Upcoming Doses This Week",
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: 22.sp,
                              color: Colors.deepPurpleAccent,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ) : Column(
                          children: upcomingVaccineData.entries.map((data) {
                            int index = data.key;
                            return vaccineCard(
                                data.value['question'],
                                Map<String, bool>.from(data.value['choices']),
                                Colors.yellow,
                                index,
                                'U'
                            );
                          }).toList(),
                        ),
                      ),

                      dropDownWidget("Due Vaccines", _arrowAnimationController2, Colors.red, (){
                        dueVaccineVisible = !dueVaccineVisible;
                      }),
                      Visibility(
                        visible: dueVaccineVisible,
                        child: dueVaccineData.isEmpty? Text("No Due Vaccine Doses",
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: 22.sp,
                              color: Colors.deepPurpleAccent,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ) : Column(
                          children: dueVaccineData.entries.map((data) {
                            int index = data.key;
                            return vaccineCard(
                                data.value['question'],
                                Map<String, bool>.from(data.value['choices']),
                                Colors.red,
                                index,
                                'D'
                            );
                          }).toList(),
                        ),
                      ),

                      dropDownWidget("Taken Doses", _arrowAnimationController3, const Color(0xFF0DC626), (){
                        takenVaccineVisible = !takenVaccineVisible;
                      }),
                      Visibility(
                        visible: takenVaccineVisible,
                        child: takenVaccineData.isEmpty? Text("No Vaccines Taken Yet",
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: 22.sp,
                              color: Colors.deepPurpleAccent,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ) : Column(
                          children: takenVaccineData.entries.map((data) {
                            int index = data.key;
                            return vaccineCard(
                                data.value['question'],
                                Map<String, bool>.from(data.value['choices']),
                                const Color(0xFF0DC626),
                                index,
                                'T'
                            );
                          }).toList(),
                        ),
                      ),

                      dropDownWidget("All Vaccine Status", _arrowAnimationController4, Colors.blue, (){
                        allVaccineVisible = !allVaccineVisible;
                      }),
                      Visibility(
                        visible: allVaccineVisible,
                        child: Column(
                          children: widget.vaccineData.asMap().entries.map((data) {
                            int index = data.key;
                            return vaccineCard(
                                data.value['question'],
                                Map<String, bool>.from(data.value['choices']),
                                Colors.blue,
                                index,
                                'A'
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
              child: data[0]=='U'? Icon(Icons.keyboard_arrow_up_sharp, size: 24.h, color: colorPrimary)
                  : Icon(Icons.keyboard_arrow_down_sharp, size: 24.h, color: colorPrimary),
            ),
          ],
        ),
      ),
    );
  }

  Widget vaccineCard(String question, Map<String, bool> choices, Color cardColor, int index, String doseDue){
    return Card(
      color: cardColor,
      elevation: 5.h,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question,
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontSize: 24.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            for (var entry in choices.entries)
              CheckboxListTile(
                visualDensity: VisualDensity.compact,
                dense: true,
                title: Row(
                  children: [
                    Text(
                      entry.key,
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 20.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    doseDue=="U"? Text(
                      " (${dueDate(entry.key)})",
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 18.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ) : const SizedBox(),
                  ],
                ),
                value: entry.value,
                onChanged: (value) {
                  setState(() {
                    if (!entry.value) {
                      widget.vaccineData[index]['choices'][entry.key] = true;
                      if(doseDue == "U"){
                        upcomingVaccineData[index]?['choices'][entry.key] = true;
                        upcomingVaccineData.remove(index);
                      }
                      if(doseDue == "D"){
                        dueVaccineData[index]?['choices'][entry.key] = true;
                        dueVaccineData.remove(index);
                      }
                      if(doseDue == "T"){
                        takenVaccineData[index]?['choices'][entry.key] = true;
                        takenVaccineData.remove(index);
                      }
                    }
                    loadMapData();
                  });
                },
              ),
          ],
        ),
      ),
    );
  }
}
