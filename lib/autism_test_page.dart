import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class AutismTestPage extends StatefulWidget {
  const AutismTestPage({super.key});

  @override
  State<AutismTestPage> createState() => _AutismTestPageState();
}

class _AutismTestPageState extends State<AutismTestPage> {

  final List<bool> _answers = [true, false, true, true, true, true, true, true, true, true, true, true, true, true, true, true, true, false, true,  true];
  final List<String> _autismQuestions = [
    "If you point at something across the room, does your child look at it?\n(For example, if you point at a toy or an animal, does your child look at the toy or animal?)",
    "Have you ever wondered if your child might be deaf?\n(For example, if your child does not respond to sounds or their name being called)",
    "Does your child play pretend or make-believe?\n(For example, pretend to drink from an empty cup, pretend to talk on a phone, or pretend to feed a doll or stuffed animal)",
    "Does your child like climbing on things?\n(For example, furniture, playground equipment, or stairs)",
    "Does your child make unusual finger movements near his or her eyes?\n(For example, does your child wiggle his or her fingers close to his or her eyes?)",
    "Does your child point with one finger to ask for something or to get help?\n(For example, pointing to a snack or toy that is out of reach)",
    "Does your child point with one finger to show you something interesting?\n(For example, pointing to an airplane in the sky or a big truck in the road)",
    "Is your child interested in other children?\n(For example, does your child watch other children, smile at them, or go to them?)",
    "Does your child show you things by bringing them to you or holding them up for you to see – not to get help, but just to share?\n(For example, showing you a flower, a stuffed animal, or a toy truck)",
    "Does your child respond when you call his or her name?\n(For example, does he or she look up, talk or babble, or stop what he or she is doing when you call his or her name?)",
    "When you smile at your child, does he or she smile back at you?",
    "Does your child get upset by everyday noises?\n(For example, a vacuum cleaner or loud music)",
    "Does your child walk?",
    "Does your child look you in the eye when you are talking to him or her, playing with him or her, or dressing him or her?",
    "Does your child try to copy what you do?\n(For example, wave bye-bye, clap, or make a funny noise when you do)",
    "If you turn your head to look at something, does your child look around to see what you are looking at?",
    "Does your child try to get you to watch him or her?\n(For example, does your child look at you for praise, or say 'look' or 'watch me')",
    "Does your child understand when you tell him or her to do something?\n(For example, if you don’t point, can your child understand 'put the book on the chair' or 'bring me the blanket')",
    "If something new happens, does your child look at your face to see how you feel about it?\n(For example, if he or she hears a strange or funny noise, or sees a new toy, will he or she look at your face?)",
    "Does your child like movement activities?\n(For example, being swung or bounced on your knee)",
  ];

