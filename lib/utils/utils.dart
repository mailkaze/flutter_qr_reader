import 'package:fl_qrreader/models/scan_model.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

launchURL(BuildContext context, ScanModel scan) async {
  final Uri url = Uri.parse(scan.valor!);

  if (scan.tipo == 'http') {
    // si es una URL llamamos al paquete que abre webs
    if (!await launchUrl(url)) {
      throw 'Could not launch $url';
    }
  } else {
    // si no, abrimos mapa
    Navigator.pushNamed(context, 'mapa', arguments: scan);
  }
}
