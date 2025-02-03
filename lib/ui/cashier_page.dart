import 'package:cached_network_image/cached_network_image.dart';
import 'package:duidku/cubit/auth_cubit.dart';
import 'package:duidku/cubit/cashier_cubit.dart';
import 'package:duidku/cubit/sale_cubit.dart';
import 'package:duidku/model/product_model.dart';
import 'package:duidku/model/sellable_product_model.dart';
import 'package:duidku/shared/theme.dart';
import 'package:duidku/shared/utils.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collection/collection.dart';

class CashierPage extends StatefulWidget {
  const CashierPage({super.key});

  @override
  State<CashierPage> createState() => _CashierPageState();
}

class _CashierPageState extends State<CashierPage> {
  TextEditingController menuSearchTextField = TextEditingController(text: "");
  ExpandableController expandableController =
      ExpandableController(initialExpanded: true);

  SellableProductModel? menuProduct;

  int menuProductPage = 1;

  bool isEmptyData = false;

  @override
  void initState() {
    context.read<ProductMenuCubit>().sellableProduct(
          token: context.read<AuthCubit>().token ?? "",
          page: "$menuProductPage",
          limit: "100",
          categoryId: "",
        );

    context.read<SaleCubit>().allSalesHistory(
          token: context.read<AuthCubit>().token ?? "",
          page: "1",
          limit: "15",
          status: "",
          startDate: "",
          endDate: "",
        );

    context.read<IndexCashierFilterCubit>().category(
          token: context.read<AuthCubit>().token ?? "",
        );

    context.read<IndexCashierFilterCubit>().setIndex(-1);
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
    if (groupedProduct.isNotEmpty) {
      counts = groupedProduct.map((id, group) => MapEntry(id, group.length));
      // Sum all counts
      totalCount = counts.values.reduce((a, b) => a + b);

      // Calculate the sum of prices for each group
      groupPriceSums = groupedProduct.map(
        (id, group) => MapEntry(
          id,
          group.fold(0, (sum, item) => sum + (item.price ?? 0)),
        ),
      );

      // Calculate the total sum of prices across all items
      totalPrice = groupPriceSums.values.reduce((a, b) => a + b);
    }

    Widget searchSetup() {
      return Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 25,
        ),
        child: TextFormField(
          controller: menuSearchTextField,
          textInputAction: TextInputAction.search,
          onChanged: (text) {
            if (text == "") {
              menuProduct = null;
              menuProductPage = 1;
              context.read<ProductMenuCubit>().sellableProduct(
                    token: context.read<AuthCubit>().token ?? "",
                    page: "$menuProductPage",
                    limit: "100",
                    categoryId: context
                                .read<IndexCashierFilterCubit>()
                                .cashierCategoryIndex ==
                            -1
                        ? ""
                        : "${context.read<IndexCashierFilterCubit>().cashierCategoryModel.payload?[context.read<IndexCashierFilterCubit>().cashierCategoryIndex].id}",
                    search: menuSearchTextField.text,
                  );
            }
          },
          onEditingComplete: () {
            FocusManager.instance.primaryFocus?.unfocus();
            menuProduct = null;
            menuProductPage = 1;
            context.read<ProductMenuCubit>().sellableProduct(
                  token: context.read<AuthCubit>().token ?? "",
                  page: "$menuProductPage",
                  limit: "100",
                  categoryId: context
                              .read<IndexCashierFilterCubit>()
                              .cashierCategoryIndex ==
                          -1
                      ? ""
                      : "${context.read<IndexCashierFilterCubit>().cashierCategoryModel.payload?[context.read<IndexCashierFilterCubit>().cashierCategoryIndex].id}",
                  search: menuSearchTextField.text,
                );
          },
          decoration: InputDecoration(
            suffixIcon: Icon(
              Icons.search,
              color: greyColor600,
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 16,
            ),
            hintText: "Cari menu...",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                9999,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                9999,
              ),
              borderSide: BorderSide(
                color: primaryColor,
              ),
            ),
          ),
        ),
      );
    }

    Widget itemFilter({
      required String name,
      required bool isSelected,
    }) {
      return Container(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 11,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? Colors.transparent : filterGreyColor,
          ),
          color: isSelected ? purpleColor1 : Colors.transparent,
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            name,
            style: inter.copyWith(
              fontWeight: medium,
              fontSize: 14,
              color: primaryColor,
            ),
          ),
        ),
      );
    }

    Widget filterSetup() {
      return SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              GestureDetector(
                onTap: () {
                  menuProductPage = 1;
                  menuProduct = null;
                  context.read<IndexCashierFilterCubit>().setIndex(-1);
                  context.read<ProductMenuCubit>().sellableProduct(
                        token: context.read<AuthCubit>().token ?? "",
                        page: "1",
                        limit: "100",
                        categoryId: "",
                      );
                },
                child: itemFilter(
                  name: "Semua",
                  isSelected: context
                              .read<IndexCashierFilterCubit>()
                              .cashierCategoryIndex ==
                          -1
                      ? true
                      : false,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              for (int index = 0;
                  index <
                      (context
                              .read<IndexCashierFilterCubit>()
                              .cashierCategoryModel
                              .payload
                              ?.length ??
                          0);
                  index++) ...{
                GestureDetector(
                  onTap: () {
                    menuProductPage = 1;
                    menuProduct = null;
                    context.read<IndexCashierFilterCubit>().setIndex(index);
                    context.read<ProductMenuCubit>().sellableProduct(
                        token: context.read<AuthCubit>().token ?? "",
                        page: "1",
                        limit: "100",
                        categoryId:
                            "${context.read<IndexCashierFilterCubit>().cashierCategoryModel.payload?[index].id}");
                  },
                  child: itemFilter(
                    name:
                        "${context.read<IndexCashierFilterCubit>().cashierCategoryModel.payload?[index].name}",
                    isSelected: context
                                .read<IndexCashierFilterCubit>()
                                .cashierCategoryIndex ==
                            index
                        ? true
                        : false,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
              },
            ],
          ),
        ),
      );
    }

    Widget orderListItem({
      required String name,
      required String status,
      required String orderID,
      required String numberOfItems,
    }) {
      return Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 9,
          vertical: 8,
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: greyColor1,
            )),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: inter.copyWith(
                    fontSize: 15,
                    fontWeight: semiBold,
                  ),
                ),
                const SizedBox(
                  height: 9,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 9,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: status.toLowerCase().contains("belum")
                        ? Colors.red
                        : Colors.green,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    status,
                    style: inter.copyWith(
                      fontWeight: medium,
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              width: 21,
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  orderID,
                  style: inter.copyWith(
                    fontWeight: extraLight,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(
                  height: 9,
                ),
                Text(
                  numberOfItems,
                  style: inter.copyWith(
                    fontSize: 12,
                    fontWeight: extraLight,
                  ),
                ),
              ],
            )
          ],
        ),
      );
    }

    Widget orderListSetup() {
      return ExpandablePanel(
          controller: expandableController,
          theme: const ExpandableThemeData(
            headerAlignment: ExpandablePanelHeaderAlignment
                .center, // Ensures alignment consistency
            tapBodyToExpand: true,
            tapBodyToCollapse: true,
            hasIcon: true, // Disable default arrow icon
          ),
          header: Container(
            padding: const EdgeInsets.only(
              top: 15,
            ),
            margin: const EdgeInsets.only(
              bottom: 18,
              left: 20,
              right: 20,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Daftar Pesanan",
                  textAlign: TextAlign.center, // Center align the text
                  style: inter.copyWith(
                    fontSize: 16,
                    fontWeight: medium,
                  ),
                ),
                const SizedBox(
                  width: 9,
                ),
                Text(
                  "${context.read<SaleCubit>().saleHistoryModel.payload?.length}",
                  textAlign: TextAlign.center, // Center align the text
                  style: inter.copyWith(
                    fontSize: 16,
                    fontWeight: light,
                  ),
                ),
              ],
            ),
          ),
          collapsed: const SizedBox(),
          expanded: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Row(
                children: [
                  for (var i = 0;
                      i <
                          (context
                                  .read<SaleCubit>()
                                  .saleHistoryModel
                                  .payload
                                  ?.length ??
                              0);
                      i++) ...{
                    i == 0
                        ? const SizedBox()
                        : const SizedBox(
                            width: 23,
                          ),
                    orderListItem(
                      name:
                          "${context.read<SaleCubit>().saleHistoryModel.payload?[i].customerName}",
                      status:
                          "${context.read<SaleCubit>().saleHistoryModel.payload?[i].status}",
                      orderID:
                          "${context.read<SaleCubit>().saleHistoryModel.payload?[i].invoiceNumber}",
                      numberOfItems:
                          "${context.read<SaleCubit>().saleHistoryModel.payload?[i].countSale} Barang",
                    ),
                  }
                ],
              ),
            ),
          ));
    }

    // Menampilkan bottom dialog dari menu yang dipilih
    // ignore: no_leading_underscores_for_local_identifiers
    void _showBottomSheet(BuildContext context,
        {required ProductModel product}) {
      showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        isScrollControlled:
            true, // To make the sheet adjustable for larger content
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min, // Adjusts height to fit content
            children: [
              const SizedBox(
                height: 12,
              ),
              Container(
                width: 50,
                height: 5,
                margin: const EdgeInsets.only(bottom: 13),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 23,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 140,
                      height: 140,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: CachedNetworkImage(
                          imageUrl: product.productURL ?? "",
                          errorWidget: (context, url, error) => Image.asset(
                            "assets/no-image.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 18,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.productName ?? "",
                            style: inter.copyWith(
                              fontSize: 15,
                              fontWeight: semiBold,
                            ),
                          ),
                          Text(
                            "Stok: ${product.stock ?? 0}",
                            style: inter.copyWith(
                              fontSize: 12,
                              fontWeight: extraLight,
                            ),
                          ),
                          Text(
                            product.description ?? "",
                            style: inter.copyWith(
                              fontSize: 12,
                              fontWeight: extraLight,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Row(
                            children: [
                              Text(
                                formatCurrency(
                                  product.discountPrice == 0
                                      ? product.price ?? 0
                                      : product.discountPrice ?? 0,
                                ),
                                style: inter.copyWith(
                                  fontSize: 15,
                                  fontWeight: semiBold,
                                ),
                              ),
                              if (product.discountPrice != 0) ...{
                                const SizedBox(
                                  width: 7,
                                ),
                                Text(
                                  formatCurrency(
                                    product.price ?? 0,
                                  ),
                                  style: inter.copyWith(
                                    fontSize: 10,
                                    fontWeight: medium,
                                    color: greyColor2,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                              },
                            ],
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryColor,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                                if ((groupedProduct[product.id]?.length ?? 0) <
                                    (product.stock ?? 0)) {
                                  var products =
                                      context.read<ProductCartCubit>().state;
                                  products.add(product);
                                  context
                                      .read<ProductCartCubit>()
                                      .addProduct(products);
                                  setState(() {});
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .hideCurrentSnackBar();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        "Seluruh stok habis atau berada didalam keranjang",
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
                              child: Text(
                                "Tambah Pesanan",
                                style: inter.copyWith(
                                  fontWeight: medium,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 18,
              ),
            ],
          );
        },
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
                      Text(
                        "Stok : ${product.stock ?? 0}",
                        style: inter.copyWith(
                          fontSize: 12,
                          fontWeight: extraLight,
                        ),
                      ),
                      Text(
                        product.description ?? "-",
                        style: inter.copyWith(
                          fontSize: 12,
                          fontWeight: extraLight,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
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
                      textAlign: TextAlign.end,
                    ),
                    product.discountPrice != 0
                        ? Text(
                            formatCurrency(
                              product.price ?? 0,
                            ),
                            style: inter.copyWith(
                              fontWeight: medium,
                              fontSize: 10,
                              color: greyColor2,
                              decoration: TextDecoration.lineThrough,
                            ),
                          )
                        : const SizedBox(),
                    const SizedBox(
                      height: 6,
                    ),
                    GestureDetector(
                      onTap: () {
                        _showBottomSheet(context, product: product);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(
                          5,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: primaryColor,
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
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

    return BlocBuilder<SaleCubit, SaleState>(
      builder: (context, state) {
        return BlocBuilder<IndexCashierFilterCubit, IndexCashierFilterState>(
          builder: (context, state) {
            return BlocConsumer<ProductMenuCubit, ProductMenuState>(
              listener: (context, state) {
                if (state is ProductMenuTokenExpired) {
                  context.read<AuthCubit>().logout();
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/', (route) => false);
                }
                if (state is ProductMenuSuccess) {
                  if (menuProduct == null) {
                    menuProduct =
                        context.read<ProductMenuCubit>().sellableProductModel;
                  } else {
                    menuProduct?.payload?.addAll(context
                            .read<ProductMenuCubit>()
                            .sellableProductModel
                            .payload
                            ?.toList() ??
                        []);
                  }

                  if (menuProduct?.payload == null) {
                    isEmptyData = true;
                  } else {
                    isEmptyData = false;
                  }
                }
              },
              builder: (context, state) {
                return Scaffold(
                  appBar: AppBar(
                    backgroundColor: primaryColor,
                    title: Text(
                      "Kasir",
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
                  body: Stack(
                    children: [
                      // Content
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 24,
                          ),
                          searchSetup(),
                          const SizedBox(
                            height: 36,
                          ),
                          filterSetup(),
                          if (context
                                  .read<SaleCubit>()
                                  .saleHistoryModel
                                  .payload ==
                              null) ...{
                            const SizedBox()
                          } else ...{
                            const SizedBox(
                              height: 24,
                            ),
                            orderListSetup(),
                          },
                          const SizedBox(
                            height: 24,
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            child: Text(
                              "Menu",
                              textAlign:
                                  TextAlign.center, // Center align the text
                              style: inter.copyWith(
                                fontSize: 16,
                                fontWeight: medium,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Expanded(
                            child: isEmptyData
                                ? Center(
                                    child: Text(
                                      "Data tidak ditemukan",
                                      style: inter,
                                    ),
                                  )
                                : NotificationListener(
                                    onNotification:
                                        (ScrollEndNotification notification) {
                                      if (menuProductPage !=
                                          context
                                              .read<ProductMenuCubit>()
                                              .sellableProductModel
                                              .meta
                                              ?.totalPage) {
                                        menuProductPage += 1;
                                        context
                                            .read<ProductMenuCubit>()
                                            .sellableProduct(
                                              token: context
                                                      .read<AuthCubit>()
                                                      .token ??
                                                  "",
                                              page: "$menuProductPage",
                                              limit: "100",
                                              categoryId: context
                                                          .read<
                                                              IndexCashierFilterCubit>()
                                                          .cashierCategoryIndex ==
                                                      -1
                                                  ? ""
                                                  : "${context.read<IndexCashierFilterCubit>().cashierCategoryModel.payload?[context.read<IndexCashierFilterCubit>().cashierCategoryIndex].id}",
                                            );
                                      }
                                      return true;
                                    },
                                    child: SingleChildScrollView(
                                      physics:
                                          const AlwaysScrollableScrollPhysics(),
                                      child: Column(
                                        children: [
                                          for (var i = 0;
                                              i <
                                                  (menuProduct
                                                          ?.payload?.length ??
                                                      0);
                                              i++)
                                            itemMenuListSetup(
                                              product: ProductModel(
                                                id: i,
                                                productId:
                                                    "${menuProduct?.payload?[i].id}",
                                                productURL:
                                                    "${menuProduct?.payload?[i].image}",
                                                productName:
                                                    "${menuProduct?.payload?[i].name}",
                                                stock: menuProduct!.payload?[i]
                                                    .currentQuantity,
                                                description:
                                                    "Belum ada deskripsi",
                                                price: menuProduct
                                                    ?.payload?[i].price,
                                                discountId: menuProduct
                                                    ?.payload?[i].promo?.id,
                                                discountPrice: menuProduct
                                                            ?.payload?[i]
                                                            .promo !=
                                                        null
                                                    ? ((menuProduct!.payload?[i]
                                                                .price ??
                                                            0) -
                                                        (menuProduct
                                                                ?.payload?[i]
                                                                .promo
                                                                ?.amount ??
                                                            0))
                                                    : 0,
                                                productCategory:
                                                    "${menuProduct?.payload?[i].category?.name}",
                                                status:
                                                    "${menuProduct?.payload?[i].statusDisplay}",
                                              ),
                                            ),
                                          groupedProduct.isNotEmpty
                                              ? const SizedBox(
                                                  height: 100,
                                                )
                                              : const SizedBox(),
                                        ],
                                      ),
                                    ),
                                  ),
                          ),
                        ],
                      ),

                      // Floating card
                      context.read<ProductCartCubit>().state.isEmpty
                          ? const SizedBox()
                          : Align(
                              alignment: Alignment.bottomCenter,
                              child: GestureDetector(
                                onTap: () {
                                  ScaffoldMessenger.of(context)
                                      .hideCurrentSnackBar();
                                  Navigator.pushNamed(context,
                                          "/main-page/cashier-page/detail-order-page")
                                      .then((_) => setState(() {}));
                                },
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 36,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 15,
                                    horizontal: 33,
                                  ),
                                  decoration: BoxDecoration(
                                    color: primaryColor,
                                    borderRadius: BorderRadius.circular(999),
                                  ),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        "assets/subtract.png",
                                        width: 30,
                                        height: 30,
                                      ),
                                      const SizedBox(
                                        width: 16,
                                      ),
                                      Expanded(
                                        child: Text(
                                          "$totalCount Pesanan",
                                          style: inter.copyWith(
                                            color: Colors.white,
                                            fontWeight: medium,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        formatCurrency(totalPrice),
                                        style: inter.copyWith(
                                          color: Colors.white,
                                          fontWeight: semiBold,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
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
      },
    );
  }
}
