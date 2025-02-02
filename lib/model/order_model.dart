class OrderModel {
  String? customerName;
  String? phoneNumber;
  String? paymentMethod;
  String? notes;
  int? subTotal;
  String? invoiceNumber;
  String? taxId;
  int? tax;
  bool? status;
  List<Purchaseds>? purchaseds;

  OrderModel(
      {this.customerName,
      this.phoneNumber,
      this.paymentMethod,
      this.notes,
      this.subTotal,
      this.invoiceNumber,
      this.taxId,
      this.tax,
      this.status,
      this.purchaseds});

  OrderModel.fromJson(Map<String, dynamic> json) {
    customerName = json['customer_name'];
    phoneNumber = json['phone_number'];
    paymentMethod = json['payment_method'];
    notes = json['notes'];
    subTotal = json['sub_total'];
    invoiceNumber = json['invoice_number'];
    taxId = json['tax_id'];
    tax = json['tax'];
    status = json['status'];
    if (json['purchaseds'] != null) {
      purchaseds = <Purchaseds>[];
      json['purchaseds'].forEach((v) {
        purchaseds!.add(Purchaseds.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['customer_name'] = customerName;
    data['phone_number'] = phoneNumber;
    data['payment_method'] = paymentMethod;
    data['notes'] = notes;
    data['sub_total'] = subTotal;
    data['invoice_number'] = invoiceNumber;
    data['tax_id'] = taxId;
    data['tax'] = tax;
    data['status'] = status;
    if (purchaseds != null) {
      data['purchaseds'] = purchaseds!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Purchaseds {
  String? id;
  int? qty;
  String? promoId;
  int? promoAmount;
  int? priceAll;

  Purchaseds(
      {this.id, this.qty, this.promoId, this.promoAmount, this.priceAll});

  Purchaseds.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    qty = json['qty'];
    promoId = json['promo_id'];
    promoAmount = json['promo_amount'];
    priceAll = json['price_all'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['qty'] = qty;
    data['promo_id'] = promoId;
    data['promo_amount'] = promoAmount;
    data['price_all'] = priceAll;
    return data;
  }
}
