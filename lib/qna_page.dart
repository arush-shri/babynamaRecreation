import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AskQuestionsPage extends StatefulWidget {
  const AskQuestionsPage({super.key});

  @override
  State<AskQuestionsPage> createState() => _AskQuestionsPageState();
}

class _AskQuestionsPageState extends State<AskQuestionsPage> {
  int _currentIndex = 0;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(450, 800),
      builder: (context, child){
        return SafeArea(
          child: Scaffold(
            appBar: PreferredSize(
                preferredSize: Size.fromHeight(120.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Card(
                        color: Colors.white,
                        elevation: 4.h,
                        child: Container(
                          width: 380.w,
                          height: 70.h,
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: (){_changePage(0);},
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(height: 10.h,),
                                    Image.asset('images/qna.png', height: 34.h,),
                                    Text(
                                      'Ask a Question',
                                      style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                          fontSize: 18.sp,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    AnimatedContainer(
                                      height: 3.h,
                                      width: _currentIndex == 0 ? 120.w : 0,
                                      color: Colors.blue, // Underline color
                                      duration: const Duration(milliseconds: 300),
                                    ),
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: (){_changePage(1);},
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(height: 10.h,),
                                    Image.asset('images/quemark.png', height: 34.h),
                                    Text(
                                      'View Past Question',
                                      style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                          fontSize: 18.sp,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    AnimatedContainer(
                                      height: 3.h,
                                      width: _currentIndex == 1 ? 120.w : 0,
                                      color: Colors.blue, // Underline color
                                      duration: const Duration(milliseconds: 300),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )
            ),
            body:
                PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  children: [
                    // Page 1 content
                    Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18.w),
                        child: Column(
                          children: [
                            ClipOval(
                              child: SizedBox.fromSize(
                                size: Size.fromRadius(80.w), // Image radius
                                child: Image.asset(
                                  "images/babycare.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(height: 10.h,),
                            Text(
                              'Have a question about baby care?\nAsk our experts and get answers',
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
                            TextField(
                              maxLines: 4,
                              decoration: InputDecoration(
                                  hintText: "Question",
                                  hintStyle: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                      fontSize: 20.sp,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.w)
                                  )
                              ),
                            ),
                            SizedBox(height: 24.h,),
                            const Divider(
                              thickness: 0.5,
                              color: Colors.black87,
                            ),
                            SizedBox(height: 24.h,),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.cyanAccent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.w)
                                )
                              ),
                                onPressed: (){},
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 36.w, vertical: 8.h),
                                  child: Text(
                                    'Submit',
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                        fontSize: 27.sp,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                            )
                          ],
                        ),
                      ),
                    ),

                    const Center(
                      child: CircularProgressIndicator(
                        color: Colors.blueAccent,
                      )
                    ),
                  ],
                ),
          ),
        );
      },
    );
  }
  void _changePage(int index) {
    setState(() {
      _currentIndex = index;
      _pageController.animateToPage(index,
          duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    });
  }
}
