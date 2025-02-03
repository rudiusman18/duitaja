class SaleHistoryModel {
  String? message;
  List<Payload>? payload;
  Meta? meta;

  SaleHistoryModel({this.message, this.payload, this.meta});

  SaleHistoryModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['payload'] != null) {
      payload = <Payload>[];
      json['payload'].forEach((v) {
        payload!.add(Payload.fromJson(v));
      });
    }
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (payload != null) {
      data['payload'] = payload!.map((v) => v.toJson()).toList();
    }
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    return data;
  }
}

class Payload {
  String? id;
  String? customerName;
  String? invoiceNumber;
  String? status;
  int? subTotal;
  String? createdAt;
  int? countSale;

  Payload(
      {this.id,
      this.customerName,
      this.invoiceNumber,
      this.status,
      this.subTotal,
      this.createdAt,
      this.countSale});

  Payload.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerName = json['customer_name'];
    invoiceNumber = json['invoice_number'];
    status = json['status'];
    subTotal = json['sub_total'];
    createdAt = json['created_at'];
    countSale = json['count_sale'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['customer_name'] = customerName;
    data['invoice_number'] = invoiceNumber;
    data['status'] = status;
    data['sub_total'] = subTotal;
    data['created_at'] = createdAt;
    data['count_sale'] = countSale;
    return data;
  }
}

class Meta {
  int? page;
  int? limit;
  int? totalData;
  int? totalPage;
  String? previousPage;
  String? nextPage;

  Meta(
      {this.page,
      this.limit,
      this.totalData,
      this.totalPage,
      this.previousPage,
      this.nextPage});

  Meta.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    limit = json['limit'];
    totalData = json['total_data'];
    totalPage = json['total_page'];
    previousPage = json['previous_page'];
    nextPage = json['next_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = page;
    data['limit'] = limit;
    data['total_data'] = totalData;
    data['total_page'] = totalPage;
    data['previous_page'] = previousPage;
    data['next_page'] = nextPage;
    return data;
  }
}
