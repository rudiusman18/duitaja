class DetailSaleHistoryModel {
  String? message;
  Payload? payload;

  DetailSaleHistoryModel({this.message, this.payload});

  DetailSaleHistoryModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    payload =
        json['payload'] != null ? Payload.fromJson(json['payload']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (payload != null) {
      data['payload'] = payload!.toJson();
    }
    return data;
  }
}

class Payload {
  String? id;
  String? customerName;
  String? phoneNumber;
  String? note;
  String? invoiceNumber;
  String? status;
  int? tax;
  int? subTotal;
  String? createdAt;
  int? countSale;
  List<InvoiceItems>? invoiceItems;

  Payload(
      {this.id,
      this.customerName,
      this.phoneNumber,
      this.note,
      this.invoiceNumber,
      this.status,
      this.tax,
      this.subTotal,
      this.createdAt,
      this.countSale,
      this.invoiceItems});

  Payload.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerName = json['customer_name'];
    phoneNumber = json['phone_number'];
    note = json['note'];
    invoiceNumber = json['invoice_number'];
    status = json['status'];
    tax = json['tax'];
    subTotal = json['sub_total'];
    createdAt = json['created_at'];
    countSale = json['count_sale'];
    if (json['invoice_items'] != null) {
      invoiceItems = <InvoiceItems>[];
      json['invoice_items'].forEach((v) {
        invoiceItems!.add(InvoiceItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['customer_name'] = customerName;
    data['phone_number'] = phoneNumber;
    data['note'] = note;
    data['invoice_number'] = invoiceNumber;
    data['status'] = status;
    data['tax'] = tax;
    data['sub_total'] = subTotal;
    data['created_at'] = createdAt;
    data['count_sale'] = countSale;
    if (invoiceItems != null) {
      data['invoice_items'] = invoiceItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class InvoiceItems {
  String? sellableProductId;
  int? quantity;
  String? name;
  int? price;
  int? resultTotal;
  int? promoAmount;

  InvoiceItems(
      {this.sellableProductId,
      this.quantity,
      this.name,
      this.price,
      this.resultTotal,
      this.promoAmount});

  InvoiceItems.fromJson(Map<String, dynamic> json) {
    sellableProductId = json['sellable_product_id'];
    quantity = json['quantity'];
    name = json['name'];
    price = json['price'];
    resultTotal = json['result_total'];
    promoAmount = json['promo_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sellable_product_id'] = sellableProductId;
    data['quantity'] = quantity;
    data['name'] = name;
    data['price'] = price;
    data['result_total'] = resultTotal;
    data['promo_amount'] = promoAmount;
    return data;
  }
}
