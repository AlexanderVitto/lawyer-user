import 'package:json_annotation/json_annotation.dart';

part 'midtrans.g.dart';

@JsonSerializable(explicitToJson: true)
class MidtransResponse {
  @JsonKey(name: 'order_id', defaultValue: null, includeIfNull: false)
  final String orderId;
  @JsonKey(name: 'transaction_id', defaultValue: null, includeIfNull: false)
  final String transactionId;

  @JsonKey(name: 'status', defaultValue: null, includeIfNull: false)
  final String status;

  @JsonKey(name: 'payment_type', defaultValue: null, includeIfNull: false)
  final String paymentType;

  @JsonKey(name: 'permata_va_number', defaultValue: null, includeIfNull: false)
  final String permataVaNumber;

  @JsonKey(name: 'bca_va_number', defaultValue: null, includeIfNull: false)
  final String bcaVaNumber;

  @JsonKey(name: 'bni_va_number', defaultValue: null, includeIfNull: false)
  final String bniVaNumber;

  @JsonKey(name: 'bri_va_number', defaultValue: null, includeIfNull: false)
  final String briVaNumber;

  @JsonKey(name: 'payment_code', defaultValue: null, includeIfNull: false)
  final String paymentCode;

  @JsonKey(name: 'bank', defaultValue: null, includeIfNull: false)
  final String bank;

  MidtransResponse(
      {this.orderId,
      this.transactionId,
      this.status,
      this.paymentType,
      this.permataVaNumber,
      this.bcaVaNumber,
      this.bniVaNumber,
      this.briVaNumber,
      this.paymentCode,
      this.bank});

  factory MidtransResponse.fromJson(Map<String, dynamic> json) =>
      _$MidtransResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MidtransResponseToJson(this);
}
