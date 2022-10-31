import 'package:fl_qrreader/models/scan_model.dart';
import 'package:fl_qrreader/providers/db_provider.dart';
import 'package:flutter/material.dart';

class ScanListProvider extends ChangeNotifier {
  // dado que necesitamos actualizar nuestra interfaz al tener cambios en
  // la lista de scans, tenemos que extender del ChangeNotifier y el
  // db_provider no hacía eso

  List<ScanModel> scans = [];
  String tipoSeleccionado = 'http';

  Future<ScanModel> nuevoScan(String valor) async {
    final nuevoScan = ScanModel(valor: valor);
    final id = await DBProvider.db.nuevoScan(nuevoScan);
    // La DB le genera automáticamente el ID, lo traigo y se lo pongo
    // al modelo que estoy creando
    nuevoScan.id = id;

    // solo actualizamos la lista y recargamos la interfaz si nos
    // encontramos en la lista a la que se va a agregar el dato:
    if (tipoSeleccionado == nuevoScan.tipo) {
      scans.add(nuevoScan);

      notifyListeners();
    }

    return nuevoScan;
  }

  cargarScans() async {
    final scans = await DBProvider.db.getTodosLosScans();
    this.scans = [...scans];

    notifyListeners();
  }

  cargarScansPorTipo(String tipo) async {
    final scans = await DBProvider.db.getScansPorTipo(tipo);
    this.scans = [...scans];
    tipoSeleccionado = tipo;

    notifyListeners();
  }

  borarTodosLosScans() async {
    await DBProvider.db.deleteAllScans();
    scans = [];

    notifyListeners();
  }

  borrarScanPorId(int id) async {
    await DBProvider.db.deleteScan(id);
    // borro un scan y recargo la lista de los que se están mostrando
    cargarScansPorTipo(tipoSeleccionado);
    // no llamo a notifyListeners porque ya lo hace cargarScansPorTipo()
  }
}
