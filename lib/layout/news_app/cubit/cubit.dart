import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/layout/news_app/cubit/states.dart';
import 'package:newsapp/modules/business/business_screen.dart';
import 'package:newsapp/modules/science/science_screen.dart';
import 'package:newsapp/modules/settings/settings_screen.dart';
import 'package:newsapp/modules/sports/sports_screen.dart';
import 'package:newsapp/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialStates());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
        icon: Icon(
          Icons.business_center,
        ),
        label: 'Business'),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.science,
        ),
        label: 'Science'),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.sports,
        ),
        label: 'Sports'),
  ];
  List<Widget> screens = [
    BusinessScreen(),
    ScienceScreen(),
    SportsScreen(),
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    if (index == 1) {
      getScience();
    }
    if (index == 2) {
      getSports();
    }
    emit(NewsBottomNavStates());
  }

  List<dynamic> business = [];

  void getBusiness() {
    emit(NewsGetBusinessLoadingStates());
    DioHelper.getData(url: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'business',
      'apikey': '65f7f556ec76449fa7dc7c0069f040ca',
    }).then((value) {
      print(value.data.toString());
      business = value.data['articles'];
      print(business.length);

      emit(NewsGetBusinessSuccessStates());
    }).catchError((errors) {
      print(errors);
      emit(NewsGetBusinessErrorsStates(errors.toString()));
    });
  }

  List<dynamic> sports = [];

  void getSports() {
    emit(NewsGetSportsLoadingStates());
    if (sports.length == 0) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'sports',
        'apikey': '65f7f556ec76449fa7dc7c0069f040ca',
      }).then((value) {
        print(value.data.toString());
        sports = value.data['articles'];
        print(sports.length);

        emit(NewsGetSportsSuccessStates());
      }).catchError((errors) {
        print(errors);
        emit(NewsGetSportsErrorsStates(errors.toString()));
      });
    } else {
      emit(NewsGetSportsSuccessStates());
    }
  }

  List<dynamic> science = [];

  void getScience() {
    emit(NewsGetScienceLoadingStates());
    if (science.length == 0) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'science',
        'apikey': '65f7f556ec76449fa7dc7c0069f040ca',
      }).then((value) {
        print(value.data.toString());
        science = value.data['articles'];
        print(science.length);

        emit(NewsGetScienceSuccessStates());
      }).catchError((errors) {
        print(errors);
        emit(NewsGetScienceErrorsStates(errors.toString()));
      });
    } else {
      emit(NewsGetScienceSuccessStates());
    }
  }

  List<dynamic> search = [];

  void getSearch(String value) {
    search = [];
    emit(NewsGetScienceLoadingStates());
    DioHelper.getData(url: 'v2/everything',
        query: {

      'q': '$value',
      'apikey': '65f7f556ec76449fa7dc7c0069f040ca',
    }).then((value) {
      search = value.data['articles'];
      print(search.length);

      emit(NewsGetSearchSuccessStates());
    }).catchError((errors) {
      print(errors);
      emit(NewsGetSearchErrorsStates(errors.toString()));
    });
  }
}
