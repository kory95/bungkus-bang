class VendorUserModel {
  final bool? approved;

  final String? vendorId;

  final String? bussinessName;

  final String? cityValue;

  final String? countryValue;

  final String? accountName;
  final String? accountNumber;
  final String? bankName;

  final String? phoneNumber;

  final String? stateValue;
  final String? storeImage;

  VendorUserModel(
      {required this.approved,
      required this.vendorId,
      required this.bussinessName,
      required this.cityValue,
      required this.countryValue,
      required this.accountName,
      required this.phoneNumber,
      required this.stateValue,
      required this.storeImage,
      required this.accountNumber,
      required this.bankName});

  VendorUserModel.fromJson(Map<String, Object?> json)
      : this(
          approved: json['approved']! as bool,
          vendorId: json['vendorId']! as String,
          bussinessName: json['bussinessName']! as String,
          cityValue: json['cityValue']! as String,
          countryValue: json['countryValue']! as String,
          accountName: json['accountName']! as String,
          phoneNumber: json['phoneNumber']! as String,
          stateValue: json['stateValue']! as String,
          storeImage: json['storeImage']! as String,
          accountNumber: json['accountNumber']! as String,
          bankName: json['bankName']! as String,
        );

  Map<String, Object?> toJson() {
    return {
      'approved': approved,
      'vendorId': vendorId,
      'bussinessName': bussinessName,
      'cityValue': cityValue,
      'countryValue': countryValue,
      'accountName': accountName,
      'phoneNumber': phoneNumber,
      'stateValue': stateValue,
      'storeImage': storeImage,
      'accountNumber': accountNumber,
      'bankName': bankName,
    };
  }
}
