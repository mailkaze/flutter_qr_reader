import 'package:fl_qrreader/providers/scan_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DireccionesScreen extends StatelessWidget {
  const DireccionesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // en este caso sí queremos que la interfaz se recargue con los cambios
    // por lo que no ponemos el listen: false
    final scanListProvider = Provider.of<ScanListProvider>(context);
    final scans = scanListProvider.scans;

    return ListView.builder(
      itemCount: scanListProvider.scans.length,
      itemBuilder: (context, i) => ListTile(
        leading: Icon(
          Icons.turned_in_not_outlined,
          color: Theme.of(context).primaryColor,
        ),
        title: Text(scans[i].valor!),
        subtitle: Text('ID: ${scans[i].id!}'),
        trailing: Icon(
          Icons.keyboard_arrow_right,
          color: Colors.grey,
        ),
        onTap: (() {
          print('abrir algo...');
        }),
      ),
    );
  }
}
