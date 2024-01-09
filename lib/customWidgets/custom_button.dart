import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: (){},
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.h)
            ),
            fixedSize: Size(200.w, 50.h),
            backgroundColor: const Color(0xFFA52FF3),
            elevation: 8
        ),
        child: Text("Register",
          style: TextStyle(fontSize: 26.sp, fontFamily: "Lexend",
              fontWeight: FontWeight.w700, color: Colors.white),
        )
    );
  }
}
