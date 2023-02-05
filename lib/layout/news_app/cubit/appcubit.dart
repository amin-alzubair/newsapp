import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/shared/networks/local/cache_helper.dart';
import 'AppStates.dart';


class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialStates());

  static AppCubit get(context)=>BlocProvider.of(context);

  bool isDark = false;
  void changeThemeMode(){
    isDark = !isDark;
    CacheHelper.putData(key: 'isDark', value: isDark).then((value) {
      emit(ChangeThemeMode());
    });

  }

}