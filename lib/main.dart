import 'package:duidku/cubit/add_report_cubit.dart';
import 'package:duidku/cubit/cashier_cubit.dart';
import 'package:duidku/cubit/filter_cubit.dart';
import 'package:duidku/cubit/home_cubit.dart';
import 'package:duidku/cubit/auth_cubit.dart';
import 'package:duidku/cubit/page_cubit.dart';
import 'package:duidku/cubit/product_cubit.dart';
import 'package:duidku/ui/add_report_page.dart';
import 'package:duidku/ui/cashier_page.dart';
import 'package:duidku/ui/detail_order_page.dart';
import 'package:duidku/ui/login_page.dart';
import 'package:duidku/ui/main_page.dart';
import 'package:duidku/ui/register_page.dart';
import 'package:duidku/ui/setting_page.dart';
import 'package:duidku/ui/report_detail_page.dart';
import 'package:duidku/ui/stock_detail_page.dart';
import 'package:duidku/ui/stock_opname_page.dart';
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
        BlocProvider(
          create: (context) => ReportCardIndexCubit(),
        ),
        BlocProvider(
          create: (context) => ProductCubit(),
        ),
        BlocProvider(
          create: (context) => AddReportCubit(),
        ),
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: GlobalMaterialLocalizations.delegates,
        supportedLocales: const [
          Locale('id', ''),
        ],
        title: "duitaja",
        home: const LoginPage(),
        onGenerateRoute: ((settings) {
          switch (settings.name) {
            case '/':
              return PageTransition(
                child: const LoginPage(),
                type: PageTransitionType.bottomToTop,
              );
            case '/register':
              return PageTransition(
                child: const RegisterPage(),
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
            case '/stock-page/stock-detail-page':
              return PageTransition(
                child: const StockDetailPage(),
                type: PageTransitionType.rightToLeft,
              );
            case '/main-page/stock-opname-page':
              return PageTransition(
                child: const StockOpnamePage(),
                type: PageTransitionType.rightToLeft,
              );
            case '/main-page/stock-opname-page/report-detail-page':
              return PageTransition(
                child: const ReportDetailPage(),
                type: PageTransitionType.rightToLeft,
              );
            case '/main-page/stock-opname-page/add-report-page':
              return PageTransition(
                child: const AddReportPage(),
                type: PageTransitionType.rightToLeft,
              );
            case '/main-page/profile-page':
              return PageTransition(
                child: const SettingPage(),
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
