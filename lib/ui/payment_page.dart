import 'package:duitaja/cubit/auth_cubit.dart';
import 'package:duitaja/cubit/cashier_cubit.dart';
import 'package:duitaja/model/order_model.dart';
import 'package:duitaja/shared/loading.dart';
import 'package:duitaja/shared/modal_alert.dart';
import 'package:duitaja/shared/theme.dart';
import 'package:duitaja/shared/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  OrderModel orderModel = OrderModel();
  TextEditingController paymenttextField = TextEditingController(text: '');

  @override
  void initState() {
    orderModel = context.read<CashierCubit>().orderModel;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget templateFraction({required List<int> nominal}) {
      return Column(
        children: [
          for (var index = 0; index < 3; index++) ...{
            index == 0
                ? const SizedBox()
                : const SizedBox(
                    height: 20,
                  ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      var newPaymentvalue = int.parse(
                              paymenttextField.text == ''
                                  ? '0'
                                  : paymenttextField.text) +
                          nominal[index == 0 ? index : index + 1];
                      paymenttextField.text = "$newPaymentvalue";
                    });
                  },
                  child: Container(
                    width: 130,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: greyColor400,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: greyColor1,
                          offset: const Offset(
                            3,
                            3,
                          ),
                        ),
                      ],
                    ),
                    child: Text(
                      formatCurrency(nominal[index == 0 ? index : index + 1]),
                      style: inter.copyWith(
                        fontWeight: semiBold,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      var newPaymentvalue = int.parse(
                              paymenttextField.text == ''
                                  ? '0'
                                  : paymenttextField.text) +
                          nominal[index + 1 == 1 ? index + 1 : index + 3];
                      paymenttextField.text = "$newPaymentvalue";
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                    width: 130,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: greyColor400,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: greyColor1,
                          offset: const Offset(
                            3,
                            3,
                          ),
                        ),
                      ],
                    ),
                    child: Text(
                      formatCurrency(
                          nominal[index + 1 == 1 ? index + 1 : index + 3]),
                      style: inter.copyWith(
                        fontWeight: semiBold,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            )
          }
        ],
      );
    }

    return BlocConsumer<CashierCubit, CashierState>(
      listener: (context, state) {
        if (state is CashierTokenExpired) {
          Navigator.pop(context);
          context.read<AuthCubit>().logout();
          Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
        }

        if (state is CashierOrderSuccess) {
          Navigator.pop(context);
          context.read<ProductCartCubit>().resetProduct();
          Navigator.popAndPushNamed(
              context, '/main-page/payment-page/payment-status-page');
        }

        if (state is CashierOrderFailure) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.error,
                style: inter,
              ),
              backgroundColor: Colors.red,
              duration: const Duration(
                seconds: 5,
              ),
            ),
          );
        }

        if (state is CashierOrderLoading) {
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) {
                return const Loading();
              });
        }
      },
      builder: (context, state) {
        return Scaffold(
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
              },
              child: const Icon(
                Icons.chevron_left,
                size: 24,
              ),
            ),
            centerTitle: true,
          ),
          body: Container(
            margin: const EdgeInsets.only(
              top: 40,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 40,
              ),
              child: ListView(
                children: [
                  Center(
                    child: Text(
                      'Total Pembelian',
                      style: inter.copyWith(
                        fontSize: 20,
                        fontWeight: semiBold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Center(
                    child: Text(
                      formatCurrency(int.parse(
                          "${(orderModel.subTotal ?? 0) + (orderModel.tax ?? 0)}")),
                      style: inter.copyWith(
                        fontSize: 20,
                        color: primaryColor,
                        fontWeight: semiBold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  TextFormField(
                    controller: paymenttextField,
                    keyboardType: TextInputType.number,
                    cursorColor: primaryColor,
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: primaryColor,
                            width: 2), // Border color when focused
                      ),
                      labelText: "Masukkan Nominal",
                      labelStyle: inter,
                      floatingLabelStyle: inter.copyWith(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Text(
                    "Pilih Pecahan",
                    style: inter,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  templateFraction(
                    nominal: [
                      5000,
                      10000,
                      20000,
                      50000,
                      75000,
                      100000,
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: ((context) {
                                  return ModalAlert(
                                      title: '',
                                      message:
                                          "Apakah nominal yang telah anda masukan sudah sesuai dengan nominal yang anda terima?",
                                      completion: () {
                                        context.read<CashierCubit>().order(
                                            token: context
                                                    .read<AuthCubit>()
                                                    .token ??
                                                "",
                                            orderModel: orderModel);
                                      });
                                }));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              "Bayar",
                              style: inter,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
