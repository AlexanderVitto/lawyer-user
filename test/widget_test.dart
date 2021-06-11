// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../lib/app/src/models/models.dart' as models;

void main() {
  // testWidgets('Counter increments smoke test', (WidgetTester tester) async {
  //   // Build our app and trigger a frame.
  //   await tester.pumpWidget(MyApp());

  //   // Verify that our counter starts at 0.
  //   expect(find.text('0'), findsOneWidget);
  //   expect(find.text('1'), findsNothing);

  //   // Tap the '+' icon and trigger a frame.
  //   await tester.tap(find.byIcon(Icons.add));
  //   await tester.pump();

  //   // Verify that our counter has incremented.
  //   expect(find.text('0'), findsNothing);
  //   expect(find.text('1'), findsOneWidget);
  // });

  test('Boolean', () {
    var value = 1 / 100;

    expect(value, 0);
  });

  test('Fetching Appointment', () {
    var data = [
      {
        "Id": 91,
        "BookingCode": "qTmMWvJJ",
        "UserId": "7LZzgg7ZstX3a9Yuq2ul7xsPRb83",
        "PartnerId": "BwNpYywQKKRUggnYJlkl5x22enn1",
        "StartDate": "2021-06-04T00:00:00+07:00",
        "StartTime": "09:00:00",
        "EndDate": "2021-06-04T00:00:00+07:00",
        "EndTime": "09:30:00",
        "Notes": "I am not feeling well.",
        "AppointmentStatusId": 6,
        "AppointmentStatusDescription": "CANCELED",
        "ProductServicesId": 155,
        "ProductServiceDescription": "Cognitive Disorders",
        "MasterPriceId": 2,
        "Price": 200000.00,
        "UserFirstName": "Alexander",
        "UserLastName": "Jeanne",
        "UserMobileNumber": "085226750181",
        "UserPictureUrl":
            "https://s3.psykay.co.id/pub/7LZzgg7ZstX3a9Yuq2ul7xsPRb83.png",
        "PartnerPictureUrl":
            "https://s3.psykay.co.id/pub/BwNpYywQKKRUggnYJlkl5x22enn1.png",
        "PartnerFirstName": "Jeanne",
        "PartnerLastName": "Natasya",
        "IsRescheduled": false,
        "RescheduledByUser": false,
        "ReschedulePreId": null
      },
      {
        "Id": 142,
        "BookingCode": "MZxrG1ir",
        "UserId": "7LZzgg7ZstX3a9Yuq2ul7xsPRb83",
        "PartnerId": "BwNpYywQKKRUggnYJlkl5x22enn1",
        "StartDate": "2021-06-05T00:00:00+07:00",
        "StartTime": "16:30:00",
        "EndDate": "2021-06-05T00:00:00+07:00",
        "EndTime": "17:00:00",
        "Notes": "I am not feeling well.",
        "AppointmentStatusId": 6,
        "AppointmentStatusDescription": "CANCELED",
        "ProductServicesId": 128,
        "ProductServiceDescription": "Grieve & Loss",
        "MasterPriceId": 2,
        "Price": 200000.00,
        "UserFirstName": "Alexander",
        "UserLastName": "Jeanne",
        "UserMobileNumber": "085226750181",
        "UserPictureUrl":
            "https://s3.psykay.co.id/pub/7LZzgg7ZstX3a9Yuq2ul7xsPRb83.png",
        "PartnerPictureUrl":
            "https://s3.psykay.co.id/pub/BwNpYywQKKRUggnYJlkl5x22enn1.png",
        "PartnerFirstName": "Jeanne",
        "PartnerLastName": "Natasya",
        "IsRescheduled": false,
        "RescheduledByUser": false,
        "ReschedulePreId": null
      }
    ];

    List<models.Appointment> _appointments = [];

    data.forEach((value) {
      _appointments.add(models.Appointment.fromJson(value));
    });

    _appointments.sort((a, b) {
      var aDateTime;
      var bDataTime;

      if (a.startDate != null && b.startDate != null) {
        aDateTime =
            DateTime.parse("${a.startDate.split('T')[0]} ${a.startTime}");

        bDataTime =
            DateTime.parse("${b.startDate.split('T')[0]} ${b.startTime}");
      }

      return aDateTime.compareTo(bDataTime);
    });

    expect(_appointments.length, 2);
  });

  test('Date filter', () {
    List<Map<String, dynamic>> date = [
      {
        "UserFullName": "Alexander Jeanne",
        "PartnerFullName": "Jeanne Natasya",
        "StartSession": "04/06/2021 00.00.00 09:00:00",
        "EndSession": "04/06/2021 00.00.00 09:30:00",
        "AppointmentId": 156,
        "BookingCode": "fRU3kUmh",
        "UserId": "7LZzgg7ZstX3a9Yuq2ul7xsPRb83",
        "UserFirstName": "Alexander",
        "UserLastName": "Jeanne",
        "PartnerId": "BwNpYywQKKRUggnYJlkl5x22enn1",
        "PartnerFirstName": "Jeanne",
        "PartnerLastName": "Natasya",
        "Price": 200000.00,
        "StartDate": "2021-06-04T00:00:00+07:00",
        "StartTime": "09:00:00",
        "EndDate": "2021-06-04T00:00:00+07:00",
        "EndTime": "09:30:00",
        "AppointmentStatusId": 1,
        "AppointmentStatusDescription": "OPEN",
        "ProductServiceId": 155,
        "ProductServiceDescription": "Cognitive Disorders",
        "PriceSchemaId": 2,
        "PriceSchemaDescription": "SILVER VOICE",
        "PartnerPriceId": 149,
        "IsRescheduled": false,
        "RescheduledConfirmed": false,
        "RescheduledBookingCode": null,
        "RescheduledByUser": false,
        "ReschedulePreId": null,
        "IsOnPayment": false,
        "InvoiceNumber": null,
        "PaymentMethodId": null,
        "PaymentMethodDescription": null,
        "PaymentId": null,
        "OrderId": null,
        "TransactionId": null,
        "TransactionStatus": null,
        "TransactionStatusDescription": null,
        "PaymentType": null,
        "ToBankCode": null,
        "ToBankName": null,
        "ToAccountName": null,
        "ToAccountNumber": null,
        "PaidAmount": null,
        "ExpiredIn": "2021-06-08T15:00:00+07:00"
      },
      {
        "UserFullName": "Alexander Jeanne",
        "PartnerFullName": "Jeanne Natasya",
        "StartSession": "04/06/2021 00.00.00 09:00:00",
        "EndSession": "04/06/2021 00.00.00 09:30:00",
        "AppointmentId": 156,
        "BookingCode": "fRU3kUmh",
        "UserId": "7LZzgg7ZstX3a9Yuq2ul7xsPRb83",
        "UserFirstName": "Alexander",
        "UserLastName": "Jeanne",
        "PartnerId": "BwNpYywQKKRUggnYJlkl5x22enn1",
        "PartnerFirstName": "Jeanne",
        "PartnerLastName": "Natasya",
        "Price": 200000.00,
        "StartDate": "2021-06-04T00:00:00+07:00",
        "StartTime": "09:00:00",
        "EndDate": "2021-06-04T00:00:00+07:00",
        "EndTime": "09:30:00",
        "AppointmentStatusId": 1,
        "AppointmentStatusDescription": "OPEN",
        "ProductServiceId": 155,
        "ProductServiceDescription": "Cognitive Disorders",
        "PriceSchemaId": 2,
        "PriceSchemaDescription": "SILVER VOICE",
        "PartnerPriceId": 149,
        "IsRescheduled": false,
        "RescheduledConfirmed": false,
        "RescheduledBookingCode": null,
        "RescheduledByUser": false,
        "ReschedulePreId": null,
        "IsOnPayment": false,
        "InvoiceNumber": null,
        "PaymentMethodId": null,
        "PaymentMethodDescription": null,
        "PaymentId": null,
        "OrderId": null,
        "TransactionId": null,
        "TransactionStatus": null,
        "TransactionStatusDescription": null,
        "PaymentType": null,
        "ToBankCode": null,
        "ToBankName": null,
        "ToAccountName": null,
        "ToAccountNumber": null,
        "PaidAmount": null,
        "ExpiredIn": "2021-06-07T15:00:00+07:00"
      }
    ];

    List<Map<String, dynamic>> filtered = date
        .where((value) =>
            DateTime.now().isBefore(DateTime.tryParse(value['ExpiredIn'])))
        .toList();

    expect(filtered.length, 1);
  });
}
