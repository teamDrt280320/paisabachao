class StoreDetailsModal {
  dynamic logo;
  dynamic link;
  dynamic name;
  List<Coupon> coupon;
  dynamic totalcoupons;

  StoreDetailsModal(
      {this.logo, this.link, this.name, this.coupon, this.totalcoupons});

  StoreDetailsModal.fromJson(Map<dynamic, dynamic> json) {
    logo = json['logo'];
    link = json['link'];
    name = json['name'];
    if (json['coupon'] != null) {
      coupon = [];
      json['coupon'].forEach((v) {
        coupon.add(new Coupon.fromJson(v));
      });
    }
    totalcoupons = json['totalcoupons'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['logo'] = this.logo;
    data['link'] = this.link;
    data['name'] = this.name;
    if (this.coupon != null) {
      data['coupon'] = this.coupon.map((v) => v.toJson()).toList();
    }
    data['totalcoupons'] = this.totalcoupons;
    return data;
  }
}

class Coupon {
  dynamic couponcode;
  dynamic dicount;
  dynamic description;

  Coupon({this.couponcode, this.dicount, this.description});

  Coupon.fromJson(Map<dynamic, dynamic> json) {
    couponcode = json['couponcode'];
    dicount = json['dicount'];
    description = json['description'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['couponcode'] = this.couponcode;
    data['dicount'] = this.dicount;
    data['description'] = this.description;
    return data;
  }
}
