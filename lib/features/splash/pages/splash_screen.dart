import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran_kareem/core/utils/app_strings.dart';
import 'package:quran_kareem/core/utils/image_manager.dart';
import '../../../config/app_routes.dart';
import '../../../core/utils/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(minutes: 1), (){
      Navigator.pushReplacementNamed(
          context,
          Routes.homeScreen,
      );
    }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [
            AppColors.searchIcon,
            AppColors.secondaryColor,
            AppColors.secondaryColor,
            // AppColors.primaryColor,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              ImageManager.splashImage,
              height: 300.h,
              width: 300.w,
            ),
             const Text(
              AppStrings.appNameArabic,
              // AppStrings.appNameEnglish,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 38,
                  fontWeight: FontWeight.w500,
                  fontFamily: AppStrings.fontFamily),
            ),
          ],
        ),
      ),
    );
  }
}
