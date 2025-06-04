import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swiftnex/core/constants/app_theme.dart';
import 'package:swiftnex/core/constants/button.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart'
    as smooth_page_indicator;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:swiftnex/presentation/login_screen/view/login_screen.dart';
import 'package:swiftnex/presentation/registration_screen/view/registration_screen.dart';

class OnboardingWidget extends StatefulWidget {
  const OnboardingWidget({super.key});

  @override
  State<OnboardingWidget> createState() => _OnboardingWidgetState();
}

class _OnboardingWidgetState extends State<OnboardingWidget> {
  // Remove model dependency - just use PageController directly
  PageController pageViewController = PageController(initialPage: 0);

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    // Clean up the page controller
    pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: AppTheme.background,
        body: SafeArea(
          top: true,
          child: Container(
            width: 1.sw, // Screen width
            height: 1.sh, // Screen height
            child: Stack(
              children: [
                Container(
                  width: 1.sw,
                  height: 1.sh,
                  decoration: BoxDecoration(color: AppTheme.background),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Flexible(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Flexible(
                              child: Container(
                                width: 1.sw,
                                //  height: 0.75.sh, // 75% of screen height
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 40.h),
                                      child: PageView(
                                        controller: pageViewController,
                                        scrollDirection: Axis.horizontal,
                                        children: [
                                          // First Page
                                          _buildOnboardingPage(
                                            imageUrl:
                                                'https://images.unsplash.com/photo-1714138667529-0f43a32969fa?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MXwxfHNlYXJjaHwxfHxmb29kJTIwZGVsaXZlcnl8ZW58MHx8fHwxNzE0Mjk4Nzk0fDA&ixlib=rb-4.0.3&q=80&w=1080',
                                            title:
                                                "The experience of buying food ...",
                                            subtitle:
                                                "Urna amet, suspendisse ullamco...",
                                          ),
                                          // Second Page
                                          _buildOnboardingPage(
                                            imageUrl:
                                                'https://images.unsplash.com/photo-1526367790999-0150786686a2?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwxMHx8Zm9vZCUyMGRlbGl2ZXJ5fGVufDB8fHx8MTcxNDI5ODc5NHww&ixlib=rb-4.0.3&q=80&w=1080',
                                            title:
                                                "Find and Get Your Best Food",
                                            subtitle:
                                                "Urna amet, suspendisse ullamco...",
                                          ),
                                          // Third Page
                                          _buildOnboardingPage(
                                            imageUrl:
                                                'https://images.unsplash.com/photo-1714138665637-617a4614ec9a?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MXwxfHNlYXJjaHwxNXx8Zm9vZCUyMGRlbGl2ZXJ5fGVufDB8fHx8MTcxNDI5ODc5NHww&ixlib=rb-4.0.3&q=80&w=1080',
                                            title:
                                                "Foodie's courier send with lov...",
                                            subtitle:
                                                "Urna amet, suspendisse ullamco...",
                                          ),
                                        ],
                                      ),
                                    ),
                                    // Page Indicator
                                    Align(
                                      alignment: AlignmentDirectional(0.0, 1.0),
                                      child: Padding(
                                        padding: EdgeInsets.only(bottom: 16.h),
                                        child: smooth_page_indicator.SmoothPageIndicator(
                                          controller: pageViewController,
                                          count: 3,
                                          axisDirection: Axis.horizontal,
                                          onDotClicked: (i) async {
                                            await pageViewController
                                                .animateToPage(
                                                  i,
                                                  duration: Duration(
                                                    milliseconds: 500,
                                                  ),
                                                  curve: Curves.ease,
                                                );
                                          },
                                          effect:
                                              smooth_page_indicator.SlideEffect(
                                                spacing:
                                                    6.w, // Responsive spacing
                                                radius:
                                                    100.r, // Responsive radius
                                                dotWidth:
                                                    6.w, // Responsive dot width
                                                dotHeight:
                                                    6.h, // Responsive dot height
                                                dotColor: AppTheme.primary,
                                                activeDotColor:
                                                    AppTheme.textSecondary,
                                                paintStyle: PaintingStyle.fill,
                                              ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // Bottom Buttons
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 22.w),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  // Create Account Button
                                  SizedBox(
                                    width: 1.sw,
                                    child: AppButton(
                                      color: AppTheme.primary,
                                      text: 'Create Account',
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder:
                                                (context) =>
                                                    RegistrationScreen(),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  SizedBox(height: 16.h), // Responsive spacing
                                  // Login Button
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () {
                                      // Navigate to login screen
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => LoginScreen(),
                                        ),
                                      );
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.all(16.w),
                                      child: Text(
                                        "Already Have an Account? Login",
                                        style: AppTheme.bodyLarge?.copyWith(
                                          fontSize:
                                              10.sp, // Responsive font size
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20.h), // Bottom spacing
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper method to build each onboarding page
  Widget _buildOnboardingPage({
    required String imageUrl,
    required String title,
    required String subtitle,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        // Image
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: CachedNetworkImage(
              fadeInDuration: Duration(milliseconds: 500),
              fadeOutDuration: Duration(milliseconds: 500),
              imageUrl: imageUrl,
              width: 1.sw,
              height: 0.4.sh, // 50% of screen height
              fit: BoxFit.cover,
              placeholder:
                  (context, url) => Container(
                    width: 1.sw,
                    height: 0.5.sh,
                    color: Colors.grey[300],
                    child: Center(
                      child: SizedBox(
                        width: 30.w,
                        height: 30.w,
                        child: CircularProgressIndicator(strokeWidth: 2.w),
                      ),
                    ),
                  ),
              errorWidget:
                  (context, url, error) => Container(
                    width: 1.sw,
                    height: 0.5.sh,
                    color: Colors.grey[300],
                    child: Icon(Icons.error, size: 40.sp),
                  ),
            ),
          ),
        ),
        // Text Content
        Padding(
          padding: EdgeInsets.fromLTRB(22.w, 20.h, 22.w, 0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Title
              Text(
                title,
                style: AppTheme.bodyLarge?.copyWith(
                  fontSize: 24.sp, // Responsive font size
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 12.h), // Responsive spacing
              // Subtitle
              Text(
                subtitle,
                style: AppTheme.bodyLarge?.copyWith(
                  fontSize: 16.sp, // Responsive font size
                  color: AppTheme.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
