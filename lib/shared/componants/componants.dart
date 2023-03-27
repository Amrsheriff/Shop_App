import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:untitled/modules/news_app/web_view/web_view.dart';
import 'package:untitled/shared/cubit/cubit.dart';

import '../../layout/shop_app/cubit/cubit.dart';
import '../../models/shop_app/favorites_model.dart';
import '../styles/colors.dart';


Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  height = 50.0,
  double radius = 10,
  required Function function,
  required String text,
}) =>
    Container(
      width: width,
      height: height,
      child: MaterialButton(
        onPressed: () {
          function();
        },
        child: Text(
          text.toUpperCase(),
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: background,
      ),
    );

Widget defaultButtono({
  double width = double.infinity,
  Color background = Colors.blue,
  height = 60.0,
  double radius = 20,
  required Function function,
  required String text,
}) =>
    Container(
      width: width,
      height: height,
      child: MaterialButton(
        onPressed: () {
          function();
        },
        child: Text(
          text.toUpperCase(),
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: background,
      ),
    );



Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function? onSubmit,
  Function? onChanged,
  required Function validate,
  required String label,
  required IconData prefix,
  bool isPassword = false,
  IconData? suffix,
  Function? onPressed,
  Function? onTap,
  context,
  double radius = 10.0,
}) =>
    TextFormField(
      controller: controller,
      onTap: () {
        onTap!();
      },
      keyboardType: type,
      onFieldSubmitted: (value) {
        return onSubmit!(value);
      },
      // onChanged: (value) {
      //   return onChanged!(value);
      // },
      validator: (value) {
        return validate(value);
      },
      obscureText: isPassword,
      decoration: InputDecoration(
        // focusedBorder: OutlineInputBorder(
        //   borderSide: BorderSide(
        //       color: Colors.white,
        //   ),
        // ),

        labelText: label,
        labelStyle: Theme.of(context).textTheme.bodyText2,
        prefixIcon: Icon(
          prefix,

        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: () {
                  onPressed!();
                },
                icon: Icon(suffix),
              )
            : null,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(radius),
      ),

      ),
    );

