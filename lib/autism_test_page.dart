import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AutismTestPage extends StatefulWidget {
  const AutismTestPage({super.key});

  @override
  State<AutismTestPage> createState() => _AutismTestPageState();
}

class _AutismTestPageState extends State<AutismTestPage> {

  final List<bool> _answers = [true, false, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, false, true,  true];
  final List<String> _autismQuestions = [
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

  double _autismPercent = 0.0;
  int _index = 0;
  final PageController _pageController = PageController();
  bool _showResult = false;
  bool _showWelcomePage = true;

  @override
  Widget build(BuildContext context) {

    return ScreenUtilInit(
      designSize: const Size(450,800),
      builder: (context, child){
        return Scaffold(
          body: SafeArea(
            child:  _showWelcomePage? _welcomePage() : _showResult? _showResultScreen() : Stack(
              children: [
                PageView.builder(
                  controller: _pageController,
                  itemCount: _autismQuestions.length,
                  onPageChanged: (int page) {
                    setState(() {
                      _index = page;
                    });
                  },
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.w),
                          child: Text(
                            "Q${index+1}. ${_autismQuestions[index]}",
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontSize: 24.sp,
                                color: Colors.black,
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
                            if(_answers[index]){
                              _autismPercent += 5;
                            }
                            else{
                              _autismPercent -= 5;
                            }
                            if (index < _autismQuestions.length - 1){
                              _pageController.nextPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInOut,
                              );
                            }
                            if(index == 19){
                              setState(() {
                                _showResult = true;
                              });
                            }
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
                            if(!_answers[index]){
                              _autismPercent += 5;
                            }
                            else{
                              _autismPercent -= 5;
                            }
                            if (index < _autismQuestions.length - 1){
                              _pageController.nextPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInOut,
                              );
                            }
                            if(index == 19){
                              setState(() {
                                _showResult = true;
                              });
                            }
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
                          'Question ${_index+1} of 20',
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
                        width: _index * 0.0526315789473684 * 450.w,
                        color: Colors.green,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _showResultScreen(){
    return Container(
      height: 780.h,
      width: 450.w,
      color: Colors.white,
      child: _autismPercent > 60? Column(
        children: [
          SizedBox(height: 40.h,),
          Text(
            'Your child is fine, nothing to worry',
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontSize: 24.sp,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 12.h,),
          Card(
            color: const Color(0xFF64EC1D),
            elevation: 6.h,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 16.h),
              child: Text(
                'Screen again after the next birthday.\nNo further action required unless screening indicates risk for Autism',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontSize: 20.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ) : Column(
        children: [
          SizedBox(height: 40.h,),
          Text(
            'Your child is at risk, please consult',
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontSize: 24.sp,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 12.h,),
          Card(
            color: Colors.redAccent,
            elevation: 6.h,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 16.h),
              child: Text(
                'The screening test for autism is positive. To confirm the diagnosis book a consultation with us or go to nearby pediatric neurologist',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontSize: 20.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _welcomePage(){
    return Container(
      height: 780.h,
      width: 450.w,
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30.h,),
          Center(
            child: Row(
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.of(context).pop();
                  },
                  child: Icon(
                      Icons.arrow_back_sharp,
                    size: 36.w,
                  ),
                ),
                SizedBox(width: 12.w,),
                Text(
                  'Welcome to Autism Test',
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: 28.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h,),
          Text(
            'This test is recommended by WHO & American Academy of Pediatrics for child 18 months or older.',
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontSize: 20.sp,
                color: const Color(0xFF818181),
                fontWeight: FontWeight.w500,
              ),
            ),
            textAlign: TextAlign.justify,
          ),
          SizedBox(height: 20.h,),
          Text(
            'The test consists of 20 yes-no questions based on child\'s behaviour. Please answer all the questions correctly.',
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontSize: 20.sp,
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
            textAlign: TextAlign.justify,
          ),
          SizedBox(height: 20.h,),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 6.h,
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.w)
                  )
              ),
              onPressed: (){
                setState(() {
                  _showWelcomePage = false;
                });
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                child: Text(
                  'START',
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: 28.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          SizedBox(height: 20.h,),
          Divider(
            thickness: 1.w,
            color: Colors.black54,
          ),
          SizedBox(height: 20.h,),
          Text(
            'What to do if your child is suspected to have autism ?',
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontSize: 23.sp,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            textAlign: TextAlign.left,
          ),
          SizedBox(height: 12.h,),
          Text(
            'You don\'t need to worry, it is just a suspicion, and your child may be fine. However, the results should not be ignored.\nWe recommend seeking professional advice for a comprehensive evaluation. Early intervention makes a positive impact.',
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontSize: 20.sp,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}
