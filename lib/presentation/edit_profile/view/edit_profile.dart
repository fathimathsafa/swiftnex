import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swiftnex/core/constants/app_theme.dart';

class EditProfileWidget extends StatefulWidget {
  const EditProfileWidget({super.key});

  static String routeName = 'EditProfile';
  static String routePath = '/editProfile';

  @override
  State<EditProfileWidget> createState() => _EditProfileWidgetState();
}

class _EditProfileWidgetState extends State<EditProfileWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: AppTheme.background,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
          centerTitle: true,
          title: Text("Edit Profile", style: AppTheme.bodySmall),
        ),
        body: SafeArea(
          top: true,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.only(bottom: 24.0),
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(color: AppTheme.surface),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 100.w,
                                      height: 100.h,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: CachedNetworkImage(
                                        fadeInDuration: Duration(
                                          milliseconds: 500,
                                        ),
                                        fadeOutDuration: Duration(
                                          milliseconds: 500,
                                        ),
                                        imageUrl:
                                            'https://images.unsplash.com/photo-1599566150163-29194dcaad36?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwzfHxhdmF0YXJ8ZW58MHx8fHwxNjk3OTY2NTQyfDA&ixlib=rb-4.0.3&q=80&w=400',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20.h),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 24.0,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Username",
                                        style: AppTheme.bodyMedium,
                                      ),
                                      SizedBox(height: 8.h),
                                      TextFormField(
                                        autofocus: false,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelStyle: AppTheme.bodySmall,
                                          hintText: "Create your username",
                                          hintStyle: AppTheme.bodySmall,
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: AppTheme.background,
                                              width: 1.0,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              16.0,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: AppTheme.background,
                                              width: 1.0,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              16.0,
                                            ),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: AppTheme.warning,
                                              width: 1.0,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              16.0,
                                            ),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: AppTheme.warning,
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(16.0),
                                              ),
                                          filled: true,
                                          fillColor: AppTheme.fillColor,
                                          prefixIcon: Icon(
                                            Icons.person,
                                            color: AppTheme.primary,
                                            size: 24.sp,
                                          ),
                                        ),
                                        style: AppTheme.bodyMedium,
                                      ),
                                      SizedBox(height: 16.h),
                                      Text(
                                        "Email or Phone Number",
                                        style: AppTheme.bodyMedium,
                                      ),
                                      SizedBox(height: 8.h),
                                      TextFormField(
                                        autofocus: false,
                                        autofillHints: [AutofillHints.email],
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelStyle: AppTheme.bodyMedium,
                                          hintText:
                                              "Enter your email or phone number...",
                                          hintStyle: AppTheme.bodySmall,
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: AppTheme.background,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              16.0,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: AppTheme.background,
                                              width: 1.0,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              16.0,
                                            ),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: AppTheme.warning,
                                              width: 1.0,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              16.0,
                                            ),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: AppTheme.warning,
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(16.0),
                                              ),
                                          filled: true,
                                          fillColor: AppTheme.fillColor,
                                          contentPadding:
                                              EdgeInsetsDirectional.only(
                                                start: 8.0,
                                              ),
                                          prefixIcon: Icon(
                                            Icons.email_outlined,
                                            color: AppTheme.primary,
                                            size: 24.sp,
                                          ),
                                        ),
                                        style: AppTheme.bodyMedium,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 24.h),
                              ],
                            ),
                          ),
                        ),
                        MaterialButton(
                          onPressed: () {
                            print('Save Changes pressed');
                          },
                          color: AppTheme.primary,
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: 12.h,
                            horizontal: 24.w,
                          ),
                          child: Text(
                            'Save Changes',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                            ),
                          ),
                        ),
                        SizedBox(height: 16.h),
                      ],
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
