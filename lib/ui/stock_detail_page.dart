import 'package:cached_network_image/cached_network_image.dart';
import 'package:duitaja/cubit/auth_cubit.dart';
import 'package:duitaja/cubit/product_cubit.dart';
import 'package:duitaja/cubit/stock_management_cubit.dart';
import 'package:duitaja/model/detail_stock_management_model.dart';
import 'package:duitaja/model/product_model.dart';
import 'package:duitaja/model/promo_model.dart';
import 'package:duitaja/shared/loading.dart';
import 'package:duitaja/shared/modal_alert.dart';
import 'package:duitaja/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StockDetailPage extends StatefulWidget {
  const StockDetailPage({super.key});

  @override
  State<StockDetailPage> createState() => _StockDetailPageState();
}

class _StockDetailPageState extends State<StockDetailPage> {
  DetailStockManagementModel? detailStockManagementModel;

  TextEditingController descriptionTextField = TextEditingController(text: "");

  String? selectedPromo;

  // ignore: unused_field, non_constant_identifier_names
  final _controller = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();

    context.read<DetailStockManagementCubit>().detailStockManagementData(
        token: context.read<AuthCubit>().token ?? "",
        productId: context.read<ProductCubit>().state.productId ?? "");
  }

  @override
  Widget build(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    showPromoModalBottomSheet() {
      return showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        isScrollControlled:
            true, // To make the sheet adjustable for larger content
        builder: (context) {
          PromoModel? promoModel;
          context
              .read<DetailStockManagementPromoCubit>()
              .allPromo(token: context.read<AuthCubit>().token ?? "");

          return BlocConsumer<DetailStockManagementPromoCubit,
              DetailStockManagementPromoState>(
            listener: (context, state) {
              if (state is DetailStockManagementPromoSuccess) {
                promoModel = state.promoModel;
              }

              if (state is DetailStockManagementPromoTokenExpired) {
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
                                index < (promoModel?.payload?.length ?? 0);
                                index++) ...{
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    // productItems?[cardIndex] =
                                    //     stockOpnameAvailableItemModel
                                    //             ?.payload?[index] ??
                                    //         availableItem.Payload();
                                    selectedPromo =
                                        "${promoModel?.payload?[index].name}||${promoModel?.payload?[index].id}";
                                    Navigator.pop(context);
                                  });
                                },
                                child: Container(
                                  color: Colors.white,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                            promoModel?.payload?[index].name ??
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

    Widget generateInfoItem({
      required String title,
      required Widget action,
    }) {
      return Container(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 20,
        ),
        decoration: BoxDecoration(
            border: Border.all(
          color: greyColor1,
        )),
        child: Row(
          children: [
            Text(
              title,
              style: inter,
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: action,
              ),
            ),
          ],
        ),
      );
    }

    return BlocConsumer<DetailStockManagementCubit, DetailStockManagementState>(
      listener: (context, state) {
        if (state is DetailStockManagementTokenExpired) {
          context.read<AuthCubit>().logout();
          Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
        }
        if (state is DetailStockManagementLoading) {
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) {
                return const Loading();
              });
        }

        if (state is DetailStockManagementSuccess) {
          detailStockManagementModel = state.detailStockManagementModel;
          _controller.value =
              state.detailStockManagementModel.payload?.status ?? false;
          descriptionTextField.text =
              detailStockManagementModel?.payload?.description ?? "";
        }

        if (state is DetailStockManagementUpdateSuccess) {
          Navigator.pop(context);
          context.read<StockManagementCubit>().stockManagementReset();
          Navigator.pop(context);
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Data berhasil diubah",
                style: inter,
              ),
              backgroundColor: Colors.green,
              duration: const Duration(
                seconds: 5,
              ),
            ),
          );
        }

        if (state is DetailStockManagementFailure) {
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
      },
      builder: (context, state) {
        return BlocBuilder<ProductCubit, ProductModel>(
          builder: (context, state) {
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
                      }),
                );
                return true;
              },
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: primaryColor,
                  title: Text(
                    "Kelola Stok",
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
                            }),
                      );
                    },
                    child: const Icon(
                      Icons.chevron_left,
                    ),
                  ),
                  centerTitle: true,
                ),
                body: ListView(
                  children: [
                    const SizedBox(
                      height: 29,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Text(
                            "Foto Menu",
                            style: inter.copyWith(
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: CachedNetworkImage(
                              width: 100,
                              height: 100,
                              imageUrl: state.productURL ?? "",
                              errorWidget: (context, url, error) => Image.asset(
                                "assets/no-image.png",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 80,
                          ),
                          generateInfoItem(
                            title: "Kategori:",
                            action: Text(
                              state.productCategory ?? "",
                              style: inter.copyWith(
                                fontWeight: semiBold,
                              ),
                            ),
                          ),
                          generateInfoItem(
                            title: "Nama:",
                            action: Text(
                              state.productName ?? "",
                              style: inter.copyWith(
                                fontWeight: semiBold,
                              ),
                            ),
                          ),
                          generateInfoItem(
                            title: "Stok:",
                            action: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                detailStockManagementModel
                                            ?.payload?.hasReceipt ==
                                        false
                                    ? const SizedBox()
                                    : GestureDetector(
                                        onTap: () {
                                          context
                                              .read<ProductCubit>()
                                              .removeStock(state);
                                          setState(() {});
                                        },
                                        child: Container(
                                          width: 20,
                                          height: 20,
                                          padding: const EdgeInsets.all(2),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
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
                                  "${state.stock}",
                                  style: inter,
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                detailStockManagementModel
                                            ?.payload?.hasReceipt ==
                                        false
                                    ? const SizedBox()
                                    : GestureDetector(
                                        onTap: () {
                                          context
                                              .read<ProductCubit>()
                                              .addStock(state);
                                          setState(() {});
                                        },
                                        child: Container(
                                          width: 20,
                                          height: 20,
                                          padding: const EdgeInsets.all(2),
                                          decoration: BoxDecoration(
                                            color: primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(5),
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
                        ],
                      ),
                    ),
                    generateInfoItem(
                      title: "Promo:",
                      action: GestureDetector(
                        onTap: () {
                          showPromoModalBottomSheet();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              selectedPromo == null
                                  ? (detailStockManagementModel
                                          ?.payload?.promo?.name ??
                                      "Pilih Promo")
                                  : "${selectedPromo?.split("||").first}",
                              style: inter.copyWith(
                                fontWeight: light,
                              ),
                            ),
                            const Icon(
                              Icons.keyboard_arrow_down_rounded,
                            ),
                          ],
                        ),
                      ),
                    ),
                    generateInfoItem(
                      title: "Deskripsi:",
                      action: TextFormField(
                        controller: descriptionTextField,
                        textAlign: TextAlign.end,
                        decoration: const InputDecoration.collapsed(
                          hintText: "Masukkan Deskripsi",
                        ),
                      ),
                    ),
                    generateInfoItem(
                      title: "Status Produk:",
                      action: AdvancedSwitch(
                        controller: _controller,
                        activeColor: primaryColor,
                      ),
                    ),
                    const SizedBox(
                      height: 97,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => ModalAlert(
                                  title: "",
                                  message:
                                      "Apakah Anda yakin ingin keluar? Perubahan yang belum disimpan akan hilang.",
                                  completion: () {
                                    Navigator.pop(context);
                                  }),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            side: BorderSide(
                              color: greyColor1,
                            ),
                          ),
                          child: Text(
                            "Batal",
                            style: inter.copyWith(
                              fontWeight: medium,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 22,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return ModalAlert(
                                      title: "",
                                      message:
                                          "Apakah anda yakin untuk menyimpan data ini?",
                                      completion: () {
                                        context
                                            .read<DetailStockManagementCubit>()
                                            .updateStockManagementData(
                                              token: context
                                                      .read<AuthCubit>()
                                                      .token ??
                                                  "",
                                              productId:
                                                  detailStockManagementModel
                                                          ?.payload?.id ??
                                                      "",
                                              promoId: selectedPromo == null
                                                  ? detailStockManagementModel
                                                      ?.payload?.id
                                                  : "${selectedPromo?.split("||").last}",
                                              description:
                                                  descriptionTextField.text,
                                              status: "${_controller.value}",
                                              quantity: "${state.stock}",
                                            );
                                      });
                                });
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
                        const SizedBox(
                          width: 22,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
