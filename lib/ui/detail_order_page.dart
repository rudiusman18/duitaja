import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:duitaja/cubit/auth_cubit.dart';
import 'package:duitaja/cubit/cashier_cubit.dart';
import 'package:duitaja/model/order_model.dart';
import 'package:duitaja/model/product_model.dart';
import 'package:duitaja/shared/loading.dart';
import 'package:duitaja/shared/modal_alert.dart';
import 'package:duitaja/shared/theme.dart';
import 'package:duitaja/shared/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailOrderPage extends StatefulWidget {
  const DetailOrderPage({super.key});

  @override
  State<DetailOrderPage> createState() => _DetailOrderPageState();
}

class _DetailOrderPageState extends State<DetailOrderPage> {
  TextEditingController customerNameTextField = TextEditingController(text: "");
  TextEditingController phoneNumberTextField = TextEditingController(text: "");
  TextEditingController noteTextField = TextEditingController(text: "");

  List<Purchaseds>? purchaseds = [];

  @override
  void initState() {
    context
        .read<CashierCubit>()
        .tax(token: context.read<AuthCubit>().token ?? "");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final groupedProduct =
        groupBy(context.read<ProductCartCubit>().state, (item) => item.id);

    Map<int?, int> counts = {};
    int totalCount = 0;
    Map<int?, int> groupPriceSums = {};
    int totalPrice = 0;
    int totalTax = 0;
    if (groupedProduct.isNotEmpty) {
      counts = groupedProduct.map((id, group) => MapEntry(id, group.length));
      // Sum all counts
      totalCount = counts.values.reduce((a, b) => a + b);

      // Calculate the sum of prices for each group
      groupPriceSums = groupedProduct.map(
        (id, group) => MapEntry(
          id,
          group.fold(
              0,
              (sum, item) =>
                  sum +
                  (item.discountPrice != 0
                      ? item.discountPrice ?? 0
                      : item.price ?? 0)),
        ),
      );

      // Calculate the total sum of prices across all items
      totalPrice = groupPriceSums.values.reduce((a, b) => a + b);

      totalTax = (double.parse("$totalPrice") *
              ((context
                          .read<CashierCubit>()
                          .taxModel
                          .payload
                          ?.first
                          .precentage ??
                      0) /
                  100))
          .toInt();
    }

    Widget generateCustomerFormOrder({
      required String formTitle,
      required TextEditingController controller,
      required TextInputType keyboardType,
    }) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            formTitle,
            style: inter.copyWith(
              fontSize: 12,
              fontWeight: light,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              hintText: "",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                  color: primaryColor,
                  width: 2.0,
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
            ),
          ),
        ],
      );
    }

    Widget customerInfoSetup() {
      return Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 32,
            ),
            generateCustomerFormOrder(
                formTitle: "Nama Pelanggan",
                controller: customerNameTextField,
                keyboardType: TextInputType.name),
            const SizedBox(
              height: 24,
            ),
            generateCustomerFormOrder(
              formTitle: "No. Hp",
              controller: phoneNumberTextField,
              keyboardType: TextInputType.phone,
            ),
          ],
        ),
      );
    }

    Widget itemMenuListSetup(
        {required ProductModel product, required int index}) {
      if ((purchaseds?.length ?? 0) < groupedProduct.length) {
        purchaseds?.add(Purchaseds(
          id: product.productId,
          qty: groupedProduct[product.id]?.length,
          priceAll: product.discountPrice == null || product.discountPrice == 0
              ? product.price
              : product.discountPrice,
          promoId: product.discountId,
          promoAmount: (product.price ?? 0) - (product.discountPrice ?? 0),
        ));
      }

      return Column(
        children: [
          Divider(
            height: 1,
            thickness: 1,
            color: greyColor1,
          ),
          const SizedBox(
            height: 14,
          ),
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 72,
                  height: 72,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: CachedNetworkImage(
                      imageUrl: product.productURL ?? "",
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>
                          Image.asset("assets/no-image.png", fit: BoxFit.cover),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 21,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.productName ?? "",
                        style: inter.copyWith(
                          fontWeight: semiBold,
                          fontSize: 15,
                        ),
                      ),
                      if (product.discountPrice != 0) ...{
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          formatCurrency(product.price ?? 0),
                          style: inter.copyWith(
                            fontWeight: extraLight,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      },
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        formatCurrency(
                          product.discountPrice != 0
                              ? product.discountPrice ?? 0
                              : product.price ?? 0,
                        ),
                        style: inter.copyWith(
                          fontSize: 15,
                          fontWeight: semiBold,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(
                    9,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: disableColor,
                    ),
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          var products = context.read<ProductCartCubit>().state;
                          if (products.length < 2) {
                            showDialog(
                              context: context,
                              builder: (context) => ModalAlert(
                                title: "",
                                message:
                                    "Apakah anda ingin membatalkan pesanan?",
                                completion: () {
                                  products.remove(product);

                                  context
                                      .read<ProductCartCubit>()
                                      .addProduct(products);
                                  if (products.isEmpty) {
                                    Navigator.pop(context);
                                  }
                                  setState(() {});
                                },
                              ),
                            );
                          } else {
                            products.remove(product);

                            context
                                .read<ProductCartCubit>()
                                .addProduct(products);

                            if ((purchaseds?.length ?? 0) <
                                groupedProduct.length) {
                              purchaseds?.add(Purchaseds(
                                id: product.productId,
                                qty: groupedProduct[product.id]?.length,
                                priceAll: product.discountPrice == null ||
                                        product.discountPrice == 0
                                    ? product.price
                                    : product.discountPrice,
                                promoId: product.discountId,
                                promoAmount: (product.price ?? 0) -
                                    (product.discountPrice ?? 0),
                              ));
                            }

                            if (((purchaseds![index].qty ?? 0) - 1) > 0) {
                              purchaseds![index].qty =
                                  (purchaseds![index].qty ?? 0) - 1;
                            } else {
                              purchaseds?.removeAt(index);
                            }

                            if (products.isEmpty) {
                              Navigator.pop(context);
                            }
                            setState(() {});
                          }
                        },
                        child: const Icon(
                          Icons.remove,
                          size: 14,
                        ),
                      ),
                      const SizedBox(
                        width: 14,
                      ),
                      Text('${groupedProduct[product.id]?.length}'),
                      const SizedBox(
                        width: 14,
                      ),
                      GestureDetector(
                        onTap: () {
                          if ((groupedProduct[product.id]?.length ?? 0) <
                              (product.stock ?? 0)) {
                            var products =
                                context.read<ProductCartCubit>().state;
                            products.add(product);
                            context
                                .read<ProductCartCubit>()
                                .addProduct(products);

                            purchaseds![index].qty =
                                (purchaseds![index].qty ?? 0) + 1;
                            setState(() {});
                          } else {
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "Seluruh stok berada didalam keranjang",
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
                        child: const Icon(
                          Icons.add,
                          size: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 14,
          ),
        ],
      );
    }

    Widget orderSummarySetup() {
      return Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 5,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            10,
          ),
          border: Border.all(
            color: filterGreyColor,
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "Total Pesanan ($totalCount)",
                  style: inter,
                ),
                Expanded(
                  child: Text(
                    formatCurrency(totalPrice),
                    style: inter,
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Text(
                  "Pajak(${(context.read<CashierCubit>().taxModel.payload?.first.precentage ?? 0)}%)",
                  style: inter,
                ),
                Expanded(
                  child: Text(
                    formatCurrency(totalTax),
                    style: inter,
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Divider(
              color: filterGreyColor,
              height: 2,
              thickness: 2,
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Text(
                  "Total Pembayaran",
                  style: inter.copyWith(
                    fontWeight: semiBold,
                  ),
                ),
                Expanded(
                  child: Text(
                    formatCurrency(totalPrice + totalTax),
                    style: inter,
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    return BlocConsumer<CashierCubit, CashierState>(
      listener: (context, state) {
        if (state is CashierSuccess) {
          totalTax = (double.parse("$totalPrice") *
                  ((context
                              .read<CashierCubit>()
                              .taxModel
                              .payload
                              ?.first
                              .precentage ??
                          0) /
                      100))
              .toInt();
        }

        if (state is CashierTokenExpired) {
          Navigator.pop(context);
          context.read<AuthCubit>().logout();
          Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
        }

        if (state is CashierOrderSuccess) {
          Navigator.pop(context);
          context.read<ProductCartCubit>().resetProduct();
          Navigator.pop(context);
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
          context
              .read<CashierCubit>()
              .tax(token: context.read<AuthCubit>().token ?? "");
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
              "Detail Pesanan",
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
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customerInfoSetup(),
              const SizedBox(
                height: 32,
              ),
              Expanded(
                child: ListView(
                  children: [
                    Divider(
                      color: filterGreyColor,
                      height: 10,
                      thickness: 10,
                    ),
                    for (var index = 0;
                        index < groupedProduct.length;
                        index++) ...{
                      itemMenuListSetup(
                        product:
                            groupedProduct[groupedProduct.keys.toList()[index]]
                                    ?[0] ??
                                ProductModel(
                                  id: -1,
                                  productId: "",
                                  productURL: "",
                                  productName: '',
                                  stock: 0,
                                  description: '',
                                  price: 0,
                                  discountId: "",
                                  discountPrice: 0,
                                  productCategory: "",
                                  status: "",
                                ),
                        index: index,
                      ),
                    },
                    Divider(
                      color: filterGreyColor,
                      height: 5,
                      thickness: 5,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: TextFormField(
                        maxLines: 4,
                        controller: noteTextField,
                        decoration: InputDecoration(
                          hintText: "Catatan...",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                              color: primaryColor,
                              width: 2.0,
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Divider(
                      color: filterGreyColor,
                      height: 10,
                      thickness: 10,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    orderSummarySetup()
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Total :",
                            style: inter.copyWith(
                              fontSize: 15,
                              fontWeight: semiBold,
                            ),
                          ),
                          Text(
                            formatCurrency(totalPrice + totalTax),
                            style: inter,
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        OrderModel orderModel = OrderModel(
                          customerName: customerNameTextField.text,
                          phoneNumber: phoneNumberTextField.text == ""
                              ? null
                              : phoneNumberTextField.text,
                          notes: noteTextField.text == ""
                              ? null
                              : noteTextField.text,
                          paymentMethod: "CASH",
                          status: false,
                          subTotal: totalPrice,
                          tax: totalTax,
                          taxId: context
                              .read<CashierCubit>()
                              .taxModel
                              .payload
                              ?.first
                              .id,
                          invoiceNumber: "#${generateSixDigitNumber()}",
                          purchaseds: purchaseds,
                        );
                        context.read<CashierCubit>().order(
                            token: context.read<AuthCubit>().token ?? "",
                            orderModel: orderModel);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        side: BorderSide(color: primaryColor),
                      ),
                      child: Text(
                        "Bayar nanti",
                        style: inter.copyWith(
                          color: primaryColor,
                          fontWeight: medium,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                      ),
                      onPressed: () {
                        OrderModel orderModel = OrderModel(
                          customerName: customerNameTextField.text,
                          phoneNumber: phoneNumberTextField.text == ""
                              ? null
                              : phoneNumberTextField.text,
                          notes: noteTextField.text == ""
                              ? null
                              : noteTextField.text,
                          paymentMethod: "CASH",
                          status: true,
                          subTotal: totalPrice,
                          tax: totalTax,
                          taxId: context
                              .read<CashierCubit>()
                              .taxModel
                              .payload
                              ?.first
                              .id,
                          invoiceNumber: "#${generateSixDigitNumber()}",
                          purchaseds: purchaseds,
                        );
                        context
                            .read<CashierCubit>()
                            .saveOrder(orderModel: orderModel);
                        Navigator.pushNamed(context, '/main-page/payment-page')
                            .then((value) => context.read<CashierCubit>().tax(
                                token: context.read<AuthCubit>().token ?? ""));
                      },
                      child: Text(
                        "Bayar Sekarang",
                        style: inter,
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
        );
      },
    );
  }
}
