import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/layout/shop_app/cubit/cubit.dart';
import 'package:untitled/layout/shop_app/cubit/states.dart';
import 'package:untitled/modules/basics/login/login_screen.dart';
import 'package:untitled/modules/shop_app/login/cubit/cubit.dart';
import 'package:untitled/modules/shop_app/login/shop_login_screen.dart';

import '../../../models/shop_app/login_model.dart';
import '../../../shared/componants/componants.dart';
import '../../../shared/componants/constants.dart';
import '../../../shared/cubit/cubit.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../../../shared/styles/colors.dart';

class SettingsScreen extends StatelessWidget {
   SettingsScreen({Key? key}) : super(key: key);

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

   var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
      return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state){
          nameController.text = ShopCubit.get(context).userModel!.data!.name!;
          emailController.text = ShopCubit.get(context).userModel!.data!.email!;
          phoneController.text = ShopCubit.get(context).userModel!.data!.phone!;
        },
        builder: (context, state){
          return ConditionalBuilder(
            condition: ShopCubit.get(context).userModel != null && nameController.text.isNotEmpty,
            builder: (context)=> Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    if(state is ShopLoadingUpdateUserState)
                      LinearProgressIndicator(),
                    SizedBox(
                      height: 5,
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
                            type: TextInputType.name,
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
                      height: 10.0,
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
                      height: 10.0,
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
                            hint_label: 'Phone Number',
                            prefix: Icons.phone,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    PhysicalModel(
                      color: defaultColor,
                      elevation: 2,
                      shadowColor: defaultColor,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        height: 60,
                        child: Center(
                          child: defaultButton(
                              function: () {
                                if(_formKey.currentState!.validate()) {
                                  ShopCubit.get(context).updateUserData(
                                    name: nameController.text,
                                    email: emailController.text,
                                    phone: phoneController.text,
                                  );
                                }
                              },
                              text: 'UPDATE'),

                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    PhysicalModel(
                      color: defaultColor,
                      elevation: 2,
                      shadowColor: defaultColor,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        height: 60,
                        child: Center(
                            child: defaultButton(
                                function: () {
                                  signOut(context);
                                },
                                text: 'SIGN OUT'),

                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),
            fallback: (context)=> Center(child: CircularProgressIndicator()),
          );
        },
    );
  }
}

