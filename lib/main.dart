import 'package:duidku/cubit/cashier_cubit.dart';
import 'package:duidku/cubit/filter_cubit.dart';
import 'package:duidku/cubit/page_cubit.dart';
import 'package:duidku/ui/cashier_page.dart';
import 'package:duidku/ui/detail_order_page.dart';
import 'package:duidku/ui/login_page.dart';
import 'package:duidku/ui/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp, // Portrait mode
    DeviceOrientation.portraitDown, // Upside-down portrait mode
  ]);
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
        ),
        BlocProvider(
          create: (context) => IndexCashierFilterCubit(),
        ),
        BlocProvider(
          create: (context) => ProductCartCubit(),
        ),
        BlocProvider(
          create: (context) => FilterCubit(),
        ),
        BlocProvider(
          create: (context) => PreviousPageCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: GlobalMaterialLocalizations.delegates,
        supportedLocales: const [
          Locale('id', ''),
        ],
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
                type: PageTransitionType.fade,
              );
            case '/main-page/cashier-page':
              return PageTransition(
                child: const CashierPage(),
                type: PageTransitionType.rightToLeft,
              );
            case '/main-page/cashier-page/detail-order-page':
              return PageTransition(
                child: const DetailOrderPage(),
                type: PageTransitionType.rightToLeft,
              );
            default:
              return null;
          }
        }),
      ),
    );
  }
}
