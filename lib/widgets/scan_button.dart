import 'package:fl_qrreader/providers/scan_list_provider.dart';
import 'package:fl_qrreader/utils/utils.dart';
import 'package:flutter/material.dart';

import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';

class ScanButton extends StatelessWidget {
  const ScanButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      onPressed: () async {
        String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
            "#3D8BEF", "Cancelar", false, ScanMode.QR);
        // const barcodeScanRes = 'https://fernando-herrera.com';
        // const barcodeScanRes = 'geo:42.242795,-8.723454';

        // si el usuario cancela, la respuesta del lector QR es -1
        if (barcodeScanRes == '-1') {
          return;
        }

        // me encuentro dentro de una función o método, por lo que no necesito
        // que se vuelva a redibujar la interfaz
        final scanListProvider =
            Provider.of<ScanListProvider>(context, listen: false);

        final nuevoScan = await scanListProvider.nuevoScan(barcodeScanRes);

        launchURL(context, nuevoScan);
      },
      child: Icon(Icons.filter_center_focus),
    );
  }
}
