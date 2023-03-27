import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/models/shop_app/login_model.dart';
import 'package:untitled/modules/shop_app/login/cubit/states.dart';
import 'package:untitled/modules/shop_app/register/cubit/states.dart';
import 'package:untitled/shared/network/remote/dio_helper.dart';

import '../../../../shared/network/end_points.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates>{
  ShopRegisterCubit() : super(ShopRegisterInitialState());
  
  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  ShopLoginModel? loginModel;

  void userRegister({
  required String email,
  required String password,
  required String name,
  required String phone,
}){
    emit(ShopRegisterLoadingState());

    DioHelper.posData(
        url: REGISTER,
        data:{
          'email' : email,
          'name' : name,
          'password' : password,
          'phone' : phone,
        },
    ).then((value) {
      print(value.data);
      loginModel =  ShopLoginModel.fromJson(value.data);
      // print(loginModel!.status);
      // print(loginModel!.message);
      // print(loginModel!.data!.token);
      emit(ShopRegisterSuccessState(loginModel!));
    }).catchError((error){
      print(error.toString());
      emit(ShopRegisterErrorState(error.toString()));
    });
  }

IconData suffix = Icons.visibility_off_outlined;
bool isPassword = true;

void changePasswordVisibility()
{
  isPassword = !isPassword;
  suffix = isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;
  emit(ShopRegisterChangePasswordVisibilityState());
}

}