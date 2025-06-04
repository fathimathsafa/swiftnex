import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swiftnex/core/constants/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:swiftnex/core/constants/auth_controller.dart';
import 'package:swiftnex/core/constants/button.dart';
import 'package:swiftnex/presentation/bottom_navigation_screen/view/bottom_navigation_screen.dart';
import 'package:swiftnex/presentation/login_screen/view/login_screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  // Remove model dependency - use controllers directly
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Focus nodes for managing focus
  final FocusNode userNameFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  // Form key for validation
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Password visibility toggle
  bool passwordVisible = false;
  bool _isLoading = false;
    final AuthController _authController = AuthController();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    // Clean up controllers and focus nodes
    userNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    userNameFocusNode.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  // Validation functions
  String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a username';
    }
    if (value.length < 3) {
      return 'Username must be at least 3 characters';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  // Handle form submission
  void handleCreateAccount() {
    if (formKey.currentState!.validate()) {
      // Process registration
      print('Username: ${userNameController.text}');
      print('Email: ${emailController.text}');
      print('Password: ${passwordController.text}');

      // TODO: Add your registration logic here
      // For example: call API, navigate to next screen, etc.

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Account created successfully!'),
          backgroundColor: AppTheme.primary,
        ),
      );

      // Navigate to next screen
      Navigator.pushNamed(context, '/login');
    }
  }
 Future<void> _register() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      final user = await _authController.registerWithEmailAndPassword(
        emailController.text.trim(),
        passwordController.text,
      );

      setState(() {
        _isLoading = false;
      });

      if (user != null) {
        // Navigate to login screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      backgroundColor: AppTheme.background,
      body: SafeArea(
        top: true,
        child: Container(
          width: 1.sw, // Full screen width
          height: 1.sh, // Full screen height
          child: Stack(
            children: [
              Container(
                width: 1.sw,
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
                            // Header Section
                            Padding(
                              padding: EdgeInsets.all(14.w),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Create Account",
                                    style: AppTheme.headingSmall,
                                  ),
                                  SizedBox(height: 8.h),
                                  Text(
                                    "Start learning with create your account",
                                    style: AppTheme.bodyMedium,
                                  ),
                                ],
                              ),
                            ),
    
                            // Form Section
                            Form(
                              key: formKey,
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  // Username Field
                                  _buildInputField(
                                    label: "Username",
                                    hint: "Create your username",
                                    controller: userNameController,
                                    focusNode: userNameFocusNode,
                                    validator: validateUsername,
                                    prefixIcon: Icons.person_outline,
                                  ),
    
                                  SizedBox(height: 20.h),
    
                                  // Email Field
                                  _buildInputField(
                                    label: "Email or Phone Number",
                                    hint: "Enter your email or phone number",
                                    controller: emailController,
                                    focusNode: emailFocusNode,
                                    validator: validateEmail,
                                    prefixIcon: Icons.email_outlined,
                                    keyboardType: TextInputType.emailAddress,
                                    autofillHints: [AutofillHints.email],
                                  ),
    
                                  SizedBox(height: 20.h),
    
                                  // Password Field
                                  _buildInputField(
                                    label: "Password",
                                    hint: "Create your password",
                                    controller: passwordController,
                                    focusNode: passwordFocusNode,
                                    validator: validatePassword,
                                    prefixIcon: Icons.lock_outlined,
                                    obscureText: !passwordVisible,
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        passwordVisible
                                            ? Icons.visibility_outlined
                                            : Icons.visibility_off_outlined,
                                        color: AppTheme.iconColor,
                                        size: 15.sp,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          passwordVisible = !passwordVisible;
                                        });
                                      },
                                    ),
                                    autofillHints: [AutofillHints.password],
                                  ),
                                ],
                              ),
                            ),
    
                            SizedBox(height: 40.h),
    
                            // Create Account Button
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 24.w),
                              child: AppButton(
                                text: "Create Account",
                                onPressed: _isLoading ? null : _register,
                                color: AppTheme.primary,
                              ),
                            ),
    
                            SizedBox(height: 24.h),
    
                            // Login Link
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 24.w),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) => LoginScreen(),
                                    ),
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Have an account? ",
                                      style: AppTheme.bodyMedium?.copyWith(
                                        color: AppTheme.textPrimary,
                                      ),
                                    ),
                                    Text(
                                      "Login",
                                      style: AppTheme.bodyMedium?.copyWith(
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
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build input fields
  Widget _buildInputField({
    required String label,
    required String hint,
    required TextEditingController controller,
    required FocusNode focusNode,
    required String? Function(String?) validator,
    required IconData prefixIcon,
    bool obscureText = false,
    Widget? suffixIcon,
    TextInputType? keyboardType,
    List<String>? autofillHints,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTheme.bodyMedium?.copyWith(color: AppTheme.textPrimary),
          ),
          SizedBox(height: 8.h),
          TextFormField(
            controller: controller,
            focusNode: focusNode,
            autofocus: false,
            obscureText: obscureText,
            keyboardType: keyboardType,
            autofillHints: autofillHints,
            validator: validator,
            style: AppTheme.bodyMedium?.copyWith(),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: AppTheme.bodyMedium?.copyWith(),
              prefixIcon: Icon(
                prefixIcon,
                color: AppTheme.primary,
                size: 15.sp,
              ),
              suffixIcon: suffixIcon,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppTheme.iconColor, width: 1.5.w),
                borderRadius: BorderRadius.circular(16.r),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppTheme.primary, width: 2.w),
                borderRadius: BorderRadius.circular(16.r),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 1.5.w),
                borderRadius: BorderRadius.circular(16.r),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 2.w),
                borderRadius: BorderRadius.circular(16.r),
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 16.h,
              ),
              errorStyle: TextStyle(fontSize: 12.sp, color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
