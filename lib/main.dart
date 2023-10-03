import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newtodoapp/shared/bloc_observer.dart';
import 'package:newtodoapp/shared/styles/themes.dart';
import 'package:newtodoapp/view/home_screen.dart';
import 'package:page_transition/page_transition.dart';

import 'controller/cubit/cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(EasyLocalization(
      supportedLocales: const [Locale('en', 'US'), Locale('ar', 'EG')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en', 'US'),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Bloc.observer = MyBlocObserver();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context) => TodoCubit()..createDataBase()),
      ],
      child: MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        title: 'Flutter Demo',
        theme: lightTheme,
        darkTheme: darkTheme,
        debugShowCheckedModeBanner: false,
        home: AnimatedSplashScreen(
          splash: Image.asset(
            'assets/images/todo_app.jpg',
            fit: BoxFit.cover,
          ),
          nextScreen: const HomeScreen(),
          splashIconSize: 450,
          splashTransition: SplashTransition.fadeTransition,
          pageTransitionType: PageTransitionType.fade,
          backgroundColor: Colors.grey,
          duration: 1000,
        ),
      ),
    );
  }
}
