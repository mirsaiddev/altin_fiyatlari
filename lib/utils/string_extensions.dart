import 'dart:convert';

extension StringExtension on String {
  String toEnglishOnly() {
    String result = this;
    result = result.replaceAll('ç', 'c');
    result = result.replaceAll('ı', 'i');
    result = result.replaceAll('ş', 's');
    result = result.replaceAll('ö', 'o');
    result = result.replaceAll('ü', 'u');
    result = result.replaceAll('ğ', 'g');
    return result;
  }

  String utf8convert() {
    try {
      List<int> bytes = this.toString().codeUnits;
      return utf8.decode(bytes);
    } catch (e) {
      return this;
    }
  }

  String changeG() {
    return this.replaceAll('ğ', 'g').replaceAll('Ğ', 'G');
  }

  String fixString() {
    var result;
    try {
      result = jsonDecode('"${this.replaceAll(r"\\", r"\")}"');
    } catch (e) {
      result = this;
    }

    return result;
  }
}
