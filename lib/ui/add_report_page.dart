import 'package:duitaja/cubit/add_report_cubit.dart';
import 'package:duitaja/cubit/auth_cubit.dart';
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
  int numberOfStockProduct =
      0; // Ini sifatnya sementara (hanya untuk menunjukkan ada perubahan)
  bool isLocked = false;
  TextEditingController searchTextField = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    if (cardIndex + 1 >
        int.parse(context.read<AddReportCubit>().state['amount'])) {
      cardIndex = int.parse(context.read<AddReportCubit>().state['amount']) - 1;
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
              value: Row(
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
              value: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (numberOfStockProduct != 0) {
                          numberOfStockProduct -= 1;
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
                    "$numberOfStockProduct",
                    style: inter,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        numberOfStockProduct += 1;
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

    return WillPopScope(
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
                context.read<AuthCubit>().profileModel.payload?.profile?.name ??
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
                      context
                          .read<AddReportCubit>()
                          .decreaseStock(context.read<AddReportCubit>().state);
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
                      context
                          .read<AddReportCubit>()
                          .increaseStock(context.read<AddReportCubit>().state);
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
                              "Apakah anda ingin ${isLocked ? "membuka kunci" : "mengunci"} produk “Mie Goreng $cardIndex”?",
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
                      child:
                          Icon(isLocked ? Icons.lock_outline : Icons.lock_open),
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
                              "Apakah anda ingin membuang produk “Mie Goreng $cardIndex” dari Stok Opname?",
                          completion: () {},
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
            generateProductCard(
              productName: "Pilih Produk",
              expiredDate: "DD/MM/YYYY",
              input: "-",
              output: "-",
              systemStock: "-",
              realStock: "-",
              differenceStock: "${-numberOfStockProduct}",
            ),
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
                          int.parse(
                              context.read<AddReportCubit>().state['amount'])) {
                        cardIndex += 1;
                      }
                    });
                  },
                  child: Icon(
                    Icons.chevron_right,
                    color: cardIndex + 1 ==
                            int.parse(
                                context.read<AddReportCubit>().state['amount'])
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
    );
  }
}
