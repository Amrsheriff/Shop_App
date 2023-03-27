import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/modules/shop_app/login/shop_login_screen.dart';
import 'package:untitled/modules/shop_app/register/cubit/cubit.dart';
import 'package:untitled/modules/shop_app/register/cubit/states.dart';

import '../../../layout/shop_app/cubit/cubit.dart';
import '../../../layout/shop_app/shop_layout.dart';
import '../../../shared/componants/componants.dart';
import '../../../shared/componants/constants.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../../../shared/styles/colors.dart';

class ShopRegisterScreen extends StatelessWidget {
   ShopRegisterScreen({Key? key}) : super(key: key);

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        listener: (context, state){
          if(state is ShopRegisterSuccessState)
          {
            if (state.loginModel.status == true)
            {
              print(state.loginModel.message);
              print(state.loginModel.data!.token);

              CacheHelper.saveData(
                key: 'token',
                value: state.loginModel.data!.token,
              ).then((value) {
                token = state.loginModel.data!.token;
                navigateAndFinish(
                    context,
                    ShopLayout()
                );
              }
              );
            }else
            {
              print(state.loginModel.message);
              showToast(
                message: state.loginModel.message!,
                state: ToastStates.ERROR,
              );
            }
          }
        },
        builder: (context, state){
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'REGISTER',
                          style: Theme.of(context).textTheme.headline4?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.black
                          ),
                        ),
                        Text(
                          'register now to browse our hot offers',
                          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        PhysicalModel(
                          color: Theme.of(context).primaryColorLight,
                          elevation: 4,
                          shadowColor: Theme.of(context).primaryColorLight,
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            height: 70,
                            child: Center(
                              child: defaultFormFieldSea(
                                controller: nameController,
                                type: TextInputType.emailAddress,
                                validate: (String value) {
                                  if (value.isEmpty) {
                                    return '              name must not be empty';
                                  }
                                },
                                hint_label: 'Name',
                                prefix: Icons.person,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25.0,
                        ),
                        PhysicalModel(
                          color: Theme.of(context).primaryColorLight,
                          elevation: 4,
                          shadowColor: Theme.of(context).primaryColorLight,
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            height: 70,
                            child: Center(
                              child: defaultFormFieldSea(
                                controller: emailController,
                                type: TextInputType.emailAddress,
                                validate: (String value) {
                                  if (value.isEmpty) {
                                    return '              email must not be empty';
                                  }
                                },
                                hint_label: 'Email',
                                prefix: Icons.email,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25.0,
                        ),
                        PhysicalModel(
                          color: Theme.of(context).primaryColorLight,
                          elevation: 4,
                          shadowColor: Theme.of(context).primaryColorLight,
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            height: 70,
                            child: Center(
                              child: defaultFormFieldSea(
                                controller: phoneController,
                                type: TextInputType.phone,
                                validate: (String value) {
                                  if (value.isEmpty) {
                                    return '              phone must not be empty';
                                  }
                                },
                                hint_label: 'Phone',
                                prefix: Icons.phone,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25.0,
                        ),
                        PhysicalModel(
                          color: Theme.of(context).primaryColorLight,
                          elevation: 4,
                          shadowColor: Theme.of(context).primaryColorLight,
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            height: 70,
                            child: Center(
                              child: defaultFormFieldSea(
                                  controller: passwordController,
                                  type: TextInputType.visiblePassword,
                                  validate: (String value) {
                                    if (value.isEmpty) {
                                      return '              password must not be empty';
                                    }
                                  },
                                  hint_label: 'Password',
                                  prefix: Icons.lock_outline,
                                  suffix: ShopRegisterCubit.get(context).suffix,
                                  isPassword: ShopRegisterCubit.get(context).isPassword,
                                  suffixPressed: (){
                                    ShopRegisterCubit.get(context).changePasswordVisibility();
                                  }
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopRegisterLoadingState,
                          builder: (context)=> PhysicalModel(
                            color: defaultColor,
                            elevation: 2,
                            shadowColor: defaultColor,
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              height: 60,
                              child: Center(
                                  child: defaultButtono(
                                    function: (){
                                      if(_formKey.currentState!.validate()){
                                        ShopRegisterCubit.get(context).userRegister(
                                          email: emailController.text,
                                          password: passwordController.text,
                                          name: nameController.text,
                                          phone: phoneController.text,
                                        );
                                      }
                                    },
                                    text: 'REGISTER',
                                  )
                              ),
                            ),
                          ),
                          fallback: (context)=> Center(child: CircularProgressIndicator()),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "You have an account?",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            defaultTextButton(
                                function: (){
                                  navigateTo(context, ShopLoginScreen());
                                },
                                text: 'Login'
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      )
    );

  }
}
