

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/layout/news_app/cubit/states.dart';
import 'package:newsapp/modules/business/business_screen.dart';
import 'package:newsapp/modules/seince/seince_screen.dart';
import 'package:newsapp/modules/suports/suports_screen.dart';

import '../../../modules/settings/settings_screen.dart';
import '../../../shared/networks/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

static NewsCubit get(context)=>BlocProvider.of(context);

int currentIndex = 0;

List<BottomNavigationBarItem> bottmItems =[
  BottomNavigationBarItem(
    icon: Icon(Icons.business),
    label: 'Business'
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.sports),
    label: 'Sports'
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.science),
    label: 'Science'
  ),

];

List<Widget> screens=[
  BusinessScreen(),
  SupportScreen(),
  SeincesScreen(),
];

void changeBottomNavBar(int index) {
  currentIndex = index;
  if(index == 1) getSport();
  if(index== 2) getScience();
  emit(NewsBottomNavState());
}

List<dynamic> business = [];
List <dynamic> sports =[];
List <dynamic> science =[];
String apiKey = '399d5f5654614304bcd863a586e8c84b';
void getBusiness(){
  emit(NewsGetBusinessLoadingState());
  DioHelper.getData(
      url: 'v2/top-headlines',
      queryParameter: {
        'country':'eg',
        'category':'business',
        'apiKey' : apiKey
      }).then((value) {
        business=value.data['articles'];
        print(business.length);
        print(business[0]['title']);
        emit(NewsGetBusinessSuccessState());
  }).catchError((error){
    print(error.toString());
    emit(NewsGetBusinessErrorState(error.toString()));
  });
}

void getSport(){

  emit(NewsGetSportsLoadingState());
  if(sports.length == 0){
    DioHelper.getData(
      url: 'v2/top-headlines',
      queryParameter: {
        'country':'eg',
        'category':'sports',
        'apiKey' : apiKey,
      },
    ).then((value) {
      sports=value.data['articles'];
      print(sports.length);
      emit(NewsGetSportsSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetSportsErrorState(error.toString()));
    });
  }else {
    emit(NewsGetSportsSuccessState());
  }
}

void getScience(){
  emit(NewsGetScienceLoadingState());
  if(science.length == 0) {
    DioHelper.getData(
      url: 'v2/top-headlines',
      queryParameter: {
        'country':'eg',
        'category':'science',
        'apiKey':apiKey,
      },
    ).then((value){
      science=value.data['articles'];
      emit(NewsGetScienceSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetScienceErrorState(error));
    });
  } else {
    emit(NewsGetScienceSuccessState());
  }
}

List<dynamic> search = [];
  void getSearch(String value) {
    emit(NewsGetSearchLoadingState());
      DioHelper.getData(
        url: 'v2/everything',
        queryParameter: {

          'q':'${value}',
          'apiKey':apiKey,
        },
      ).then((value){
        search=value.data['articles'];
        emit(NewsGetSearchSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetScienceErrorState(error));
      });
    }


bool isDark = false;

void changeThemeMode(){
  isDark = !isDark;
  emit(ChangeThemeMode());
}
}
