import 'package:fl_qrreader/models/scan_model.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:fl_qrreader/providers/db_provider.dart';
import 'package:fl_qrreader/providers/ui_provider.dart';

import 'package:fl_qrreader/pages/direcciones_page.dart';
import 'package:fl_qrreader/pages/mapas_page.dart';
import 'package:fl_qrreader/widget/custom_navigationbar.dart';
import 'package:fl_qrreader/widget/scan_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Historial'),
        actions: [
          IconButton(
            onPressed: () {},
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

    final tempScan = ScanModel(valor: 'http://google.com');
    // DBProvider.db.nuevoScan(tempScan);
    // DBProvider.db
    //     .getScanById(3)
    //     .then((scan) => print('traigo este dato: ${scan?.valor}'));
    DBProvider.db.getTodosLosScans().then(print);

    switch (currentIndex) {
      case 0:
        return MapasScreen();
      case 1:
        return DireccionesScreen();
      default:
        return MapasScreen();
    }
  }
}
