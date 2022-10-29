import 'package:fl_qrreader/models/scan_model.dart';
import 'package:fl_qrreader/providers/scan_list_provider.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:fl_qrreader/providers/db_provider.dart';
import 'package:fl_qrreader/providers/ui_provider.dart';

import 'package:fl_qrreader/pages/direcciones_page.dart';
import 'package:fl_qrreader/pages/mapas_page.dart';
import 'package:fl_qrreader/widgets/custom_navigationbar.dart';
import 'package:fl_qrreader/widgets/scan_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Historial'),
        actions: [
          IconButton(
            onPressed: () {
              // en este punto no quiero que se redibuje la interfaz con cada actualizacion
              Provider.of<ScanListProvider>(context, listen: false)
                  .borarTodosLosScans();
            },
            icon: Icon(Icons.delete_forever),
          ),
        ],
        elevation: 0,
      ),
      body: _HomePageBody(),
      bottomNavigationBar: CustomNavigationBar(),
      floatingActionButton: ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _HomePageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);

    final currentIndex = uiProvider.selectedMenuOpt;

    // final tempScan = ScanModel(valor: 'http://google.com');
    // DBProvider.db.nuevoScan(tempScan);
    // DBProvider.db
    //     .getScanById(3)
    //     .then((scan) => print('traigo este dato: ${scan?.valor}'));
    // DBProvider.db.getTodosLosScans().then(print);

    // en este punto no quiero que se redibuje la interfaz con cada actualizacion
    final scanListProvider =
        Provider.of<ScanListProvider>(context, listen: false);

    switch (currentIndex) {
      case 0:
        scanListProvider.cargarScansPorTipo('geo');
        return MapasScreen();
      case 1:
        scanListProvider.cargarScansPorTipo('http');
        return DireccionesScreen();
      default:
        return MapasScreen();
    }
  }
}
