import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swiftnex/core/constants/app_theme.dart';
import 'package:swiftnex/presentation/chnage_password_screen/view/change_password_screen.dart';
import 'package:swiftnex/presentation/edit_profile/view/edit_profile.dart';
import 'package:swiftnex/presentation/onboarding_screen/view/onboarding_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F5F7),
        centerTitle: true,
        title: Text('Settings', style: AppTheme.bodyMedium),
      ),
      backgroundColor: const Color(0xFFF5F5F7),
      body: SafeArea(
        child: Column(
          children: [
            // Main content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(10.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // General Section
                    Text('General', style: AppTheme.headingSmall),
                    SizedBox(height: 12.h),

                    // General Settings Items
                    _buildSettingsItem(
                      icon: Icons.person_outline,
                      title: 'Edit Profile',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditProfileWidget(),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 8.h),
                    _buildSettingsItem(
                      icon: Icons.lock_outline,
                      title: 'Change Password',
                      onTap: () {Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChangePasswordScreen(),
                          ),
                        );},
                    ),
                    // SizedBox(height: 8.h),
                    // _buildSettingsItem(
                    //   icon: Icons.notifications_none,
                    //   title: 'Notifications',
                    //   onTap: () {},
                    // ),
                    // SizedBox(height: 8.h),
                    // _buildSettingsItem(
                    //   icon: Icons.notifications_active_outlined,
                    //   title: 'Notification Setting',
                    //   onTap: () {},
                    // ),
                    // SizedBox(height: 8.h),
                    // _buildSettingsItem(
                    //   icon: Icons.security_outlined,
                    //   title: 'Security',
                    //   onTap: () {},
                    // ),
                    // SizedBox(height: 8.h),
                    // _buildSettingsItem(
                    //   icon: Icons.language_outlined,
                    //   title: 'Language',
                    //   onTap: () {},
                    // ),
                    SizedBox(height: 8.h),

                    _buildSettingsItem(
                      icon: Icons.logout,
                      title: 'Log Out',
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OnboardingWidget(),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8.r,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12.r),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Row(
              children: [
                Icon(icon, size: 22.sp, color: AppTheme.textPrimary),
                SizedBox(width: 16.w),
                Expanded(child: Text(title, style: AppTheme.bodyLarge)),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16.sp,
                  color: Colors.grey.shade600,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
