import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:recruitment_solutionexplorer/core/theme/app_theme.dart';
import 'package:talker_riverpod_logger/talker_riverpod_logger.dart';

import 'features/home/presentation/home_page.dart';

void main() {
  runApp(
    ProviderScope(
      observers: [TalkerRiverpodObserver()],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812), // Standard iPhone X design size
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'Text Assistant',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          home: const HomePage(),
        );
      },
    );
  }
}
