import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:swiftnex/core/constants/app_theme.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 16.0,
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(24.0, 44.0, 24.0, 0.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Top Section
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text("FoodCort Menu", style: AppTheme.bodyMedium),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildMenuRow(
                  icon: Icons.discount_rounded,
                  label: "Voucher",
                  badgeCount: "2",
                  badgeColor: AppTheme.primary,
                ),
                _buildMenuRow(
                  icon: Icons.message,
                  label: "Chat",
                  badgeCount: "23",
                  badgeColor: AppTheme.primary,
                ),
                _buildMenuRow(
                  icon: Icons.history,
                  label: "History",
                  badgeCount: "14",
                  badgeColor: AppTheme.background,
                ),
                _buildMenuRow(
                  icon: Icons.settings,
                  label: "Settings",
                  badgeCount: "1",
                  badgeColor: AppTheme.background,
                ),
              ],
            ),

            // Bottom Section
            Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 40.w,
                      height: 40.h,
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                      child: CachedNetworkImage(
                        imageUrl:
                            'https://images.unsplash.com/photo-1494790108377-be9c29b29330?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwzfHx1c2VyfGVufDB8fHx8MTY5MzI1MTcyMHww&ixlib=rb-4.0.3&q=80&w=1080',
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Magdalena Succrose", style: AppTheme.bodySmall),
                        Text("Good Morning", style: AppTheme.bodySmall),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _buildActionItem(
                  icon: Icons.question_mark,
                  label: "Help",
                  iconBg: AppTheme.textSecondary,
                  iconColor: AppTheme.textPrimary,
                ),
                const SizedBox(height: 10),
                _buildActionItem(
                  icon: Icons.logout,
                  label: "Logout",
                  iconBg: AppTheme.surface,
                  iconColor: AppTheme.primary,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuRow({
    required IconData icon,
    required String label,
    required String badgeCount,
    required Color badgeColor,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(children: [
            Icon(icon),
            const SizedBox(width: 6),
            Text(label, style: AppTheme.bodySmall),
          ]),
          Container(
            decoration: BoxDecoration(
              color: badgeColor,
              borderRadius: BorderRadius.circular(30.0.r),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
            child: Text(badgeCount, style: AppTheme.bodySmall),
          ),
        ],
      ),
    );
  }

  Widget _buildActionItem({
    required IconData icon,
    required String label,
    required Color iconBg,
    required Color iconColor,
  }) {
    return Row(
      children: [
        Container(
          width: 32.w,
          height: 32.h,
          decoration: BoxDecoration(
            color: iconBg,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Icon(icon, color: iconColor, size: 20.sp),
        ),
        const SizedBox(width: 8),
        Text(label, style: AppTheme.bodySmall),
      ],
    );
  }
}
