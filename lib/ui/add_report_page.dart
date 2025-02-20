// ignore_for_file: library_prefixes

import 'package:duitaja/cubit/add_report_cubit.dart';
import 'package:duitaja/cubit/auth_cubit.dart';
import 'package:duitaja/cubit/stock_opname_cubit.dart';
import 'package:duitaja/model/stock_opname_available_items_model.dart'
    as availableItem;
import 'package:duitaja/shared/loading.dart';
import 'package:duitaja/shared/modal_alert.dart';
import 'package:duitaja/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddReportPage extends StatefulWidget {
  const AddReportPage({super.key});

  @override
  State<AddReportPage> createState() => _AddReportPageState();
}

class _AddReportPageState extends State<AddReportPage> {
  int cardIndex = 0;
  bool isLocked = false;
  TextEditingController searchTextField = TextEditingController(text: "");

  List<availableItem.Payload>? productItems;
  List<int>? realStocks;

  @override
  Widget build(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    if (cardIndex + 1 >
        int.parse(context.read<AddReportCubit>().state['amount'])) {
      cardIndex -= 1;
      realStocks?.removeAt(cardIndex);
      productItems?.removeAt(cardIndex);
      int.parse(context.read<AddReportCubit>().state['amount']) - 1;
    }

    for (var index = 0;
        index < int.parse(context.read<AddReportCubit>().state['amount']);
        index++) {
      if (productItems?.isEmpty ?? true) {
        productItems = [availableItem.Payload()];
        realStocks = [-1];
      } else {
        if (((productItems?.length ?? 0) - 1) < cardIndex) {
          productItems?.add(availableItem.Payload());
          realStocks?.add(-1);
        }
      }
    }

    // ignore: no_leading_underscores_for_local_identifiers
    void _showBottomSheet(BuildContext context) {
      showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        isScrollControlled:
            true, // To make the sheet adjustable for larger content
        builder: (context) {
          availableItem.StockOpnameAvailableItemModel?
              stockOpnameAvailableItemModel;
          context
              .read<StockOpnameAvailableItemCubit>()
              .allAvailableItem(token: context.read<AuthCubit>().token ?? "");

          return BlocConsumer<StockOpnameAvailableItemCubit,
              StockOpnameAvailableItemState>(
            listener: (context, state) {
              if (state is StockOpnameAvailableItemSuccess) {
                stockOpnameAvailableItemModel =
                    state.stockOpnameAvailableItemModel;
              }

              if (state is StockOpnameAvailableItemTokenExpired) {
                context.read<AuthCubit>().logout();
                Navigator.pushNamedAndRemoveUntil(
                    context, '/', (route) => false);
              }
            },
            builder: (context, state) {
              return SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.4,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 12,
                    ),
                    Container(
                      width: 150,
                      height: 5,
                      margin: const EdgeInsets.only(bottom: 13),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        child: ListView(
                          children: [
                            for (var index = 0;
                                index <
                                    (stockOpnameAvailableItemModel
                                            ?.payload?.length ??
                                        0);
                                index++) ...{
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    productItems?[cardIndex] =
                                        stockOpnameAvailableItemModel
                                                ?.payload?[index] ??
                                            availableItem.Payload();
                                    Navigator.pop(context);
                                  });
                                },
                                child: Container(
                                  color: Colors.white,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                            stockOpnameAvailableItemModel
                                                    ?.payload?[index].name ??
                                                ""),
                                      ),
                                      const Icon(
                                        Icons.chevron_right,
                                        color: Colors.black,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Divider(
                                height: 1,
                                color: greyColor2,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            }
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      );
    }

    Widget generateReportItem({
      required String title,
      required Widget value,
    }) {
      return Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: greyColor1,
          ),
        ),
        child: Row(
          children: [
            Text(
              title,
              style: inter.copyWith(
                fontWeight: semiBold,
              ),
            ),
            Expanded(
              child: value,
            ),
          ],
        ),
      );
    }

    Widget generateProductCardItem({
      required String title,
      required Widget value,
    }) {
      return Row(
        children: [
          Text(
            title,
            style: inter,
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: value,
          )
        ],
      );
    }

