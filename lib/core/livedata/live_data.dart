import 'package:flutter/cupertino.dart';
import 'package:flutter_app/core/livedata/ui_state.dart';

class LiveData<T extends UIState> with ChangeNotifier{
  T? value;

  void setValue (T value){
    this.value = value;
    //notifyListeners();
  }

  UIState getValue(){
    return this.value!;
  }

}