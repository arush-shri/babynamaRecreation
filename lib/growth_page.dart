import 'package:babynama/file_handler.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    return ScreenUtilInit(
      designSize: const Size(450, 800),
      builder: (context, child){
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Column(
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
                      onPressed: (){},
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
                          content: SizedBox(
                            height: 200.h,
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
                  onPressed: (){
                  FileHandler().storeGrowthFile(datePicked, height, weight);
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
        );
      },
    );
  }
}
