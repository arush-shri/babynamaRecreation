import 'package:babynama/customWidgets/vaccination_card.dart';
import 'package:babynama/file_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class VaccinePage extends StatelessWidget {
  final List<Map<String, dynamic>> vaccineData;

  const VaccinePage({super.key, required this.vaccineData});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (bool it){
        if(it){
          FileHandler().storeFile(vaccineData);
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
                              fontSize: 26.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      // Use the vaccineData to create VaccinationCard for each item
                      Column(
                        children: vaccineData.map((data) {
                          return VaccinationCard(
                            question: data['question'],
                            choices: Map<String, bool>.from(data['choices']),
                          );
                        }).toList(),
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
}
