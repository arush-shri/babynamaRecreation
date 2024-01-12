import 'dart:math';

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

  bool _allVaccineVisible = false;
  bool _dueVaccineVisible = false;
  bool _upcomingVaccineVisible = true;
  bool _takenVaccineVisible = false;

  late AnimationController _arrowAnimationController1;
  late AnimationController _arrowAnimationController2;
  late AnimationController _arrowAnimationController3;
  late AnimationController _arrowAnimationController4;

  Map<int, Map<String, dynamic>> _dueVaccineData = {};
  Map<int, Map<String, dynamic>> _upcomingVaccineData ={};
  Map<int, Map<String, dynamic>> _takenVaccineData = {};
  final List<String> _reasonsToVaccinate = [
    "Vaccinations provide essential protection against serious and potentially life-threatening diseases such as measles, mumps, rubella, and whooping cough.",
    "Early vaccination helps develop a strong and resilient immune system in newborns.",
    "Preventing the spread of infectious diseases within communities.",
    "Vaccination reduces the risk of complications and severe outcomes from preventable illnesses.",
    "Creating immunity during the vulnerable period when the risk of disease is high.",
    "Contributing to community immunity (herd immunity) by protecting those who cannot be vaccinated.",
    "Guarding against outbreaks of preventable diseases in the population.",
    "Ensuring a healthy start in life by providing protection against harmful infections.",
    "Reducing the risk of long-term disabilities caused by certain diseases.",
    "Supporting global health efforts for the eradication of specific diseases through vaccination programs.",
  ];

  late String _vaccineImportance;

  final DateTime DOB = DateTime.now().subtract(const Duration(days: 40));

  @override
  void initState() {
    super.initState();
    loadMapData();
    _arrowAnimationController1 = AnimationController(vsync: this, duration: const Duration(milliseconds: 250));
    _arrowAnimationController2 = AnimationController(vsync: this, duration: const Duration(milliseconds: 250));
    _arrowAnimationController3 = AnimationController(vsync: this, duration: const Duration(milliseconds: 250));
    _arrowAnimationController4 = AnimationController(vsync: this, duration: const Duration(milliseconds: 250));
    _arrowAnimationController1.forward();
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

  bool isVaccineDue(String fullDuration){

    List <String> durationList = fullDuration.split(':');
    double duration = double.parse(durationList[1].substring(0, durationList[1].length - 1));
    String durationType = durationList[1][durationList[1].length-1];
    DateTime today = DateTime.now();

    if(durationType == "w"){
      DateTime newDate = DOB.add(Duration(days: duration.toInt()*7));
      return newDate.isBefore(today);
    }
    if(durationType == "m"){
      DateTime newDate = DOB.add(Duration(days: duration.toInt()*30));
      return newDate.isBefore(today);
    }
    if(durationType == "y"){
      DateTime newDate = DOB.add(Duration(days: duration.toInt()*365));
      return newDate.isBefore(today);
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
            if(isVaccineDue(key2) && !value2) {
              tmp1[key2] = value2;
            }
            if(isVaccineUpcoming(key2) && !value2){
              tmp2[key2] = value2;
            }
          });
          if(tmp1.isNotEmpty){
            _dueVaccineData[index] = {
              'question': currQue,
              'choices': tmp1,
            };
          }
          if(tmp2.isNotEmpty){
            _upcomingVaccineData[index] = {
              'question': currQue,
              'choices': tmp2,
            };
          }
          if(tmp3.isNotEmpty){
            _takenVaccineData[index] = {
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
  }

  @override
  Widget build(BuildContext context) {
    _vaccineImportance = _reasonsToVaccinate[Random().nextInt(10)];
    return ScreenUtilInit(
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
                        _upcomingVaccineVisible = !_upcomingVaccineVisible;
                      }),
                      SizeTransition(
                        sizeFactor: _arrowAnimationController1,
                        child: _upcomingVaccineData.isEmpty? Text("No Upcoming Doses This Week",
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: 22.sp,
                              color: Colors.deepPurpleAccent,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ) : Column(
                          children: _upcomingVaccineData.entries.map((data) {
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
                      Divider(
                        thickness: 1.w,
                        color: Colors.blueGrey,
                      ),

                      dropDownWidget("Due Vaccines", _arrowAnimationController2, Colors.red, (){
                        _dueVaccineVisible = !_dueVaccineVisible;
                      }),
                      SizeTransition(
                        sizeFactor: _arrowAnimationController2,
                        child: _dueVaccineData.isEmpty? Text("No Due Vaccine Doses",
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: 22.sp,
                              color: Colors.deepPurpleAccent,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ) : Column(
                          children: _dueVaccineData.entries.map((data) {
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
                      Divider(
                        thickness: 1.w,
                        color: Colors.blueGrey,
                      ),

                      dropDownWidget("Taken Doses", _arrowAnimationController3, const Color(0xFF0DC626), (){
                        _takenVaccineVisible = !_takenVaccineVisible;
                      }),
                      SizeTransition(
                          sizeFactor: _arrowAnimationController3,
                        child: _takenVaccineData.isEmpty? Text("No Vaccines Taken Yet",
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: 22.sp,
                              color: Colors.deepPurpleAccent,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ) : Column(
                          children: _takenVaccineData.entries.map((data) {
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
                      Divider(
                        thickness: 1.w,
                        color: Colors.blueGrey,
                      ),

                      dropDownWidget("All Vaccine Status", _arrowAnimationController4, Colors.blue, (){
                        _allVaccineVisible = !_allVaccineVisible;
                      }),
                      SizeTransition(
                        sizeFactor: _arrowAnimationController4,
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
                      Divider(
                        thickness: 1.w,
                        color: Colors.blueGrey,
                      ),
                      SizedBox(height: 10.h,),
                      Center(
                        child: Image.asset(
                          "images/vaccination.jpg",
                          height: 200.h,
                        ),
                      ),
                      SizedBox(height: 16.h,),
                      Text("Why vaccinate your child ?",
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: 22.sp,
                            color: Colors.grey,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Text(_vaccineImportance,
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: 20.sp,
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
  }

  Widget dropDownWidget(String data, AnimationController arrowAnimController, Color colorPrimary, Function callback){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: InkWell(
        onTap: (){
          setState(() {
            arrowAnimController.isDismissed
                ? arrowAnimController.forward()
                : arrowAnimController.reverse();
            callback();
          });
        },
        child: SizedBox(
          height: 40.h,
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
                child: Icon(Icons.keyboard_arrow_down_sharp, size: 26.h, color: colorPrimary),
              ),
            ],
          ),
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
                    doseDue=="U" || doseDue=="D"? Text(
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
                        _upcomingVaccineData[index]?['choices'][entry.key] = true;
                        _upcomingVaccineData.remove(index);
                      }
                      if(doseDue == "D"){
                        _dueVaccineData[index]?['choices'][entry.key] = true;
                        _dueVaccineData.remove(index);
                      }
                      if(doseDue == "T"){
                        _takenVaccineData[index]?['choices'][entry.key] = true;
                        _takenVaccineData.remove(index);
                      }
                    }
                    FileHandler().storeFile(widget.vaccineData);
                  });
                },
              ),
          ],
        ),
      ),
    );
  }
}
