import 'package:cached_network_image/cached_network_image.dart';
import 'package:duitaja/cubit/auth_cubit.dart';
import 'package:duitaja/cubit/cashier_cubit.dart';
import 'package:duitaja/cubit/filter_cubit.dart';
import 'package:duitaja/cubit/page_cubit.dart';
import 'package:duitaja/cubit/product_cubit.dart';
import 'package:duitaja/cubit/stock_management_cubit.dart';
import 'package:duitaja/model/product_model.dart';
import 'package:duitaja/model/stock_management_model.dart';
import 'package:duitaja/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class StockPage extends StatefulWidget {
  bool clearFilterCubit = false;
  StockPage({super.key, required this.clearFilterCubit});

  @override
  State<StockPage> createState() => _StockPageState();
}

class _StockPageState extends State<StockPage> {
  TextEditingController searchTextField = TextEditingController(text: "");
  StockManagementModel? stockManagementModel;
  int stockPage = 1;
  String? categoryId;

  @override
  void initState() {
    context.read<StockManagementCubit>().stockManagementData(
          token: context.read<AuthCubit>().token ?? "",
          categoryId: '',
          inStatus: '',
          limit: '100',
          page: '$stockPage',
          search: '',
        );
    context.read<IndexCashierFilterCubit>().category(
          token: context.read<AuthCubit>().token ?? "",
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.clearFilterCubit == true) {
      final _ = context.read<FilterCubit>().setFilter({});
      widget.clearFilterCubit = false;
    }

    Widget searchSetup() {
      return Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: TextFormField(
          controller: searchTextField,
          onChanged: (text) {
            if (text == "") {
              stockManagementModel = null;
              stockPage = 1;
              context.read<StockManagementCubit>().stockManagementData(
                    token: context.read<AuthCubit>().token ?? "",
                    categoryId: categoryId ?? '',
                    inStatus: (context
                                        .read<FilterCubit>()
                                        .state['Status']
                                        ?.first ??
                                    '')
                                .toLowerCase() ==
                            'aktif'
                        ? 'active'
                        : (context.read<FilterCubit>().state['Status']?.first ??
                                        '')
                                    .toLowerCase() ==
                                'non-aktif'
                            ? 'inactive'
                            : (context
                                                .read<FilterCubit>()
                                                .state['Status']
                                                ?.first ??
                                            '')
                                        .toLowerCase() ==
                                    'habis'
                                ? 'empty'
                                : '',
                    limit: '100',
                    page: '$stockPage',
                    search: searchTextField.text,
                  );
              context.read<IndexCashierFilterCubit>().category(
                    token: context.read<AuthCubit>().token ?? "",
                  );
            }
          },
          onEditingComplete: () {
            stockManagementModel = null;
            stockPage = 1;
            context.read<StockManagementCubit>().stockManagementData(
                  token: context.read<AuthCubit>().token ?? "",
                  categoryId: categoryId ?? '',
                  inStatus:
                      (context.read<FilterCubit>().state['Status']?.first ?? '')
                                  .toLowerCase() ==
                              'aktif'
                          ? 'active'
                          : (context
                                              .read<FilterCubit>()
                                              .state['Status']
                                              ?.first ??
                                          '')
                                      .toLowerCase() ==
                                  'non-aktif'
                              ? 'inactive'
                              : (context
                                                  .read<FilterCubit>()
                                                  .state['Status']
                                                  ?.first ??
                                              '')
                                          .toLowerCase() ==
                                      'habis'
                                  ? 'empty'
                                  : '',
                  limit: '100',
                  page: '$stockPage',
                  search: searchTextField.text,
                );
            context.read<IndexCashierFilterCubit>().category(
                  token: context.read<AuthCubit>().token ?? "",
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
            hintText: "Cari Menu...",
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

    Widget generateFilterContentItem({
      required BuildContext context,
      required String groupName,
      required String name,
      required String id,
    }) {
      return StatefulBuilder(
        builder: (context, stateSetter) {
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
                  horizontal: 41,
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    context.read<PreviousPageCubit>().setPage(1);
                    context.read<PageCubit>().setPage(1);

                    var filterList = context.read<FilterCubit>().state;

                    if (context
                            .read<FilterCubit>()
                            .state[groupName]
                            ?.contains(name) ??
                        false) {
                      filterList[groupName]!.remove(name);
                      if (filterList[groupName]!.isEmpty) {
                        filterList.remove(groupName);
                        if (groupName.toLowerCase() == 'kategori') {
                          categoryId = null;
                        }
                      }
                    } else {
                      filterList.putIfAbsent(groupName, () => []).clear();
                      filterList.putIfAbsent(groupName, () => []).add(name);
                    }

                    context.read<FilterCubit>().setFilter(filterList);
                    if (groupName.toLowerCase() == 'kategori') {
                      categoryId = id;
                    }
                    stockManagementModel = null;
                    stockPage = 1;
                    context.read<StockManagementCubit>().stockManagementData(
                          token: context.read<AuthCubit>().token ?? "",
                          categoryId: categoryId ?? '',
                          inStatus: (context
                                              .read<FilterCubit>()
                                              .state['Status']
                                              ?.first ??
                                          '')
                                      .toLowerCase() ==
                                  'aktif'
                              ? 'active'
                              : (context
                                                  .read<FilterCubit>()
                                                  .state['Status']
                                                  ?.first ??
                                              '')
                                          .toLowerCase() ==
                                      'non-aktif'
                                  ? 'inactive'
                                  : (context
                                                      .read<FilterCubit>()
                                                      .state['Status']
                                                      ?.first ??
                                                  '')
                                              .toLowerCase() ==
                                          'habis'
                                      ? 'empty'
                                      : '',
                          limit: '100',
                          page: '$stockPage',
                          search: searchTextField.text,
                        );

                    setState(() {});
                    stateSetter(() {});
                  },
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          name,
                        ),
                      ),
                      Container(
                        width: 22,
                        height: 22,
                        decoration: BoxDecoration(
                          color: (context
                                      .read<FilterCubit>()
                                      .state[groupName]
                                      ?.contains(name) ??
                                  false)
                              ? primaryColor
                              : greyColor1,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: (context
                                    .read<FilterCubit>()
                                    .state[groupName]
                                    ?.contains(name) ??
                                false)
                            ? const Icon(
                                Icons.check,
                                color: Colors.white,
                              )
                            : const SizedBox(),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              Divider(
                height: 1,
                thickness: 1,
                color: greyColor1,
              ),
            ],
          );
        },
      );
    }

// ignore: no_leading_underscores_for_local_identifiers
    void _showBottomSheet(BuildContext context, {required String title}) {
      showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        isScrollControlled:
            true, // To make the sheet adjustable for larger content
        builder: (context) {
          return SizedBox(
            height: 472,
            child: Column(
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
                    horizontal: 11,
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.close,
                        ),
                      ),
                      const SizedBox(
                        width: 11,
                      ),
                      Text(
                        "Pilih $title",
                        style: inter.copyWith(
                          fontSize: 20,
                          fontWeight: semiBold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Expanded(
                  child: ListView(
                    children: [
                      if (title.toLowerCase() == "kategori") ...{
                        for (var index = 0;
                            index <
                                (context
                                        .read<IndexCashierFilterCubit>()
                                        .cashierCategoryModel
                                        .payload
                                        ?.length ??
                                    0);
                            index++) ...{
                          generateFilterContentItem(
                              groupName: title,
                              name: context
                                      .read<IndexCashierFilterCubit>()
                                      .cashierCategoryModel
                                      .payload?[index]
                                      .name ??
                                  "",
                              context: context,
                              id: context
                                      .read<IndexCashierFilterCubit>()
                                      .cashierCategoryModel
                                      .payload?[index]
                                      .id ??
                                  ''),
                        },
                      } else ...{
                        generateFilterContentItem(
                          groupName: title,
                          name: "Aktif",
                          context: context,
                          id: '',
                        ),
                        generateFilterContentItem(
                          groupName: title,
                          name: "Non-Aktif",
                          context: context,
                          id: '',
                        ),
                        generateFilterContentItem(
                          groupName: title,
                          name: "Habis",
                          context: context,
                          id: '',
                        ),
                      },
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          );
        },
      );
    }

    Widget generateFilterItem(
        {required String groupName, required String title}) {
      return GestureDetector(
        onTap: () {
          _showBottomSheet(
            context,
            title: groupName,
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 8,
          ),
          decoration: BoxDecoration(
            color:
                (context.read<FilterCubit>().state[groupName]?.isEmpty ?? true)
                    ? Colors.transparent
                    : primaryColor,
            border: Border.all(
              color: disableColor,
            ),
            borderRadius: BorderRadius.circular(
              8,
            ),
          ),
          child: Row(
            children: [
              Text(
                title,
                style: inter.copyWith(
                  color:
                      (context.read<FilterCubit>().state[groupName]?.isEmpty ??
                              true)
                          ? primaryColor
                          : Colors.white,
                  fontWeight: medium,
                ),
              ),
              Icon(
                Icons.keyboard_arrow_down_rounded,
                color: (context.read<FilterCubit>().state[groupName]?.isEmpty ??
                        true)
                    ? disableColor
                    : Colors.white,
              )
            ],
          ),
        ),
      );
    }

    Widget generateListProductItem({
      required ProductModel product,
    }) {
      return GestureDetector(
        onTap: () {
          context.read<ProductCubit>().setProduct(product);
          Navigator.pushNamed(context, '/stock-page/stock-detail-page');
        },
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 20,
          ),
          decoration: BoxDecoration(
              border: Border.all(
            color: greyColor1,
          )),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: CachedNetworkImage(
                  width: 72,
                  height: 72,
                  imageUrl: product.productURL ?? "",
                  errorWidget: (context, url, error) => Image.asset(
                    "assets/no-image.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        product.productCategory ?? "",
                        style: inter.copyWith(
                          fontWeight: semiBold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        product.productName ?? "",
                        style: inter.copyWith(
                          fontSize: 15,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Row(
                        children: [
                          Text(
                            "Stok: ",
                            style: inter.copyWith(
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            "${product.stock}",
                            style: inter.copyWith(
                              fontSize: 15,
                              fontWeight: semiBold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 11,
                    ),
                    decoration: BoxDecoration(
                      color: (product.status ?? "").toLowerCase() != "aktif"
                          ? Colors.red
                          : greyColor1,
                      borderRadius: BorderRadius.circular(
                        999,
                      ),
                    ),
                    child: Text(
                      product.status ?? "",
                      style: inter.copyWith(
                        fontSize: 15,
                        fontWeight: semiBold,
                        color: (product.status ?? "").toLowerCase() != "aktif"
                            ? Colors.white
                            : primaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Icon(
                    Icons.chevron_right,
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }

    return BlocConsumer<StockManagementCubit, StockManagementState>(
      listener: (context, state) {
        if (state is StockManagementTokenExpired) {
          context.read<AuthCubit>().logout();
          Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
        }

        if (state is StockManagementSuccess) {
          if (stockManagementModel == null) {
            stockManagementModel =
                context.read<StockManagementCubit>().stockManagementModel;
          } else {
            stockManagementModel!.payload?.addAll(context
                    .read<StockManagementCubit>()
                    .stockManagementModel
                    .payload
                    ?.toList() ??
                []);
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: primaryColor,
            title: Text(
              "Manajemen Stok",
              style: inter.copyWith(
                fontWeight: medium,
                fontSize: 20,
              ),
            ),
            leading: const SizedBox(),
            centerTitle: true,
          ),
          body: Column(
            children: [
              const SizedBox(
                height: 24,
              ),
              searchSetup(),
              const SizedBox(
                height: 24,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Row(
                      children: [
                        if (context.read<FilterCubit>().state.isNotEmpty) ...{
                          GestureDetector(
                            onTap: () {
                              var filterList =
                                  context.read<FilterCubit>().state;
                              filterList.clear();
                              context.read<FilterCubit>().setFilter(filterList);
                              categoryId = null;
                              stockManagementModel = null;
                              stockPage = 1;
                              context
                                  .read<StockManagementCubit>()
                                  .stockManagementData(
                                    token:
                                        context.read<AuthCubit>().token ?? "",
                                    categoryId: '',
                                    inStatus: (context
                                                        .read<FilterCubit>()
                                                        .state['Status']
                                                        ?.first ??
                                                    '')
                                                .toLowerCase() ==
                                            'aktif'
                                        ? 'active'
                                        : (context
                                                            .read<FilterCubit>()
                                                            .state['Status']
                                                            ?.first ??
                                                        '')
                                                    .toLowerCase() ==
                                                'non-aktif'
                                            ? 'inactive'
                                            : (context
                                                                .read<
                                                                    FilterCubit>()
                                                                .state['Status']
                                                                ?.first ??
                                                            '')
                                                        .toLowerCase() ==
                                                    'habis'
                                                ? 'empty'
                                                : '',
                                    limit: '100',
                                    page: '$stockPage',
                                    search: searchTextField.text,
                                  );
                              setState(() {});
                            },
                            child: Container(
                              padding: const EdgeInsets.all(
                                6,
                              ),
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(
                                  8,
                                ),
                              ),
                              child: const Icon(
                                Icons.close,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 24,
                          ),
                        },
                        generateFilterItem(
                          groupName: "Kategori",
                          title: (context
                                      .read<FilterCubit>()
                                      .state["Kategori"]
                                      ?.isEmpty ??
                                  true)
                              ? "Kategori"
                              : "${context.read<FilterCubit>().state["Kategori"]}"
                                  .replaceAll("[", "")
                                  .replaceAll("]", ""),
                        ),
                        const SizedBox(
                          width: 24,
                        ),
                        generateFilterItem(
                          groupName: "Status",
                          title: (context
                                      .read<FilterCubit>()
                                      .state["Status"]
                                      ?.isEmpty ??
                                  true)
                              ? "Status"
                              : "${context.read<FilterCubit>().state["Status"]}"
                                  .replaceAll("[", "")
                                  .replaceAll("]", ""),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Expanded(
                child: state is StockManagementLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      )
                    : state is StockManagementFailure ||
                            (context
                                    .read<StockManagementCubit>()
                                    .stockManagementModel
                                    .payload
                                    ?.isEmpty ??
                                true)
                        ? Center(
                            child: Text(
                              'Data tidak ditemukan',
                              style: inter,
                            ),
                          )
                        : NotificationListener(
                            onNotification:
                                (ScrollEndNotification notification) {
                              if (stockPage !=
                                  context
                                      .read<StockManagementCubit>()
                                      .stockManagementModel
                                      .meta
                                      ?.totalPage) {
                                stockPage += 1;
                                stockManagementModel = null;
                                stockPage = 1;
                                context
                                    .read<StockManagementCubit>()
                                    .stockManagementData(
                                      token:
                                          context.read<AuthCubit>().token ?? "",
                                      categoryId: categoryId ?? '',
                                      inStatus: (context
                                                          .read<FilterCubit>()
                                                          .state['Status']
                                                          ?.first ??
                                                      '')
                                                  .toLowerCase() ==
                                              'aktif'
                                          ? 'active'
                                          : (context
                                                              .read<
                                                                  FilterCubit>()
                                                              .state['Status']
                                                              ?.first ??
                                                          '')
                                                      .toLowerCase() ==
                                                  'non-aktif'
                                              ? 'inactive'
                                              : (context
                                                                  .read<
                                                                      FilterCubit>()
                                                                  .state[
                                                                      'Status']
                                                                  ?.first ??
                                                              '')
                                                          .toLowerCase() ==
                                                      'habis'
                                                  ? 'empty'
                                                  : '',
                                      limit: '100',
                                      page: '$stockPage',
                                      search: searchTextField.text,
                                    );
                                context
                                    .read<IndexCashierFilterCubit>()
                                    .category(
                                      token:
                                          context.read<AuthCubit>().token ?? "",
                                    );
                              }

                              return true;
                            },
                            child: ListView(
                              children: [
                                for (var index = 0;
                                    index <
                                        (stockManagementModel!
                                                .payload?.length ??
                                            0);
                                    index++) ...{
                                  generateListProductItem(
                                    product: ProductModel(
                                      id: index,
                                      productId:
                                          "${stockManagementModel!.payload?[index].id}",
                                      productURL:
                                          "${stockManagementModel!.payload?[index].image}",
                                      productName:
                                          "${stockManagementModel!.payload?[index].name}",
                                      stock: stockManagementModel!
                                          .payload?[index].currentQuantity,
                                      description: "Belum ada deskripsi",
                                      price: stockManagementModel!
                                          .payload?[index].price,
                                      discountPrice: stockManagementModel!
                                                  .payload?[index].promo !=
                                              null
                                          ? ((stockManagementModel!
                                                      .payload?[index].price ??
                                                  0) -
                                              (stockManagementModel!
                                                      .payload?[index]
                                                      .promo
                                                      ?.amount ??
                                                  0))
                                          : 0,
                                      discountId: stockManagementModel!
                                          .payload?[index].promo?.id,
                                      productCategory: stockManagementModel!
                                          .payload?[index].category?.name,
                                      status: stockManagementModel!
                                          .payload?[index].statusDisplay,
                                    ),
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
  }
}
