class TopCoupon {
  String storeurl;
  String logosrc;

  TopCoupon({this.storeurl, this.logosrc});

  TopCoupon.fromJson(Map<String, dynamic> json) {
    storeurl = json['storeurl'];
    logosrc = json['logosrc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['storeurl'] = this.storeurl;
    data['logosrc'] = this.logosrc;
    return data;
  }
}
