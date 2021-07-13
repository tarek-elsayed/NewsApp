import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:newsapp/shared/bloc_observer.dart';
import 'package:newsapp/shared/network/local/cache_helper.dart';
import 'package:newsapp/layout/news_app/cubit/cubit.dart';
import 'package:newsapp/layout/news_app/news_layout.dart';


import 'package:newsapp/shared/cubit/cubit.dart';
import 'package:newsapp/shared/cubit/states.dart';
import 'package:newsapp/shared/network/local/cache_helper.dart';
import 'package:newsapp/shared/network/remote/dio_helper.dart';


import 'package:newsapp/shared/bloc_observer.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  bool isDark = CacheHelper.getData(key: "isDark");

  runApp(MyApp(isDark));
}

class MyApp extends StatelessWidget {
  final bool isDark;

  MyApp(this.isDark);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NewsCubit()
            ..getBusiness()
            ..getScience()
            ..getSports(),
        ),
        BlocProvider(
          create: (context) => AppCubit()
            ..changeAppMode(
              fromShared: isDark,
            ),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            themeMode:
            AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            theme: ThemeData(
              scaffoldBackgroundColor: Colors.white,
              primarySwatch: Colors.deepOrange,
              appBarTheme: AppBarTheme(
                titleSpacing: 20.0,
                elevation: 0,
                backwardsCompatibility: false,
                systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.white,
                    statusBarIconBrightness: Brightness.dark),
                backgroundColor: Colors.white,
                titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                iconTheme: IconThemeData(color: Colors.black),
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                selectedItemColor: Colors.deepOrange,
                elevation: 20.0,
                type: BottomNavigationBarType.fixed,
              ),
              textTheme: TextTheme(
                bodyText1: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
            ),
            darkTheme: ThemeData(
              primarySwatch: Colors.deepOrange,
              scaffoldBackgroundColor: HexColor('333739'),
              appBarTheme: AppBarTheme(
                titleSpacing: 20.0,
                backwardsCompatibility: false,
                systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: HexColor('333739'),
                    statusBarIconBrightness: Brightness.light),
                backgroundColor: HexColor('333739'),
                titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                iconTheme: IconThemeData(color: Colors.white),
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  selectedItemColor: Colors.deepOrange,
                  unselectedItemColor: Colors.white30,
                  elevation: 20.0,
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: HexColor('333739')),
              textTheme: TextTheme(
                bodyText1: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
            ),
            debugShowCheckedModeBanner: false,
            home: NewLayout(),
          );
        },
      ),
    );
  }
}