  final List<String> _imageLinks = [
    "https://static.vecteezy.com/system/resources/previews/001/966/683/original/kid-playing-with-toy-railway-free-vector.jpg",
    "https://media.istockphoto.com/id/1398135630/vector/boy-listening-gesture.jpg?s=612x612&w=0&k=20&c=MZTHn9Ram63Gje2BXdXtJAbMLyCT5th677RZ8qZr73k=",
    "https://static.vecteezy.com/system/resources/previews/007/214/013/original/dramatic-play-activity-semi-flat-rgb-color-illustration-role-play-experience-after-school-activity-male-child-pretending-pirate-isolated-cartoon-character-on-white-background-vector.jpg",
    "https://cdn2.vectorstock.com/i/1000x1000/57/06/cute-little-boy-climbing-up-ladder-kid-having-fun-vector-21705706.jpg",
    "https://www.shutterstock.com/image-vector/little-girl-pointing-her-nose-600nw-2038532423.jpg",
    "https://img.freepik.com/premium-vector/cute-boy-standing-pointing-many-junk-food_33070-7703.jpg",
    "https://www.shutterstock.com/image-vector/dream-vector-concept-three-little-600nw-2103757583.jpg",
    "https://i.pinimg.com/736x/ae/78/9b/ae789b2201884917140fff13f5fabd9a.jpg",
    "https://previews.123rf.com/images/decorwithme/decorwithme1906/decorwithme190600248/128175940-mother-and-daughter-cartoon-people-characters-illustration-on-white-background-young-parent-sitting.jpg",
    "https://img.freepik.com/premium-vector/little-kid-raise-hand-answer-question_97632-7028.jpg",
    "https://en.pimg.jp/081/208/953/1/81208953.jpg",
    "https://media.istockphoto.com/id/1366762947/vector/cute-little-boy-cover-ear-from-loud-sound.jpg?s=612x612&w=0&k=20&c=hB-hcsVIc0WhRuw8jtRPVugfHvPgcxbQe8qfS7CivuY=",
    "https://img.freepik.com/premium-vector/cartoon-boy-walking_61103-291.jpg",
    "https://en.pimg.jp/054/412/551/1/54412551.jpg",
    "https://st.depositphotos.com/1007989/3946/i/950/depositphotos_39462851-stock-illustration-sibling-imitation.jpg",
    "https://thumbs.dreamstime.com/b/cartoon-boy-scouting-red-shirt-spying-around-isolated-80614992.jpg",
    "https://cdni.iconscout.com/illustration/premium/thumb/kid-demanding-with-mother-4425887-3685860.png?f=webp",
    "https://thumbs.dreamstime.com/b/father-talking-to-his-puzzled-son-supporting-soothing-him-vector-illustration-young-parent-engaged-conversation-244838541.jpg",
    "https://img.freepik.com/premium-vector/mom-daughter-look-each-other_641360-185.jpg",
    "https://t3.ftcdn.net/jpg/00/91/02/50/360_F_91025068_vcSb5ggWHS3UQaEgmWW04aJhMlZtc0rO.jpg",
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 60.h),
                          child: Text(
                            "Q${index+1}. ${_autismQuestions[index]}",
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontSize: 25.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        SizedBox(height: 40.h),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            fixedSize: Size(140.w, 45.h),
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
                                fontSize: 28.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: 15.h),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            fixedSize: Size(140.w, 45.h),
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
                                fontSize: 28.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: 50.h,),
                        Image.network(
                          _imageLinks[index],
                          height: 220.h,
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
          SizedBox(height: 16.h,),
          CircleAvatar(
            radius: 100.w,
            backgroundColor: Colors.indigoAccent,
            backgroundImage: const AssetImage(
              "images/testok.jpg",
            ),
          ),
          SizedBox(height: 20.h,),
          Card(
            color: const Color(0xff4bdc23),
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
          SizedBox(height: 16.h,),
          CircleAvatar(
            radius: 100.w,
            backgroundColor: Colors.indigoAccent,
            backgroundImage: const AssetImage(
              "images/testfail.jpg",
            ),
          ),
          SizedBox(height: 20.h,),
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
          SizedBox(height: 10.h,),
          Divider(
            thickness: 1.w,
            color: Colors.black54,
          ),
          SizedBox(height: 16.h,),
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
          SizedBox(height: 20.h,),
          Divider(
            thickness: 1.w,
            color: Colors.black54,
          ),
          SizedBox(height: 20.h,),
          Text(
            'The test consists of 20 yes-no questions based on child\'s behaviour. Please answer all the questions correctly.',
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontSize: 20.sp,
                color: const Color(0xff6a03c5),
                fontWeight: FontWeight.w600,
              ),
            ),
            textAlign: TextAlign.justify,
          ),
          SizedBox(height: 25.h,),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  elevation: 6.h,
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.w)
                  )
              ),
              onPressed: () async {
                try {
                  final result = await InternetAddress.lookup('google.com');
                  if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
                    setState(() {
                      _showWelcomePage = false;
                    });
                  }
                } on SocketException catch (_) {
                  Fluttertoast.showToast(
                      msg: "Please connect to internet",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.orange,
                    textColor: Colors.white
                  );
                }
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
        ],
      ),
    );
  }
}
