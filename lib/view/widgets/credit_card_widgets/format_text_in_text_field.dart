import 'package:flutter/services.dart';

class TextInputFormateCard extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var text = newValue.text.replaceAll(" ", "");

    var newText = "";
    for (int i = 0; i < text.length; i++) {
      newText += text[i];
    }
    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
