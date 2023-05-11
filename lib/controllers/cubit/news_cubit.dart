import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/controllers/cubit/news_cubit.dart';
import 'package:shopapp/shared/constants.dart';
import 'package:shopapp/shared/local/cahce_helper.dart';
import 'package:shopapp/shared/network/dio_helper.dart';
import 'package:shopapp/views/buisness_view.dart';
import 'package:shopapp/views/science_view.dart';
import 'package:shopapp/views/search_view.dart';
import 'package:shopapp/views/sports_view.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(NewsInitial());
  static NewsCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(icon: Icon(Icons.science), label: 'Science'),
    BottomNavigationBarItem(icon: Icon(Icons.sports), label: 'Sports'),
    BottomNavigationBarItem(icon: Icon(Icons.business), label: 'Buisness'),
    // BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
  ];
  List<Widget> views = [
    ScienceView(),
    SportsView(),
    BuisnessView(),
    // SearchView(),
  ];

  void changeBottomView(int index) {
    currentIndex = index;
    if (currentIndex == 1)
      getSportsData();
    else if (currentIndex == 2) getBuisnessData();
    emit(NewsBottomNavigationBar());
  }

  static List<dynamic> buisnessList = [];
  void getBuisnessData() {
    emit(NewsGetBuisnessLoadingState());
    DioHelper.get(
      'v2/top-headlines',
      {
        'apiKey': 'db317dd5a1a14d359cf120f8e9535a7f',
        'country': 'us',
        'category': 'business'
      },
    ).then((news) {
      buisnessList = news.data['articles'];

      emit(NewsGetBuisnessSuccessState());
    }).catchError((onError) {
      print('error: ${onError.toString()}');
      emit(NewsGetBuisnessFailiureState(error: onError));
    });
  }

  static List<dynamic> sportsList = [];
  void getSportsData() {
    emit(NewsGetSportsLoadingState());
    DioHelper.get(
      'v2/top-headlines',
      {
        'apiKey': 'db317dd5a1a14d359cf120f8e9535a7f',
        'country': 'us',
        'category': 'sports'
      },
    ).then((news) {
      sportsList = news.data['articles'];
      emit(NewsGetSportsSuccessState());
    }).catchError((onError) {
      print('error: ${onError.toString()}');
      emit(NewsGetSportsFailiureState(error: onError));
    });
  }

  static dynamic scienceList = [];
  void getScienceData() {
    emit(NewsGetScienceLoadingState());
    DioHelper.get(
      'v2/top-headlines',
      {
        'apiKey': 'db317dd5a1a14d359cf120f8e9535a7f',
        'country': 'us',
        'category': 'science'
      },
    ).then((news) {
      scienceList = news.data['articles'];
      emit(NewsGetScienceSuccessState());
    }).catchError((onError) {
      print('error: ${onError.toString()}');
      emit(NewsGetScienceFailiureState(error: onError));
    });
  }

  bool isDark = false;

  void changeAppMode({bool? fromCache}){
    if(fromCache != null){
      isDark = fromCache;
      emit(NewsChangeMode());
    }else{
      isDark = !isDark;
      CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
        emit(NewsChangeMode());
      });
    }
  }
  var search = [];
  void getSearch(String q){
    emit(NewsSearchLoadingState());
    DioHelper.get(
      'v2/everything',
      {
        'apiKey': 'db317dd5a1a14d359cf120f8e9535a7f',
        'q': '$q'
      },
    ).then((news) {
      search = news.data['articles'];
      print(search.toString());
      emit(NewsSearchSuccessState());
    }).catchError((onError) {
      print('error: ${onError.toString()}');
      emit(NewsSearchFailiureState(error: onError));
    });
  }

  @override
  void onChange(Change<NewsState> change) {
    // TODO: implement onChange
    super.onChange(change);
    print(change.toString());
  }
}
