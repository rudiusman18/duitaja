import 'package:duidku/cubit/page_cubit.dart';
import 'package:duidku/ui/login_page.dart';
import 'package:duidku/ui/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PageCubit(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "duitku",
        home: const LoginPage(),
        onGenerateRoute: ((settings) {
          switch (settings.name) {
            case '/':
              return PageTransition(
                child: const LoginPage(),
                type: PageTransitionType.bottomToTop,
              );
            case '/main-page':
              return PageTransition(
                child: const MainPage(),
                type: PageTransitionType.bottomToTop,
              );
            default:
              return null;
          }
        }),
      ),
    );
  }
}
