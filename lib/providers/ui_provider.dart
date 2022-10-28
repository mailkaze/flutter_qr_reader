import 'package:flutter/material.dart';

class UiProvider extends ChangeNotifier {
  int _selectedMenuOpt = 0;

  // un getter no es un metodo, no se le llama con get algo, solo se accede a la propiedad y ya
  int get selectedMenuOpt {
    return _selectedMenuOpt;
  }

  // un setter no es un método, solo se le asigna a la propiedad su nuevo valor
  // no se manda como argumento entre parentesis ni nada
  set selectedMenuOpt(int i) {
    _selectedMenuOpt = i;

    notifyListeners();
  }
}
