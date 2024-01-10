import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ConsultPage extends StatelessWidget {
  const ConsultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(450,800),
      builder: (context, child){
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Consult a Doctor',
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontSize: 30.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                  "images/consult.png",
                height: 200.h,
              ),
              SizedBox(height: 12.h,),
              Text(
                'Book a Consultation',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontSize: 28.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: 8.h,),
              Text(
                'Get a expert advice and guidance for your baby\'s health and development',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontSize: 20.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 12.h,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF49CFE0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13.w)
                    ),
                  fixedSize: Size(250.w, 70.h)
                ),
                onPressed: (){},
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Book Now',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: 24.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Icon(Icons.arrow_forward_sharp, color: Colors.white, size: 36.w,)
                    ],
                  ),
              ),
              SizedBox(height: 12.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff6caeb9),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13.w)
                        ),
                        fixedSize: Size(220.w, 50.h)
                    ),
                    onPressed: (){},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Appointments',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: 20.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Icon(Icons.calendar_month, color: Colors.white, size: 20.w,)
                      ],
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff1a95e0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13.w)
                        ),
                        fixedSize: Size(220.w, 50.h)
                    ),
                    onPressed: (){},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Prescription',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: 20.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Icon(Icons.add_box, color: Colors.white, size: 20.w,)
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
