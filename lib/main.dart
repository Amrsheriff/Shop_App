

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async{
    WidgetsFlutterBinding.ensureInitialized();

    Bloc.observer = MyBlocObserver();
    DioHelper.init();
    await CacheHelper.init();

    bool isDark = CacheHelper.getData(key: 'isDark') == true;

    Widget widget;

    bool onBoarding = CacheHelper.getData(key: 'onBoarding') ==true;

    token = CacheHelper.getData(key: 'token');
    print(token);

    if(onBoarding == true)
    {
      if(token!= null) widget = ShopLayout();
      else widget = ShopLoginScreen();
    }else
      {
        widget = OnBoardingScreen();
      }


    runApp(MyApp(
      isDark: isDark,
      startWidget: widget,
    ));
}

class MyApp extends StatelessWidget
{
  final bool isDark;
  final Widget startWidget;

  MyApp({
    required this.isDark,
    required this.startWidget
  });

  @override
  Widget build(BuildContext context) {


    // return BlocProvider(
    //   create: (BuildContext context) => NewsCubit(),
    //   //   ..getBusiness()..changeAppMode(
    //   //     fromShared: isDark
    //   // ),
    //       child: BlocConsumer<NewsCubit, NewsStates>(
    //               listener: (context, state) {},
    //               builder: (context, state){
    //                 return MaterialApp(
    //                   debugShowCheckedModeBanner: false,
    //                   theme: lightTheme,
    //                   darkTheme: darkTheme,
    //                   themeMode: NewsCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
    //                   home: startWidget,
    //                 );
    //               },
    //       ),
    // );

    // return MultiBlocProvider(
    //   providers: [
    //     BlocProvider(create: (BuildContext context) => AppCubit()),
    //     BlocProvider (create: (BuildContext context)=> ShopLoginCubit()),
    //     BlocProvider(
    //     create: (BuildContext context) => ShopCubit()..getHomeData()..getCategories()..getFavorites()..getUserData(),
    //     )
    //   ],
    //     child: BlocConsumer<AppCubit, AppStates>(
    //       listener: (context, state){} ,
    //       builder: (context, state){
    //         return MaterialApp(
    //          debugShowCheckedModeBanner: false,
    //          theme: lightTheme,
    //           darkTheme: darkTheme,
    //          themeMode: ThemeMode.light,
    //          //themeMode: NewsCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
    //            home: startWidget,
    //         );
    //         },
    //     ),
    //   );
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.light,
        //themeMode: NewsCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
        home: startWidget,
    );
  }

}


