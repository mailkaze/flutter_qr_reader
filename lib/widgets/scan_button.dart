import 'package:fl_qrreader/providers/scan_list_provider.dart';
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
        // String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        //     "#3D8BEF", "Cancelar", false, ScanMode.QR);
        final barcodeScanRes = 'geo: hrfu ghorfiu huiofr ';

        // me encuentro dentro de una función o método, por lo que no necesito que se
        // vuelva a redibujar la interfaz
        final scanListProvider =
            Provider.of<ScanListProvider>(context, listen: false);
        scanListProvider.nuevoScan(barcodeScanRes);
      },
      child: Icon(Icons.filter_center_focus),
    );
  }
}
