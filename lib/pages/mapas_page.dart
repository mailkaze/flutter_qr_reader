import 'package:fl_qrreader/providers/scan_list_provider.dart';
import 'package:fl_qrreader/widgets/scans_list.dart';
import 'package:flutter/material.dart';

class MapasScreen extends StatelessWidget {
  const MapasScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ScansList(tipo: 'geo');
  }
}
