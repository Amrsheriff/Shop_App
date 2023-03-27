import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layout/shop_app/cubit/cubit.dart';
import 'package:untitled/modules/shop_app/search/cubit/cubit.dart';
import 'package:untitled/modules/shop_app/search/cubit/states.dart';

import '../../../shared/componants/componants.dart';
import '../../../shared/styles/colors.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var searchController = TextEditingController();

    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
            ),
            body: Form(
              key: formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                      start: 20.0,
                      top: 0.0,
                      end: 20.0,
                      bottom: 10.0,
                    ),
                    child: PhysicalModel(
                      color: Colors.white,
                      elevation: 4,
                      shadowColor: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      child: defaultFormFieldSearch(
                        radius: 20.0,
                        onSubmit: (value) {
                          SearchCubit.get(context).search(value);
                        },
                        onChange: () {
                        },
                        context: context,
                        controller: searchController,
                        type: TextInputType.text,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'Search must not empty';
                          }
                        },
                        hint_label: 'Search',
                        prefix: Icons.search,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  if (state is SearchLoadingState)
                    LinearProgressIndicator(),
                  if (state is SearchSuccessState)
                    Expanded(child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) =>
                        buildSearchItem(SearchCubit
                            .get(context)
                            .model!
                            .data!
                            .data[index], context,),
                    separatorBuilder: (context, index) => SeparatorPadding(),
                    itemCount: SearchCubit
                        .get(context)
                        .model!
                        .data!
                        .data
                        .length,
                  ),),

                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildSearchItem(model, context,)=> Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(
      height: 120,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(image: NetworkImage(model.image!),
                width: 120,
                height: 120,
              ),
            ],
          ),
          SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    height: 1.3,
                  ),
                ),
                Spacer(),
                Row(
                  children: [
                    Text(
                      '${model.price!}',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12.0,
                        color: defaultColor,
                      ),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    // Spacer(),
                    // IconButton(
                    //     onPressed: (){
                    //       ShopCubit.get(context).changeFavorites(model.id!);
                    //     },
                    //     icon: CircleAvatar(
                    //       radius: 15.0,
                    //       backgroundColor: ShopCubit.get(context).favorites[
                    //       model.product!.id!
                    //       ]! ? defaultColor : Colors.grey,
                    //       child: Icon(
                    //         Icons.favorite_border,
                    //         size: 14.0,
                    //         color: Colors.white,
                    //       ),
                    //     )
                    // ),
                  ],
                ),
              ],
            ),
          ),
        ],

      ),
    ),
  );
}
