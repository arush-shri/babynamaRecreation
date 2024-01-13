import 'package:babynama/file_handler.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class TrackGrowthPage extends StatefulWidget {
  const TrackGrowthPage({super.key});

  @override
  State<TrackGrowthPage> createState() => _TrackGrowthPageState();
}

class _TrackGrowthPageState extends State<TrackGrowthPage> {

  String datePicked = DateFormat("dd/MM/yy").format(DateTime.now());
  String height = "";
  String weight = "";
  late List<Map<String, dynamic>> growtHistory;
  bool showRecords = false;

  void getGrowth() async {
    growtHistory = await FileHandler().getGrowthData();
  }

  @override
  void initState() {
    getGrowth();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !showRecords,
      onPopInvoked: (bool it){
        setState(() {
          showRecords = false;
        });
      },
      child: ScreenUtilInit(
        designSize: const Size(450, 800),
        builder: (context, child){
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: Stack(
              children: [
                Column(
                  children: [
                    SizedBox(height: 100.h,),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 5.h,
                                backgroundColor: const Color(0xffc9efff),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(13.w)
                                ),
                                fixedSize: Size(200.w, 60.h)
                            ),
                            onPressed: (){
                              setState(() {
                                showRecords = true;
                              });
                            },
                            child: Text(
                              'Past Records',
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  fontSize: 22.sp,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 5.h,
                                backgroundColor: const Color(0xffc9efff),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(13.w)
                                ),
                                fixedSize: Size(200.w, 60.h)
                            ),
                            onPressed: (){},
                            child: Text(
                              'Show Charts',
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  fontSize: 22.sp,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 12.h,),
                    Divider(
                      thickness: 1.w,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 8.h,),
                    Text(
                      'Add Growth Vitals',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 28.sp,
                          color: Colors.grey,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8.h,),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 6.h,
                        backgroundColor: Colors.blue,
                          fixedSize: Size(220.w, 60.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.w)
                        )
                      ),
                        onPressed: () async {
                          DateTime selectedDate = DateTime(2024, 1, 1);
                          await showDialog(
                            context: context,
                            builder: (BuildContext builder) {
                              return AlertDialog(
                                insetPadding: EdgeInsets.all(10.w),
                                content: SizedBox(
                                  height: 200.h,
                                  width: 350.w,
                                  child: CupertinoDatePicker(
                                    mode: CupertinoDatePickerMode.date,
                                    initialDateTime: selectedDate,
                                    onDateTimeChanged: (DateTime newDateTime) {
                                      setState(() {
                                        selectedDate = newDateTime;
                                      });
                                    },
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      'Cancel',
                                      style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                          fontSize: 22.sp,
                                          color: Colors.orangeAccent,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      setState(() {
                                        datePicked = DateFormat("dd/MM/yy").format(selectedDate);
                                      });
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      'Ok',
                                      style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                          fontSize: 22.sp,
                                          color: Colors.orangeAccent,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(Icons.calendar_today, color: Colors.white, size: 28.w,),
                            Text(
                              datePicked,
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  fontSize: 22.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                    ),
                    SizedBox(height: 10.h,),
                    Image.asset(
                        "images/growth.jpg",
                      height: 200.h,
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                      child: Column(
                        children: [
                          TextField(
                            decoration: InputDecoration(
                                hintText: "Height(in cm)",
                                hintStyle: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    fontSize: 18.sp,
                                    color: Colors.blueGrey,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.w)
                                )
                            ),
                            maxLines: 1,
                            keyboardType: TextInputType.number,
                            onChanged: (String heightInput){
                              height = heightInput;
                            },
                          ),
                          SizedBox(height: 20.h,),
                          TextField(
                            decoration: InputDecoration(
                                hintText: "Weight(in Kg)",
                                hintStyle: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    fontSize: 18.sp,
                                    color: Colors.blueGrey,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.w)
                                )
                            ),
                            maxLines: 1,
                            keyboardType: TextInputType.number,
                            onChanged: (String weightInput){
                              weight = weightInput;
                            },
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE1CD4E),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.w),
                        ),
                        fixedSize: Size(200.w, 60.h)
                      ),
                        onPressed: () async {
                          FileHandler().storeGrowthFile(datePicked, height, weight);
                          growtHistory = await FileHandler().getGrowthData();
                        },
                        child: Text(
                          'Save Data',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: 27.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          textAlign: TextAlign.center,
                        ),
                    ),
                  ],
                ),
                showRecords? Positioned(
                  top: 0,
                    child: _recordScreen(),
                ) : const SizedBox(),
              ],
            ),
          );
        },
      ),
    );
  }
  Widget _recordScreen(){
    return Container(
      color: Colors.white,
      height: 800.h,
      width: 450.w,
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Column(
        children: [
          SizedBox(
            height: 70.h,
          ),
          Table(
            children: [
              _makeTableRow("Date", 'Height', "Weight", Colors.black),
              for(var data in growtHistory)
                _makeTableRow(data['date'], data['height'], data["weight"], Colors.blueGrey)
            ],
          ),
          Divider(
            thickness: 1.w,
            color: Colors.blueGrey,
          ),
        ],
      ),
    );
  }

  TableRow _makeTableRow(String column1, String column2, String column3, Color textColor){
    return TableRow(
        children: [
          TableCell(
            child: SizedBox(
              height: 36.h,
              child: Text(
                column1,
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontSize: 22.sp,
                    color: textColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          TableCell(
            child: SizedBox(
              height: 36.h,
              child: Text(
                column2,
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontSize: 22.sp,
                    color: textColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          TableCell(
            child: SizedBox(
              height: 36.h,
              child: Text(
                column3,
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontSize: 22.sp,
                    color: textColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          )
        ]
    );
  }
}