    Widget generateProductCard({
      required String productName,
      required String expiredDate,
      required String input,
      required String output,
      required String systemStock,
      required String realStock,
      required String differenceStock,
    }) {
      return Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 33,
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              20,
            ),
            border: Border.all(
              color: greyColor1,
            )),
        child: Column(
          children: [
            const SizedBox(
              height: 17,
            ),
            generateProductCardItem(
              title: "Produk :",
              value: GestureDetector(
                onTap: () {
                  _showBottomSheet(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      productName,
                      style: inter.copyWith(
                        color: productName.toLowerCase() == "pilih produk"
                            ? greyColor2
                            : Colors.black,
                      ),
                      textAlign: TextAlign.end,
                    ),
                    Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: productName.toLowerCase() == "pilih produk"
                          ? greyColor2
                          : Colors.black,
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 17,
            ),
            generateProductCardItem(
              title: "kadaluarsa :",
              value: Text(
                expiredDate,
                style: inter.copyWith(
                  color: expiredDate.toLowerCase() == "dd/mm/yyyy"
                      ? greyColor2
                      : Colors.black,
                ),
                textAlign: TextAlign.end,
              ),
            ),
            const SizedBox(
              height: 17,
            ),
            generateProductCardItem(
              title: "Masuk :",
              value: Text(
                input,
                style: inter,
                textAlign: TextAlign.end,
              ),
            ),
            const SizedBox(
              height: 17,
            ),
            generateProductCardItem(
              title: "Keluar :",
              value: Text(
                output,
                style: inter,
                textAlign: TextAlign.end,
              ),
            ),
            const SizedBox(
              height: 17,
            ),
            generateProductCardItem(
              title: "Stok Sistem :",
              value: Text(
                systemStock,
                style: inter,
                textAlign: TextAlign.end,
              ),
            ),
            const SizedBox(
              height: 17,
            ),
            generateProductCardItem(
              title: "Stok Asli :",
              value: productItems?[cardIndex].name == null
                  ? Text(
                      "${realStocks?[cardIndex] == -1 ? 0 : realStocks?[cardIndex]}",
                      style: inter,
                      textAlign: TextAlign.end,
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              if ((realStocks?[cardIndex] ?? 0) > 0) {
                                realStocks?[cardIndex] -= 1;
                              }
                            });
                          },
                          child: Container(
                            width: 20,
                            height: 20,
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  color: primaryColor,
                                )),
                            child: FittedBox(
                                fit: BoxFit.contain,
                                child: Icon(
                                  Icons.remove,
                                  color: primaryColor,
                                )),
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Text(
                          "${realStocks?[cardIndex] == -1 ? 0 : realStocks?[cardIndex]}",
                          style: inter,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              if (realStocks?[cardIndex] == -1) {
                                realStocks?[cardIndex] += 2;
                              } else {
                                realStocks?[cardIndex] += 1;
                              }
                            });
                          },
                          child: Container(
                            width: 20,
                            height: 20,
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: const FittedBox(
                                fit: BoxFit.contain,
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                )),
                          ),
                        ),
                      ],
                    ),
            ),
            const SizedBox(
              height: 17,
            ),
            generateProductCardItem(
              title: "Selisih :",
              value: Text(
                differenceStock,
                style: inter.copyWith(
                  color:
                      differenceStock.contains("-") ? Colors.red : Colors.black,
                ),
                textAlign: TextAlign.end,
              ),
            ),
            const SizedBox(
              height: 17,
            ),
          ],
        ),
      );
    }

    Widget searchSetup() {
      return TextFormField(
        controller: searchTextField,
        decoration: InputDecoration(
          suffixIcon: Icon(
            Icons.search,
            color: greyColor600,
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 16,
          ),
          hintText: "Cari Produk...",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              10,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              10,
            ),
            borderSide: BorderSide(
              color: primaryColor,
            ),
          ),
        ),
      );
    }

    return BlocListener<StockOpnameDetailCubit, StockOpnameDetailState>(
      listener: (context, state) {
        if (state is StockOpnameDetailSuccess) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: primaryColor,
              content: Text(
                "data berhasil disimpan",
                style: inter.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          );
          Navigator.pop(context);
        }

        if (state is StockOpnameDetailLoading) {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: ((context) {
                return const Loading();
              }));
        }

        if (state is StockOpnameDetailFailure) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: primaryColor,
              content: Text(
                state.error,
                style: inter.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          );
        }

        if (state is StockOpnameDetailTokenExpired) {
          Navigator.pop(context);
          context.read<AuthCubit>().logout();
          Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
        }
      },
      child: WillPopScope(
        onWillPop: () async {
          showDialog(
            context: context,
            builder: (context) => ModalAlert(
              title: "",
              message:
                  "Apakah Anda yakin ingin keluar? Perubahan yang belum disimpan akan hilang.",
              completion: () {
                Navigator.pop(context);
              },
            ),
          );
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: primaryColor,
            title: Text(
              "Buat Laporan",
              style: inter.copyWith(
                fontWeight: medium,
                fontSize: 20,
              ),
            ),
            leading: GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => ModalAlert(
                    title: "",
                    message:
                        "Apakah Anda yakin ingin keluar? Perubahan yang belum disimpan akan hilang.",
                    completion: () {
                      Navigator.pop(context);
                    },
                  ),
                );
              },
              child: const Icon(
                Icons.chevron_left,
                size: 24,
              ),
            ),
            centerTitle: true,
          ),
          body: ListView(
            children: [
              generateReportItem(
                title: "Judul: ",
                value: Text(
                  "${context.read<AddReportCubit>().state['title']}",
                  style: inter.copyWith(
                    fontWeight: semiBold,
                  ),
                  textAlign: TextAlign.end,
                ),
              ),
              generateReportItem(
                title: "Nama: ",
                value: Text(
                  context
                          .read<AuthCubit>()
                          .profileModel
                          .payload
                          ?.profile
                          ?.name ??
                      "",
                  style: inter.copyWith(
                    fontWeight: semiBold,
                  ),
                  textAlign: TextAlign.end,
                ),
              ),
              generateReportItem(
                title: "Tanggal: ",
                value: Text(
                  "15 November 2024",
                  style: inter.copyWith(
                    fontWeight: semiBold,
                  ),
                  textAlign: TextAlign.end,
                ),
              ),
              generateReportItem(
                title: "Total Produk: ",
                value: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        context.read<AddReportCubit>().decreaseStock(
                            context.read<AddReportCubit>().state);
                        setState(() {});
                      },
                      child: Container(
                        width: 20,
                        height: 20,
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: primaryColor,
                            )),
                        child: FittedBox(
                            fit: BoxFit.contain,
                            child: Icon(
                              Icons.remove,
                              color: primaryColor,
                            )),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Text(
                      "${context.read<AddReportCubit>().state['amount']}",
                      style: inter,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    GestureDetector(
                      onTap: () {
                        context.read<AddReportCubit>().increaseStock(
                            context.read<AddReportCubit>().state);
                        setState(() {});
                      },
                      child: Container(
                        width: 20,
                        height: 20,
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const FittedBox(
                            fit: BoxFit.contain,
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                            )),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Row(
                  children: [
                    ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: 164,
                      ),
                      child: searchSetup(),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => ModalAlert(
                            title: "",
                            message:
                                "Apakah anda ingin ${isLocked ? "membuka kunci" : "mengunci"} produk “${productItems?[cardIndex].name ?? "-"}\"?",
                            completion: () {
                              setState(() {
                                isLocked = !isLocked;
                              });
                            },
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: greyColor1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                            isLocked ? Icons.lock_outline : Icons.lock_open),
                      ),
                    ),
                    const SizedBox(
                      width: 18,
                    ),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => ModalAlert(
                            title: "",
                            message:
                                "Apakah anda ingin membuang produk “${productItems?[cardIndex].name}” dari Stok Opname?",
                            completion: () {
                              setState(() {
                                productItems?.removeAt(cardIndex);
                                realStocks?.removeAt(cardIndex);
                                context.read<AddReportCubit>().decreaseStock(
                                    context.read<AddReportCubit>().state);
                              });
                            },
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: greyColor1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.delete_outline_rounded,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              if (productItems?[cardIndex].name == null) ...{
                generateProductCard(
                  productName: "Pilih Produk",
                  expiredDate: "DD/MM/YYYY",
                  input: "-",
                  output: "-",
                  systemStock: "-",
                  realStock: "-",
                  differenceStock: "${-(realStocks?[cardIndex] ?? 0)}",
                ),
              } else ...{
                generateProductCard(
                  productName: "${productItems?[cardIndex].name}",
                  expiredDate: "${productItems?[cardIndex].expiredDate}",
                  input: "-",
                  output: "-",
                  systemStock: "${productItems?[cardIndex].quantity}",
                  realStock: "-",
                  differenceStock:
                      "${(productItems?[cardIndex].quantity ?? 0) - ((realStocks?[cardIndex] ?? 0) < 0 ? 0 : (realStocks?[cardIndex]) ?? 0)}",
                ),
              },
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (cardIndex != 0) {
                          cardIndex -= 1;
                        }
                      });
                    },
                    child: Icon(
                      Icons.chevron_left,
                      color: cardIndex == 0 ? greyColor1 : Colors.black,
                    ),
                  ),
                  Text(
                    "${cardIndex + 1}/${context.read<AddReportCubit>().state['amount']}",
                    style: inter.copyWith(
                      fontWeight: medium,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (cardIndex + 1 <
                            int.parse(context
                                .read<AddReportCubit>()
                                .state['amount'])) {
                          cardIndex += 1;
                        }
                      });
                    },
                    child: Icon(
                      Icons.chevron_right,
                      color: cardIndex + 1 ==
                              int.parse(context
                                  .read<AddReportCubit>()
                                  .state['amount'])
                          ? greyColor1
                          : Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 136,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                          ),
                          child: Text(
                            "Ekspor",
                            style: inter.copyWith(
                              fontWeight: medium,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 136,
                        child: ElevatedButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) => ModalAlert(
                                    title: "",
                                    message:
                                        "Apakah Anda yakin ingin menyimpan data? Data yang disimpan akan mempengaruhi stok produk dan tidak bisa diubah.",
                                    completion: () {
                                      setState(() {
                                        productItems?.removeWhere((element) {
                                          return element.name == null;
                                        });

                                        realStocks?.removeRange(
                                            (productItems?.length ?? 1) - 1,
                                            (realStocks?.length ?? 1) - 1);

                                        context
                                            .read<StockOpnameDetailCubit>()
                                            .addReportStockOpname(
                                                token: context
                                                        .read<AuthCubit>()
                                                        .token ??
                                                    "",
                                                title: context
                                                    .read<AddReportCubit>()
                                                    .state['title'],
                                                productDatas:
                                                    productItems ?? [],
                                                realStocks: realStocks ?? []);
                                      });
                                    }));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                          ),
                          child: Text(
                            "Simpan",
                            style: inter.copyWith(
                              fontWeight: medium,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