Widget buildTaskItems(Map model, context) => Dismissible(
      background: buildSwipeActionLeft(context),
      secondaryBackground: buildSwipeActionRight() ,
      key: UniqueKey(),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              //backgroundColor: Color(0xFF30221E),
              //backgroundColor: Color(0xFF266171),
              backgroundColor: Color(0xFF887056),
              radius: 40.0,
              child: Text(
                '${model['time']}',
                style: TextStyle(
                  color: Colors.white
                ),
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model['title']}',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    '${model['date']}',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            ConditionalBuilder(
              condition: AppCubit.get(context).currentIndex != 1 ,
              builder: (context) => IconButton(
                onPressed: () {
                  AppCubit.get(context)
                      .updateData(status: 'done', id: model['id']);
                },
                icon: Icon(
                  Icons.check_box_rounded,
                  color: Colors.black45,
                ),
              ),
              fallback: (context) => SizedBox(
                width: 5.0,
              ),
            ),
            ConditionalBuilder(
              condition: AppCubit.get(context).currentIndex !=2,
              builder: (context) => IconButton(
                onPressed: () {
                  AppCubit.get(context)
                      .updateData(status: 'archive', id: model['id']);
                },
                icon: Icon(
                  Icons.archive,
                  color: Colors.black45,
                ),
              ),
              fallback: (context) => SizedBox(),
            ),

          ],
        ),
      ),
      //direction: DismissDirection.startToEnd,
      onDismissed: (DismissDirection direction) {
        {
          if (direction == DismissDirection.endToStart) {
            AppCubit.get(context).deleteData(id: model['id']);
          } else if (AppCubit.get(context).currentIndex == 0) {
            var tittleControllero = TextEditingController(text: '${model['title']}');
            var timeControllero = TextEditingController(text: '${model['time']}');
            var dateControllero = TextEditingController(text: '${model['date']}');
            var formKeyo = GlobalKey<FormState>();
            bool valuo  = true;
            // showModalBottomSheet(
            //     //isDismissible: false, // <--- this line
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.only(
            //           topLeft: Radius.circular(25.0), topRight: Radius.circular(25.0)),
            //
            //     ),
            //     context: context,
            //     builder: (builder) {
            //       padding: EdgeInsets.only(
            //           bottom: MediaQuery.of(context).viewInsets.bottom);
            //       return Container(
            //         padding: EdgeInsets.all(20.0),
            //         child: Form(
            //           key: formKeyo,
            //           child: Column(
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             mainAxisSize: MainAxisSize.min,
            //             children: [
            //               defaultFormField(
            //                   controller: tittleControllero,
            //                   type: TextInputType.text,
            //                   validate: (String value) {
            //                     if (value.isEmpty) {
            //                       return ('title must not be empty');
            //                     }
            //                   },
            //                   label: 'Task title',
            //                   prefix: Icons.title),
            //               SizedBox(
            //                 height: 15.0,
            //               ),
            //               defaultFormField(
            //                 controller: timeControllero,
            //                 type: TextInputType.none,
            //                 onTap: () {
            //                   showTimePicker(
            //                       builder: (context, child) => Theme(
            //                         data: ThemeData(
            //                             colorScheme: ColorScheme.light(
            //                               primary: Color(0xFFC1B3A2),
            //                             )
            //                         ), child: child!,
            //                       ),
            //                       context: context,
            //                       initialTime: TimeOfDay.now())
            //                       .then((value) {
            //                     timeControllero.text =
            //                         value!.format(context).toString();
            //                   });
            //                 },
            //                 validate: (String value) {
            //                   if (value.isEmpty) {
            //                     return ('time must not be empty');
            //                   }
            //                 },
            //                 label: 'Task Time',
            //                 prefix: Icons.watch_later_outlined,
            //               ),
            //               SizedBox(
            //                 height: 15.0,
            //               ),
            //               defaultFormField(
            //                 controller: dateControllero,
            //                 type: TextInputType.none,
            //                 onTap: () {
            //                   showDatePicker(
            //                       builder: (context, child) => Theme(
            //                         data: ThemeData(
            //                             colorScheme: ColorScheme.light(
            //                               primary: Color(0xFFC1B3A2),
            //                               onPrimary: Colors.white,
            //                               surface: Colors.yellow,
            //                             )
            //                         ), child: child!,
            //                       ),
            //                       context: context,
            //                       initialDate: DateTime.now(),
            //                       firstDate: DateTime.now(),
            //                       lastDate:
            //                       DateTime.parse('2022-12-30'))
            //                       .then((value) {
            //                     dateControllero.text =
            //                         DateFormat.yMMMd().format(value!);
            //                   });
            //                 },
            //                 validate: (String value) {
            //                   if (value.isEmpty) {
            //                     return ('date must not be empty');
            //                   }
            //                 },
            //                 label: 'Task Date',
            //                 prefix: Icons.calendar_month_sharp,
            //               ),
            //             ],
            //           ),
            //         ),
            //       );
            showModalBottomSheet(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
                context: context,
                isScrollControlled: true,
                builder: (context) => Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Container(
                    padding: EdgeInsets.all(20.0),
                    child: Form(
                      key: formKeyo,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: TextButton(onPressed: (){
                                  Navigator.pop(context);
                                },
                                style: TextButton.styleFrom(
                                foregroundColor: Color(0xFFA6947A),),
                                    child: Text(
                                    'Cancel',
                                  style: TextStyle(
                                    color: Color(0xFFA6947A),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                )),
                              ),
                              Expanded(child: SizedBox(width: double.infinity)),
                              Expanded(
                                child: TextButton(onPressed: (){
                                  if(formKeyo.currentState!.validate()){
                                    if (valuo = true){
                                      Navigator.pop(context);
                                    }
                                    //Navigator.pop(context);
                                  }
                                },
                                  style: TextButton.styleFrom(
                                    foregroundColor: Color(0xFFA6947A),),
                                  child: Text('Done',
                                    style: TextStyle(
                                      color: Color(0xFFA6947A),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,)
                                ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.0,),
                          defaultFormField(
                              controller: tittleControllero,
                              type: TextInputType.text,
                              validate: (String value) {
                                if (value.isEmpty) {
                                  valuo  = false;
                                  return ('title must not be empty');
                                }
                              },
                              label: 'Task title',
                              prefix: Icons.title),


                          SizedBox(
                            height: 15.0,
                          ),
                          defaultFormField(
                            controller: timeControllero,
                            type: TextInputType.none,
                            onTap: () {
                              showTimePicker(
                                  builder: (context, child) => Theme(
                                    data: ThemeData(
                                        colorScheme: ColorScheme.light(
                                          primary: Color(0xFFC1B3A2),
                                        )
                                    ), child: child!,
                                  ),
                                  context: context,
                                  initialTime: TimeOfDay.now())
                                  .then((value) {
                                timeControllero.text =
                                    value!.format(context).toString();
                              });
                            },
                            validate: (String value) {
                              if (value.isEmpty) {
                                valuo  = false;
                                return ('time must not be empty');
                              }
                            },
                            label: 'Task Time',
                            prefix: Icons.watch_later_outlined,
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          defaultFormField(
                            controller: dateControllero,
                            type: TextInputType.none,
                            onTap: () {
                              showDatePicker(
                                  builder: (context, child) => Theme(
                                    data: ThemeData(
                                        colorScheme: ColorScheme.light(
                                          primary: Color(0xFFC1B3A2),
                                          onPrimary: Colors.white,
                                          surface: Colors.yellow,
                                        )
                                    ), child: child!,
                                  ),
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate:
                                  DateTime.parse('2022-12-30'))
                                  .then((value) {
                                dateControllero.text =
                                    DateFormat.yMMMd().format(value!);
                              });
                            },
                            validate: (String value) {
                              if (value.isEmpty) {
                                valuo  = false;
                                return ('date must not be empty');
                              }
                            },
                            label: 'Task Date',
                            prefix: Icons.calendar_month_sharp,
                          ),
                        ],
                      ),
                    ),
                  ),
                )).then((value) => AppCubit.get(context).EditData( id : model['id'], title: tittleControllero.text, time: timeControllero.text, date: dateControllero.text ));
        //.then((value) => AppCubit.get(context).EditData( id : model['id'], title: tittleControllero.text, time: timeControllero.text, date: dateControllero.text),);
          }

          else {
            AppCubit.get(context).deleteData(id: model['id']);
          }
        };


      },
    );

