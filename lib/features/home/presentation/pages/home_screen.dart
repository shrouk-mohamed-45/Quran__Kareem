import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran_kareem/app.dart';
import 'package:quran_kareem/core/utils/app_colors.dart';
import 'package:quran_kareem/core/utils/image_manager.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../config/app_routes.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../get_ayat/presentation/pages/ayat_screen.dart';
import '../cubit/home_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          //Color.fromARGB(255, 36, 54, 97),
          AppColors.secondaryColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.secondaryColor,
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
                color: AppColors.searchIcon,
                size: 32,
              ))
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 17.0),
            child: Image.asset(
              ImageManager.logo,
              height: 250.h,
              width: 400.w,
            ),
          ),
          Container(
            height: 200.h,
            width: 400.w,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                AppColors.searchIcon,
                AppColors.secondaryColor,
                // AppColors.searchIcon,
                // AppColors.containerMidColor,
                // AppColors.containerColor,
                // AppColors.containerColor,
              ], begin: Alignment.topLeft, end: Alignment.bottomRight),
              borderRadius: BorderRadius.circular(25),
              //color: Colors.white
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  AppStrings.app,
                  style: TextStyle(
                    fontFamily: AppStrings.fontFamily,
                    color: Colors.white,
                    fontSize: 26,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      ImageManager.lastReadIcon,
                      height: 55.h,
                      width: 45.w,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Text(
                      AppStrings.lastRead,
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: AppStrings.fontFamily,
                          color: Colors.white),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 14.0, right: 9, bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text(
                            "Al-Fatiha",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 21,
                              fontFamily: AppStrings.fontFamily,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "Ayah : 1",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontFamily: AppStrings.fontFamily,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      Icon(
                        Icons.bookmark_rounded,
                        color: Colors.white,
                        size: 35,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                if (state is QuranLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is QuranFailure) {
                  print(state.message);
                  return Center(
                    child: Text(state.message),
                  );
                } else if (state is QuranLoaded) {
                  final sure = state.surahs;

                  return ListView.separated(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      itemCount: sure.length,
                      separatorBuilder: (context, index) => Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 18.0),
                            child: Divider(color: AppColors.searchIcon),
                          ),
                      itemBuilder: (context, index) {
                        final surah = sure[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              Routes.ayatScreen,
                              arguments: surah,
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 12),
                            child: Row(
                              children: [
                                Image.asset(
                                  ImageManager.separatorIcon,
                                  height: 60.h,
                                  width: 60.w,
                                ),
                                SizedBox(width: 12.h),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      surah.englishName,
                                      style: TextStyle(
                                        color: AppColors.searchIcon,
                                        fontFamily: AppStrings.fontFamily,
                                        fontSize: 20,
                                      ),
                                    ),
                                    Text(
                                      "${surah.revelationType} ",
                                      //"- ${surah.number} verses",
                                      style: TextStyle(
                                        color: AppColors.searchIcon,
                                        fontFamily: AppStrings.fontFamily,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Text(
                                  surah.name,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: AppStrings.fontFamily,
                                    color: AppColors.searchIcon,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                } else {
                  return const SizedBox();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
