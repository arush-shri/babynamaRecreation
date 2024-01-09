import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class VaccinationCard extends StatefulWidget {
  final String question;
  final Map<String, bool> choices;

  const VaccinationCard({
    Key? key,
    required this.question,
    required this.choices,
  }) : super(key: key);

  @override
  State<VaccinationCard> createState() => _VaccinationCardState();
}

class _VaccinationCardState extends State<VaccinationCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.h,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.question,
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontSize: 18.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(height: 6.h),
            for (var entry in widget.choices.entries)
              if (!entry.value)
                CheckboxListTile(
                  title: Text(
                      entry.key,
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 18.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  value: entry.value,
                  onChanged: (value) {
                    setState(() {
                      widget.choices[entry.key] = value!;
                    });
                  },
                ),
          ],
        ),
      ),
    );
  }
}