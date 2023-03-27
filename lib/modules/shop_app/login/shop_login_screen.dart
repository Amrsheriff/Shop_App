import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:untitled/layout/shop_app/cubit/cubit.dart';
import 'package:untitled/layout/shop_app/shop_layout.dart';
import 'package:untitled/modules/shop_app/login/cubit/cubit.dart';
import 'package:untitled/modules/shop_app/login/cubit/states.dart';
import 'package:untitled/modules/shop_app/register/shop_register_screen.dart';
import 'package:untitled/shared/componants/componants.dart';
import 'package:untitled/shared/network/local/cache_helper.dart';
import 'package:untitled/shared/styles/colors.dart';

import '../../../shared/componants/constants.dart';

class ShopLoginScreen extends StatelessWidget {

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context)=> ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state){
          if(state is ShopLoginSuccessState)
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
                    //ShopCubit.get(context).currentIndex = 0;
                    navigateAndFinish(
                        context,
                        ShopLayout()
                    );

                    // ShopCubit.get(context).homeModel = null;
                    // ShopCubit.get(context).userModel = null;

                    // ShopCubit().close();
                    // ShopCubit()..getHomeData()..getUserData();
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
                          'LOGIN',
                          style: Theme.of(context).textTheme.headline4?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.black
                          ),
                        ),
                        Text(
                          'login now to browse our hot offers',
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
                                controller: emailController,
                                type: TextInputType.emailAddress,
                                validate: (String value) {
                                  if (value.isEmpty) {
                                    return '              email must not be empty';
                                  }
                                },
                                hint_label: 'Email Address',
                                prefix: Icons.email_outlined,
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
                                  onSubmit: (value){
                                    if(_formKey.currentState!.validate()){
                                      ShopLoginCubit.get(context).userLogin(
                                        email: emailController.text,
                                        password: passwordController.text,
                                      );
                                    }
                                  },
                                  validate: (String value) {
                                    if (value.isEmpty) {
                                      return '              password must not be empty';
                                    }
                                  },
                                  hint_label: 'Password',
                                  prefix: Icons.lock_outline,
                                  suffix: ShopLoginCubit.get(context).suffix,
                                  isPassword: ShopLoginCubit.get(context).isPassword,
                                  suffixPressed: (){
                                    ShopLoginCubit.get(context).changePasswordVisibility();
                                  }
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadingState,
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
                                        ShopLoginCubit.get(context).userLogin(
                                          email: emailController.text,
                                          password: passwordController.text,
                                        );
                                      }
                                    },
                                    text: 'LOGIN',
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
                              "Don't have an account?",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            defaultTextButton(
                                function: (){
                                  navigateTo(context, ShopRegisterScreen());
                                },
                                text: 'Register'
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
      ),
    );
  }
}
