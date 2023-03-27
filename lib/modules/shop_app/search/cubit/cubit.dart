import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/models/shop_app/search_model.dart';
import 'package:untitled/modules/shop_app/search/cubit/states.dart';
import 'package:untitled/shared/network/remote/dio_helper.dart';

import '../../../../shared/componants/constants.dart';
import '../../../../shared/network/end_points.dart';

class SearchCubit extends Cubit<SearchStates>{
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? model;

  void search(String text){
    emit(SearchLoadingState());

    DioHelper.posData(
        url: SEARCH,
        token: token,
        data: {
          'text':text
        }
    ).then((value) {
      model = SearchModel.fromJson(value.data);
      
      emit(SearchSuccessState());
    }).catchError((error){
      emit(SearchErrorState());
    });
  }
}