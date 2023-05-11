import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shopapp/controllers/cubit/news_cubit.dart';
import 'package:shopapp/layouts/news_layout.dart';
import 'package:shopapp/shared/local/cahce_helper.dart';
import 'package:shopapp/shared/network/dio_helper.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  bool? isDark = CacheHelper.getBoolean(key: 'isDark');
  runApp(MyApp(isDark: isDark,));
}

class MyApp extends StatelessWidget {
   MyApp({super.key,required this.isDark});
  bool? isDark;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<NewsCubit>(
      create: (context) => NewsCubit()..getScienceData()..changeAppMode(fromCache: isDark),
      child: BlocConsumer<NewsCubit,NewsState>(
        listener: (context,state) {
          if(state is NewsChangeMode)
          print(NewsCubit.get(context).isDark);
        },
        builder:(context,state) => MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              textTheme: TextTheme(
                bodyText1: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 16.0,
                ),
              ),
              primarySwatch: Colors.deepOrange,
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
              ),
              appBarTheme: AppBarTheme(
                elevation: 0,
                iconTheme: IconThemeData(color: Colors.black),
                titleTextStyle: TextStyle(
                    color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                backgroundColor: Colors.white,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.black,
                ),
              ),
              scaffoldBackgroundColor: Colors.white,
            ),
            darkTheme: ThemeData(
              primarySwatch: Colors.deepOrange,
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: HexColor('333739'),
                  unselectedItemColor: Colors.grey),
              appBarTheme: AppBarTheme(
                elevation: 0,
                iconTheme: IconThemeData(
                  color: Colors.white,
                ),
                titleTextStyle: TextStyle(
                    color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                backgroundColor: HexColor('333739'),
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                ),
              ),
              scaffoldBackgroundColor: HexColor('333739'),
              textTheme: TextTheme(
                bodyText1: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16.0,
                ),
              ),
            ),
            themeMode: NewsCubit.get(context).isDark? ThemeMode.dark : ThemeMode.light,
            home: NewsLayout()) ,
      ),
    );
  }
}
