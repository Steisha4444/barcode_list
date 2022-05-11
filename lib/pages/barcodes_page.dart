import 'package:flutter/material.dart';
import '../models/barcode.dart';

class BarcodesPage extends StatefulWidget {
  const BarcodesPage({Key? key}) : super(key: key);

  @override
  State<BarcodesPage> createState() => _BarcodesPageState();
}

class _BarcodesPageState extends State<BarcodesPage> {
  void handleTapBarcode(idx) {
    showDialog(context: context, builder: (_) => ModalBarcode(barcode[idx]));
  }

  List<Barcode> barcode = [Barcode("code", "12345678")];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
  const ModalBarcode(this.barcode, {Key? key}) : super(key: key);
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
          barcode.comment == null
              ? const TextField(
                  decoration: InputDecoration(border: OutlineInputBorder()),
                )
              : Text(barcode.comment!),
        ]),
      ),
    );
  }
}
