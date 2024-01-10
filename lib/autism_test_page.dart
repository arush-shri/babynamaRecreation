import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AutismTestPage extends StatefulWidget {
  const AutismTestPage({super.key});

  @override
  State<AutismTestPage> createState() => _AutismTestPageState();
}

class _AutismTestPageState extends State<AutismTestPage> {

  List<bool> answers = [true, false, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, false, true,  true];
  List<String> autismQuestions = [
    "If you point at something across the room, does your child look at it? (For example, if you point at a toy or an animal, does your child look at the toy or animal?)",
    "Have you ever wondered if your child might be deaf? (For example, if your child does not respond to sounds or their name being called)",
    "Does your child play pretend or make-believe? (For example, pretend to drink from an empty cup, pretend to talk on a phone, or pretend to feed a doll or stuffed animal)",
    "Does your child like climbing on things? (For example, furniture, playground equipment, or stairs)",
    "Does your child make unusual finger movements near his or her eyes? (For example, does your child wiggle his or her fingers close to his or her eyes?)",
    "Does your child point with one finger to ask for something or to get help? (For example, pointing to a snack or toy that is out of reach)",
    "Does your child point with one finger to show you something interesting? (For example, pointing to an airplane in the sky or a big truck in the road)",
    "Is your child interested in other children? (For example, does your child watch other children, smile at them, or go to them?)",
    "Does your child show you things by bringing them to you or holding them up for you to see – not to get help, but just to share? (For example, showing you a flower, a stuffed animal, or a toy truck)",
    "Does your child respond when you call his or her name? (For example, does he or she look up, talk or babble, or stop what he or she is doing when you call his or her name?)",
    "When you smile at your child, does he or she smile back at you?",
    "Does your child get upset by everyday noises? (For example, a vacuum cleaner or loud music)",
    "Does your child walk?",
    "Does your child look you in the eye when you are talking to him or her, playing with him or her, or dressing him or her?",
    "Does your child try to copy what you do? (For example, wave bye-bye, clap, or make a funny noise when you do)",
    "If you turn your head to look at something, does your child look around to see what you are looking at?",
    "Does your child try to get you to watch him or her? (For example, does your child look at you for praise, or say 'look' or 'watch me')",
    "Does your child understand when you tell him or her to do something? (For example, if you don’t point, can your child understand 'put the book on the chair' or 'bring me the blanket')",
    "If something new happens, does your child look at your face to see how you feel about it? (For example, if he or she hears a strange or funny noise, or sees a new toy, will he or she look at your face?)",
    "Does your child like movement activities? (For example, being swung or bounced on your knee)",
  ];

  double autismPercent = 0.0;
  int index = 0;
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    Color randomColor = generateRandomColor();

    return ScreenUtilInit(
      designSize: const Size(450,800),
      builder: (context, child){
        return Scaffold(
          body: Stack(
            children: [
              PageView.builder(
                controller: pageController,
                itemCount: autismQuestions.length,
                onPageChanged: (int page) {
                  setState(() {
                    index = page;
                  });
                },
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        child: Text(
                          "Q${index+1}. ${autismQuestions[index]}",
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: 24.sp,
                              color: randomColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 40.h),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          fixedSize: Size(140.w, 30.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14.w),
                          ),
                        ),
                        onPressed: () {
                          if(!answers[index]){
                            autismPercent += 5;
                          }
                          if (index < autismQuestions.length - 1){
                            pageController.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                            );
                          }
                          randomColor = generateRandomColor();
                        },
                        child: Text(
                          'YES',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: 26.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 15.h),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          fixedSize: Size(100.w, 30.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14.w),
                          ),
                        ),
                        onPressed: () {
                          if(answers[index]){
                            autismPercent += 5;
                          }
                          if (index < autismQuestions.length - 1){
                            pageController.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                            );
                          }
                          randomColor = generateRandomColor();
                        },
                        child: Text(
                          'NO',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: 26.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  );
                },
              ),
              Positioned(
                bottom: 0,
                left: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: Text(
                        'Question ${index+1} of 20',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: 20.sp,
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      height: 6.h,
                      width: index * 0.0526315789473684 * 450.w,
                      color: Colors.green,
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );

  }

  Color generateRandomColor() {
    final random = Random();
    final int red = 50 + random.nextInt(100);
    final int green = 50 + random.nextInt(100);
    final int blue = 50 + random.nextInt(100);

    return Color.fromRGBO(red, green, blue, 1.0);
  }
}
