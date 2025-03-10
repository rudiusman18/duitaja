import 'dart:developer';

import 'package:duitaja/cubit/auth_cubit.dart';
import 'package:duitaja/cubit/cashier_cubit.dart';
import 'package:duitaja/cubit/sale_cubit.dart';
import 'package:duitaja/shared/sale_detail_page.dart';
import 'package:duitaja/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentStatusPage extends StatefulWidget {
  const PaymentStatusPage({super.key});

  @override
  State<PaymentStatusPage> createState() => _PaymentStatusPageState();
}

class _PaymentStatusPageState extends State<PaymentStatusPage> {
  @override
  void initState() {
    context.read<SaleCubit>().allSalesHistory(
        token: context.read<AuthCubit>().token ?? "",
        page: "1",
        limit: "1",
        status: '',
        startDate: '',
        endDate: '',
        search: "",
        inStatus: 'active');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SaleCubit, SaleState>(
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async {
            Navigator.pop(context);
            Navigator.pushReplacementNamed(context, "/main-page/cashier-page");
            return true;
          },
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: primaryColor,
              title: Text(
                "Pembayaran",
                style: inter.copyWith(
                  fontWeight: medium,
                  fontSize: 20,
                ),
              ),
              leading: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushReplacementNamed(
                      context, "/main-page/cashier-page");
                },
                child: const Icon(
                  Icons.chevron_left,
                  size: 24,
                ),
              ),
              centerTitle: true,
            ),
            body: state is SaleSuccess
                ? Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 20,
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Pembayaran Selesai",
                          style: inter.copyWith(
                            fontWeight: semiBold,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Expanded(
                          child: ListView(
                            children: [
                              SaleDetailPage(
                                saleId:
                                    state.saleHistoryModel.payload?.first.id ??
                                        "",
                                paymentStatus: true,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 60,
                                ),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: primaryColor,
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.pushReplacementNamed(
                                        context, "/main-page/cashier-page");
                                  },
                                  child: Text(
                                    "Tutup",
                                    style: inter,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                : const SizedBox(),
          ),
        );
      },
    );
  }
}
