import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class DashBoardCard extends StatefulWidget {
  final String title;
  final String imageString;
  final Function onPressed;
  final Color cardColor;

  const DashBoardCard({
    Key? key,
    required this.title,
    required this.imageString,
    required this.onPressed,
    required this.cardColor,
  }) : super(key: key);

  @override
  State<DashBoardCard> createState() => _DashBoardCardState();
}

class _DashBoardCardState extends State<DashBoardCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _animate() {
    _animationController.forward();
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.reverse();
      }
    });
  }

  Color generateRandomColor() {
    final random = Random();
    final int red = 200 + random.nextInt(55);
    final int green = 200 + random.nextInt(55);
    final int blue = 200 + random.nextInt(55);

    return Color.fromRGBO(red, green, blue, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    final randomColor = generateRandomColor();

    return GestureDetector(
      onTap: () {
        _animate();
        widget.onPressed();
      },
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0.0, -10.0 * _animationController.value),
            child: child,
          );
        },
        child: Card(
          elevation: 5.0,
          color: randomColor,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 20.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  widget.imageString,
                  height: 40.h,
                  fit: BoxFit.fitHeight,
                ),
                SizedBox(width: 16.w),
                Text(
                  widget.title,
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: 24.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
