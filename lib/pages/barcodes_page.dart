import 'package:flutter/material.dart';
import '../models/barcode.dart';

class BarcodesPage extends StatefulWidget {
  const BarcodesPage({Key? key}) : super(key: key);

  @override
  State<BarcodesPage> createState() => _BarcodesPageState();
}

class _BarcodesPageState extends State<BarcodesPage> {
  void handleTapBarcode(idx) {
    showDialog(
        context: context,
        builder: (_) => ModalBarcode(
              barcode[idx],
              (comment) => onAddComment(comment, idx),
            ));
  }

  void handleAddBarcode() {
    showDialog(
        context: context,
        builder: (_) => BarcodeForm(
               onAddBarcode,
            ));
  }

  void onAddComment(String comment, int idx) {
    if (comment.trim().isEmpty) return;

    setState(() {
      barcode[idx].comment = comment;
    });
  }

  void onAddBarcode(String code, String name) {
    if (code.trim().isEmpty && name.trim().isEmpty) return;

    setState(() {
      barcode.add(Barcode(code, name));
    });
  }

  List<Barcode> barcode = [Barcode("code", "12345678")];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: IconButton(
          icon: const Icon(Icons.add), onPressed: () => handleAddBarcode()),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: barcode.length,
          itemBuilder: (BuildContext context, int index) => GestureDetector(
            onTap: () => handleTapBarcode(index),
            child: Card(
                child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Штрихкод"),
                  const SizedBox(height: 10),
                  Text(barcode[index].code),
                  const SizedBox(height: 10),
                  Text(barcode[index].name),
                  const SizedBox(height: 10),
                  if (barcode[index].comment != null)
                    Text(barcode[index].comment!),
                ],
              ),
            )),
          ),
        ),
      ),
    );
  }
}

class ModalBarcode extends StatelessWidget {
  final Barcode barcode;
  final comment = TextEditingController();
  final void Function(String) onSave;

  ModalBarcode(this.barcode, this.onSave, {Key? key}) : super(key: key);

  void handleAdd(context) {
    onSave(comment.text);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const Text("Штрихкод"),
          const SizedBox(height: 20),
          Text(barcode.code),
          const SizedBox(height: 20),
          if (barcode.comment == null) ...[
            TextField(
              controller: comment,
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),
            TextButton(
                onPressed: () => handleAdd(context), child: const Text("Зберегти"))
          ] else
            Text(barcode.comment!),
        ]),
      ),
    );
  }
}

class BarcodeForm extends StatelessWidget {
  final code = TextEditingController();
  final name = TextEditingController();
  final void Function(String, String) onAdd;

  BarcodeForm(this.onAdd, {Key? key}) : super(key: key);

  void handleAddBarcode(context) {
    onAdd(code.text, name.text);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: code,
            decoration: const InputDecoration(
                border: OutlineInputBorder(), labelText: "код"),
          ),
          const SizedBox(height: 30),
          TextField(
            controller: name,
            decoration: const InputDecoration(
                border: OutlineInputBorder(), labelText: "назва"),
          ),
          const SizedBox(height: 30),
          TextButton(
              onPressed: () => handleAddBarcode(context), child: const Text("Додати"))
        ],
      ),
    ));
  }
}
