import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/image_manager.dart';
import '../../../home/data/models/surah_model.dart';

class AyatScreen extends StatefulWidget {
  final SurahModel surah;
  const AyatScreen({super.key, required this.surah});

  @override
  State<AyatScreen> createState() => _AyatScreenState();
}

class _AyatScreenState extends State<AyatScreen> {

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 80.h,
          ),
          Container(
            width: 370.w,
            height: 250.h,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  AppColors.searchIcon,
                  AppColors.secondaryColor,
                ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                borderRadius: BorderRadius.circular(20)),
            child: Row(
              children: [
                Image.asset(
                  ImageManager.logo,
                  height: 250.h,
                  width: 190.w,
                ),
                Padding(
                  padding: EdgeInsets.all(8.0.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.surah.name,
                        style: const TextStyle(
                            fontSize: 21,
                            fontFamily: AppStrings.fontFamily,
                            color: Colors.white,
                            fontWeight: FontWeight.w700),
                      ),
                      const Text(
                        "The Opening",
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: AppStrings.fontFamily,
                            color: Colors.white),
                      ),
                      Text(
                        widget.surah.revelationType,
                        style: const TextStyle(
                            fontSize: 20,
                            fontFamily: AppStrings.fontFamily,
                            color: Colors.white),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.surah.ayahs.length,
              itemBuilder: (context, index) {
                final ayah = widget.surah.ayahs[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Container(
                      height: 50.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Color.fromARGB(255, 40, 61, 108),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 18.0),
                            child: Container(
                              height: 40.h,
                              width: 40.w,
                              decoration: BoxDecoration(
                                  color: AppColors.searchIcon,
                                  borderRadius: BorderRadius.circular(25)),
                              child: Center(
                                child: Text(
                                  "${ayah.numberInSurah}",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    fontSize: 15,
                                    //fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Spacer(),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.share,
                                color: AppColors.searchIcon,
                                size: 25,
                              )),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.bookmark_border,
                                color: AppColors.searchIcon,
                                size: 27,
                              )),
                        ],
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: Text(
                        "${ayah.text}",
                        textDirection: TextDirection.rtl,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
