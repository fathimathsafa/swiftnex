import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swiftnex/core/constants/app_theme.dart';
import 'package:swiftnex/core/constants/button.dart';
import 'package:swiftnex/presentation/verification_screen/widget/pincode_textfiled.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back_ios, color: AppTheme.textPrimary),
        ),
      ),
      key: scaffoldKey,
      backgroundColor: AppTheme.background,
      body: SafeArea(
        top: true,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(color: AppTheme.background),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  width: 130.0.w,
                                  height: 130.0.h,
                                  decoration: BoxDecoration(
                                    color: AppTheme.lightOrange,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Align(
                                    alignment: AlignmentDirectional(0.0, 0.0),
                                    child: Container(
                                      width: 90.0.w,
                                      height: 90.0.h,
                                      decoration: BoxDecoration(
                                        color: AppTheme.primary,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Align(
                                        alignment: AlignmentDirectional(
                                          0.0,
                                          0.0,
                                        ),
                                        child: Icon(
                                          Icons.mark_email_unread,
                                          color: AppTheme.background,
                                          size: 30.sp,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                24.w, // start - responsive width
                                0.0, // top
                                24.w, // end - responsive width
                                0.0, // bottom
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          " Verification Code",
                                          style: AppTheme.headingSmall,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20.h),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          "Please enter the code we have sent to your email",
                                          textAlign: TextAlign.center,
                                          style: AppTheme.bodySmall?.copyWith(
                                            color: AppTheme.iconColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 40.h),

                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                20.0.w,
                                0.0,
                                20.0.w,
                                0.0,
                              ),
                              child: SimplePinCodeTextField(
                                length: 6,
                                fieldHeight: 60.h,
                                fieldWidth: 50.w,
                                activeColor: Colors.green,
                                inactiveColor: Colors.grey.shade300,
                                selectedColor: Colors.green.shade300,
                                textStyle: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                            ),
                            SizedBox(height: 40.h),

                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                24.0.w,
                                20.0.h,
                                24.0.w,
                                0.0,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: AppButton(
                                      text: "Verify",
                                      onPressed: () {},
                                      color: AppTheme.primary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 40.h),

                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                24.w, // start - responsive width
                                0.0, // top
                                24.w, // end - responsive width
                                0.0, // bottom
                              ),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Verificcation code sent!',
                                        style: AppTheme.bodySmall?.copyWith(
                                          color: AppTheme.background,
                                        ),
                                      ),
                                      duration: Duration(milliseconds: 4000),
                                      backgroundColor: AppTheme.primary,
                                    ),
                                  );
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Flexible(
                                      child: RichText(
                                        textScaler:
                                            MediaQuery.of(context).textScaler,
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: " Didn't recceive the code? ",
                                              style: AppTheme.bodyMedium,
                                            ),
                                            TextSpan(
                                              text: " Resend",
                                              style: AppTheme.bodyMedium
                                                  ?.copyWith(
                                                    color: AppTheme.primary,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