Widget buildSwipeActionLeft(context) => ConditionalBuilder(
      condition: AppCubit.get(context).currentIndex == 0,
      builder: (context) => Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        color: Colors.green,
        child: Icon(Icons.edit,
            size: 32.0,
          color: Colors.white,
          ),
        ),
       fallback: (context) => Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        color: Colors.red,
        child: Icon(Icons.delete,
          color: Colors.white,
          size: 32.0,
        ),
),
);


Widget buildSwipeActionRight() => Container(
  alignment: Alignment.centerRight,
  padding: EdgeInsets.symmetric(horizontal: 20.0),
  color: Colors.red,
  child: Icon(Icons.delete,
    color: Colors.white,
    size: 32.0,
  ),

);

Widget tasksBuilder({required List<Map> tasks}) => ConditionalBuilder(
      condition:  tasks.isNotEmpty,
      builder: (context) => ListView.separated(
        physics: ClampingScrollPhysics(),
        itemBuilder: (context, index) => buildTaskItems(tasks[index], context),
        separatorBuilder: (context, index) => SeparatorPadding(),
        itemCount: tasks.length,
      ),
      fallback: (context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.menu,
              size: 100.0,
              color: Colors.grey,
            ),
            Text(
              'No Tasks Yet, Please Add Some Tasks',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );

Widget SeparatorPadding() => Padding(
  padding: const EdgeInsetsDirectional.only(start: 20.0),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[300],
  ),
);

Widget buildArticleItem(article, context)=> InkWell(
  onTap: (){
    //navigateTo(context, webViewScreen(article['url']));
  },
  child:   Padding(

    padding: const EdgeInsets.all(20.0),

    child: Row(

      children: [

        Container(

          width: 120.0,

          height: 120.0,

          decoration: BoxDecoration(

            borderRadius: BorderRadius.circular(10.0),

            image: DecorationImage(

              image: NetworkImage('${article['urlToImage']}'),

              fit: BoxFit.cover,

            ),

          ),

        ),

        SizedBox(

          width: 20,

        ),

        Expanded(

          child: Container(

            height: 120.0,

            child: Column(

              mainAxisAlignment: MainAxisAlignment.start,

              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                Expanded(

                  child: Text(

                    '${article['title']}',

                    style: Theme.of(context).textTheme.bodyText1,

                    maxLines: 3,

                    overflow: TextOverflow.ellipsis,

                  ),

                ),

                Text(

                  '${article['publishedAt']}',

                  style: TextStyle(

                    color: Colors.grey,

                  ),

                ),

              ],

            ),

          ),

        ),

      ],

    ),

  ),
);

Widget articleBuilder(list, context,{isSearch = false})=> ConditionalBuilder(
    condition: list.length>0,
    builder: (context) => ListView.separated(
      //physics: ClampingScrollPhysics(),
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) => buildArticleItem(list[index], context),
      separatorBuilder: (context, index) => SeparatorPadding(),
      itemCount: list.length,
    ),
    fallback: (context) => isSearch ? Container() : Center(child: CircularProgressIndicator())
);

void navigateTo(context, widget) => Navigator.push(
  context,
  MaterialPageRoute(
      builder: (context) => widget,
  ),
);

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
        builder: (context) => widget
    ),
        (route) => false
);

