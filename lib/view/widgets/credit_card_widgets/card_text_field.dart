import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class CardTextField extends StatelessWidget {
  const CardTextField({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class FormateTextFiled extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    List<String> groups = [];
    var text = newValue.text.replaceAll(" ", "");
    var newText = '';
    for (int i = 0; i < text.length; i++) {
      newText += text[i];
      if ((i + 1) % 4 == 0 && i != newText.length - 1) newText += " ";
    }
    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
