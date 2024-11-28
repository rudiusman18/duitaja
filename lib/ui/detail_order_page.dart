import 'package:collection/collection.dart';
import 'package:duidku/cubit/cashier_cubit.dart';
import 'package:duidku/model/product_model.dart';
import 'package:duidku/shared/theme.dart';
import 'package:duidku/shared/utils.dart';
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

  @override
  Widget build(BuildContext context) {
    final groupedProduct = groupBy(
        context.read<ProductCartCubit>().state, (item) => item.productId);

    Map<int?, int> counts = {};
    int totalCount = 0;
    Map<int?, int> groupPriceSums = {};
    int totalPrice = 0;
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

    Widget itemMenuListSetup({required ProductModel product}) {
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
                Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    image: DecorationImage(
                      image: NetworkImage(
                        product.productURL ?? "",
                      ),
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
                          products.remove(product);

                          context.read<ProductCartCubit>().addProduct(products);
                          if (products.isEmpty) {
                            Navigator.pop(context);
                          }
                          setState(() {});
                        },
                        child: const Icon(
                          Icons.remove,
                          size: 14,
                        ),
                      ),
                      const SizedBox(
                        width: 14,
                      ),
                      Text('${groupedProduct[product.productId]?.length}'),
                      const SizedBox(
                        width: 14,
                      ),
                      GestureDetector(
                        onTap: () {
                          var products = context.read<ProductCartCubit>().state;
                          products.add(product);
                          context.read<ProductCartCubit>().addProduct(products);
                          setState(() {});
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
                  "Pajak",
                  style: inter,
                ),
                Expanded(
                  child: Text(
                    formatCurrency(7000),
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
                    formatCurrency(totalPrice + 7000),
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
                for (var index = 0; index < groupedProduct.length; index++) ...{
                  itemMenuListSetup(
                    product: groupedProduct[groupedProduct.keys.toList()[index]]
                            ?[0] ??
                        ProductModel(
                          productId: -1,
                          productURL: "",
                          productName: '',
                          stock: 0,
                          description: '',
                          price: 0,
                          discountPrice: 0,
                        ),
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
                        formatCurrency(totalPrice + 7000),
                        style: inter,
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
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
                  onPressed: () {},
                  child: Text(
                    "bayar Sekarang",
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
  }
}
