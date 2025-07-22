// ignore_for_file: prefer_collection_literals, unnecessary_getters_setters

class DashboardModel {
  String? _message;
  Payload? _payload;

  DashboardModel({String? message, Payload? payload}) {
    if (message != null) {
      _message = message;
    }
    if (payload != null) {
      _payload = payload;
    }
  }

  String? get message => _message;
  set message(String? message) => _message = message;
  Payload? get payload => _payload;
  set payload(Payload? payload) => _payload = payload;

  DashboardModel.fromJson(Map<String, dynamic> json) {
    _message = json['message'];
    _payload =
        json['payload'] != null ? Payload.fromJson(json['payload']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['message'] = _message;
    if (_payload != null) {
      data['payload'] = _payload!.toJson();
    }
    return data;
  }
}

class Payload {
  int? _salesThisMonth;
  int? _salesThisDay;
  int? _lastMonthComparison;
  int? _lastDayComparison;
  String? _bestSellingProduct;
  int? _numberOfBestSellingProductSold;

  Payload(
      {int? salesThisMonth,
      int? salesThisDay,
      int? lastMonthComparison,
      int? lastDayComparison,
      String? bestSellingProduct,
      int? numberOfBestSellingProductSold}) {
    if (salesThisMonth != null) {
      _salesThisMonth = salesThisMonth;
    }
    if (salesThisDay != null) {
      _salesThisDay = salesThisDay;
    }
    if (lastMonthComparison != null) {
      _lastMonthComparison = lastMonthComparison;
    }
    if (lastDayComparison != null) {
      _lastDayComparison = lastDayComparison;
    }
    if (bestSellingProduct != null) {
      _bestSellingProduct = bestSellingProduct;
    }
    if (numberOfBestSellingProductSold != null) {
      _numberOfBestSellingProductSold = numberOfBestSellingProductSold;
    }
  }

  int? get salesThisMonth => _salesThisMonth;
  set salesThisMonth(int? salesThisMonth) => _salesThisMonth = salesThisMonth;
  int? get salesThisDay => _salesThisDay;
  set salesThisDay(int? salesThisDay) => _salesThisDay = salesThisDay;
  int? get lastMonthComparison => _lastMonthComparison;
  set lastMonthComparison(int? lastMonthComparison) =>
      _lastMonthComparison = lastMonthComparison;
  int? get lastDayComparison => _lastDayComparison;
  set lastDayComparison(int? lastDayComparison) =>
      _lastDayComparison = lastDayComparison;
  String? get bestSellingProduct => _bestSellingProduct;
  set bestSellingProduct(String? bestSellingProduct) =>
      _bestSellingProduct = bestSellingProduct;
  int? get numberOfBestSellingProductSold => _numberOfBestSellingProductSold;
  set numberOfBestSellingProductSold(int? numberOfBestSellingProductSold) =>
      _numberOfBestSellingProductSold = numberOfBestSellingProductSold;

  Payload.fromJson(Map<String, dynamic> json) {
    _salesThisMonth = json['sales_this_month'];
    _salesThisDay = json['sales_this_day'];
    _lastMonthComparison = json['last_month_comparison'];
    _lastDayComparison = json['last_day_comparison'];
    _bestSellingProduct = json['best_selling_product'];
    _numberOfBestSellingProductSold =
        json['number_of_best_selling_product_sold'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['sales_this_month'] = _salesThisMonth;
    data['sales_this_day'] = _salesThisDay;
    data['last_month_comparison'] = _lastMonthComparison;
    data['last_day_comparison'] = _lastDayComparison;
    data['best_selling_product'] = _bestSellingProduct;
    data['number_of_best_selling_product_sold'] =
        _numberOfBestSellingProductSold;
    return data;
  }
}
