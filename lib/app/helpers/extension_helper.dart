extension StringExtension on String {
  String capitalize() {
    if (this == null || this == "") return "";
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }

  String pascalCase() {
    if (this == null || this == "") return "";

    List<String> data = this.split(' ');
    List<String> stringBuilder = [];

    data.forEach((element) {
      stringBuilder.add(
          "${element[0].toUpperCase()}${element.substring(1).toLowerCase()}");
    });

    return stringBuilder.join(' ');
  }
}
