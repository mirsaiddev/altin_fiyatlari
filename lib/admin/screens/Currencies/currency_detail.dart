import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';

class CurrencyDetail extends StatefulWidget {
  const CurrencyDetail({Key? key, required this.currency}) : super(key: key);

  final Map currency;

  @override
  State<CurrencyDetail> createState() => _CurrencyDetailState();
}

class _CurrencyDetailState extends State<CurrencyDetail> {
  String? content;
  Future<void> getCurrencyContent() async {
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await FirebaseFirestore.instance
            .collection('curencies')
            .doc('curencies')
            .get();
    Map data = documentSnapshot.data() as Map;
    print('data: $data');
    content = data[widget.currency['code']] ?? '';
    Future.delayed(const Duration(milliseconds: 1000), () {
      htmlController.setText(content ?? '');
    });
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getCurrencyContent();
    });
  }

  HtmlEditorController htmlController = HtmlEditorController();

  void saveCurrencyContent() async {
    await FirebaseFirestore.instance
        .collection('curencies')
        .doc('curencies')
        .update({widget.currency['code']: await htmlController.getText()}).then(
            (value) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Saved'),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.currency['ShortName']),
        actions: [
          IconButton(
            onPressed: () {
              saveCurrencyContent();
            },
            icon: Icon(Icons.save),
          )
        ],
      ),
      body: HtmlEditor(
        controller: htmlController, //required
        htmlEditorOptions: HtmlEditorOptions(
          hint: "Your text here...",

          //initalText: "text content initial, if any",
        ),
        otherOptions: OtherOptions(
          height: 400,
        ),
      ),
    );
  }
}
