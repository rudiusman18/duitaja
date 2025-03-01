import 'package:duitaja/cubit/add_report_cubit.dart';
import 'package:duitaja/cubit/cashier_cubit.dart';
import 'package:duitaja/cubit/filter_cubit.dart';
import 'package:duitaja/cubit/home_cubit.dart';
import 'package:duitaja/cubit/auth_cubit.dart';
import 'package:duitaja/cubit/page_cubit.dart';
import 'package:duitaja/cubit/product_cubit.dart';
import 'package:duitaja/cubit/sale_cubit.dart';
import 'package:duitaja/cubit/stock_management_cubit.dart';
import 'package:duitaja/cubit/stock_opname_cubit.dart';
import 'package:duitaja/ui/add_report_page.dart';
import 'package:duitaja/ui/cashier_page.dart';
import 'package:duitaja/ui/detail_order_page.dart';
import 'package:duitaja/ui/login_page.dart';
import 'package:duitaja/ui/main_page.dart';
import 'package:duitaja/ui/payment_page.dart';
import 'package:duitaja/ui/payment_status_page.dart';
import 'package:duitaja/ui/register_page.dart';
import 'package:duitaja/ui/setting_page.dart';
import 'package:duitaja/ui/report_detail_page.dart';
import 'package:duitaja/ui/stock_detail_page.dart';
import 'package:duitaja/ui/stock_opname_page.dart';
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
        BlocProvider(
          create: (context) => ProductMenuCubit(),
        ),
        BlocProvider(
          create: (context) => CashierCubit(),
        ),
        BlocProvider(
          create: (context) => SaleCubit(),
        ),
        BlocProvider(
          create: (context) => DetailSaleCubit(),
        ),
        BlocProvider(
          create: (context) => RefundSaleCubit(),
        ),
        BlocProvider(
          create: (context) => StockManagementCubit(),
        ),
        BlocProvider(
          create: (context) => DetailStockManagementCubit(),
        ),
        BlocProvider(
          create: (context) => StockOpnameCubit(),
        ),
        BlocProvider(
          create: (context) => StockOpnameDetailCubit(),
        ),
        BlocProvider(
          create: (context) => StockOpnameAvailableItemCubit(),
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
            case '/main-page/payment-page':
              return PageTransition(
                child: const PaymentPage(),
                type: PageTransitionType.rightToLeft,
              );
            case '/main-page/payment-page/payment-status-page':
              return PageTransition(
                child: const PaymentStatusPage(),
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
