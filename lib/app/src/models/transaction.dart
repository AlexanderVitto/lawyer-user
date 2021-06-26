import '../../../enum.dart';

class TransactionType {
  final String name;
  final String image;
  final TransactionScreenTab filterBy;
  bool isSelected;

  TransactionType(
      {this.name, this.image, this.filterBy, this.isSelected = false});
}
