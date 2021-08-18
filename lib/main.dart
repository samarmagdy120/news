import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app/shared/cubit/bloc_observer.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';
import 'package:news_app/shared/networks/local/CacheHelper.dart';
import 'package:news_app/shared/networks/remote/dio_helper.dart';
import 'package:news_app/shared/styles/themes.dart';

import 'layouts/HomeLayout.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();

  bool? isDark = CacheHelper.getData(key: "isDark");
  Bloc.observer = MyBlocObserver();
  runApp(MyApp(isDark));

}

class MyApp extends StatelessWidget {

  final bool? isDark;
  MyApp(this.isDark);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers:
      [
        BlocProvider(
          create: (BuildContext context) => NewsCubit()..getBusiness()

        ),
        BlocProvider(
          create: (BuildContext context) => NewsCubit()..changeAppMode(fromShared: isDark,),
        ),
      ],
      child: BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: lightTheme,
              darkTheme: darkTheme,
              // to toggle between two theme
              themeMode: NewsCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
              home: Directionality(
                  textDirection: TextDirection.rtl, child: HomeLayout()));
        },
      ),
    );
  }
}