Widget defaultFormFieldSearch({
  required TextEditingController controller,
  required TextInputType type,
  Function? onSubmit,
  required Function onChange,
  required Function validate,
  required String hint_label,
  required IconData prefix,
  bool isPassword = false,
  IconData? suffix,
  Function? onPressed,
  Function? onTap,
  context,
  double radius = 10.0,
}) =>
    TextFormField(
      onChanged: (value){
        return onChange(value);
      },
      controller: controller,
      onTap: () {
        onTap!();
      },
      style: Theme.of(context).textTheme.bodyText2,
      keyboardType: type,
      onFieldSubmitted: (value) {
        return onSubmit!(value);
      },
      // onChanged: (value) {
      //   return onChanged!(value);
      // },
      validator: (value) {
        return validate(value);
      },
      obscureText: isPassword,
      decoration: InputDecoration(
         contentPadding:
         EdgeInsets.only(left: 0, bottom: 0, top: 14, right: 0), // make a space in text filed not form field
        // focusedBorder: OutlineInputBorder(
        //   borderSide: BorderSide(
        //       color: Colors.white,
        //   ),
        // ),
        border: InputBorder.none,
        hintText: hint_label,
        hintStyle: Theme.of(context).textTheme.bodyText2,
        //labelStyle: Theme.of(context).textTheme.bodyText2,
        prefixIcon: Icon(
          prefix,
          color: Theme.of(context).primaryColorDark,

        ),
        suffixIcon: suffix != null
            ? IconButton(
          onPressed: () {
            onPressed!();
          },
          icon: Icon(suffix),
        )
            : null,
        // border: OutlineInputBorder(borderRadius: BorderRadius.circular(radius),
        ),

      );

Widget defaultFormFieldo({
  required TextEditingController controller,
  required TextInputType type,
  Function? onSubmit,
  Function? onChanged,
  required Function validate,
  required String label,
  required IconData prefix,
  bool isPassword = false,
  IconData? suffix,
  Function? onPressed,
  Function? onTap,

  double radius = 10.0,
}) =>
    TextFormField(
      controller: controller,
      onTap: () {
        onTap!();
      },
      keyboardType: type,
      onFieldSubmitted: (value) {
        return onSubmit!(value);
      },
      // onChanged: (value) {
      //   return onChanged!(value);
      // },
      validator: (value) {
        return validate(value);
      },
      obscureText: isPassword,
      decoration: InputDecoration(
        // focusedBorder: OutlineInputBorder(
        //   borderSide: BorderSide(
        //       color: Colors.white,
        //   ),
        // ),

        labelText: label,

        prefixIcon: Icon(
          prefix,

        ),
        suffixIcon: suffix != null
            ? IconButton(
          onPressed: () {
            onPressed!();
          },
          icon: Icon(suffix),
        )
            : null,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(radius),
        ),

      ),
    );

Widget defaultFormFieldSea({
  required TextEditingController controller,
  required TextInputType type,
  Function? onSubmit,
  Function? onChange,
  required Function validate,
  String? hint_label,
  required IconData prefix,
  bool isPassword = false,
  IconData? suffix,
  Function? suffixPressed,
  Function? onTap,
  double radius = 10.0,
}) =>
    TextFormField(
      onChanged: (value){
        return onChange!(value);
      },
      controller: controller,
      onTap: () {
        onTap!();
      },
      keyboardType: type,
      onFieldSubmitted: (value) {
        return onSubmit!(value);
      },
      // onChanged: (value) {
      //   return onChanged!(value);
      // },
      validator: (value) {
        return validate(value);
      },
      obscureText: isPassword,
      decoration: InputDecoration(
        contentPadding:
        EdgeInsets.only(left: 0, bottom: 0, top: 14, right: 0), // make a space in text filed not form field
        // focusedBorder: OutlineInputBorder(
        //   borderSide: BorderSide(
        //       color: Colors.white,
        //   ),
        // ),
        border: InputBorder.none,
        hintText: hint_label,
        //labelStyle: Theme.of(context).textTheme.bodyText2,
        prefixIcon: Icon(
          prefix,

        ),
        suffixIcon: suffix != null
            ? IconButton(
          onPressed: () {
            suffixPressed!();
          },
          icon: Icon(suffix),
        )
            : null,
        // border: OutlineInputBorder(borderRadius: BorderRadius.circular(radius),
      ),

    );

Widget defaultTextButton({
  required function,
  required String text,
}
)=> TextButton(
onPressed: (){
  function();
},
child: Text(
  text.toUpperCase(),
style: TextStyle(
fontWeight: FontWeight.bold
),
),
);

void showToast(
{
  required String message,
  required ToastStates state,
}
    )=> Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: chooseToastColor(state),
    textColor: Colors.white,
    fontSize: 16.0
);

enum ToastStates{SUCCESS, ERROR, WARNING}
Color? color;

Color? chooseToastColor(ToastStates state){
  Color? color;
  switch(state){
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
      case ToastStates.ERROR:
      color = Colors.red;
      break;
      case ToastStates.WARNING:
      color = Colors.amber;
      break;}
  return color;
}




