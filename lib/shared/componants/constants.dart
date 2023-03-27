import '../network/local/cache_helper.dart';
import 'componants.dart';
import 'package:untitled/modules/shop_app/login/shop_login_screen.dart';

void signOut(context)
{
  defaultTextButton(
      function: (){
        CacheHelper.removeData(key: 'token').then((value) {
          if(value){
            navigateAndFinish(context, ShopLoginScreen());
            print('objecto');
          }else{
            print('object');
          }
        });
      },
      text: 'Sign Out');
}

void printFullText(String text){
  final pattern = RegExp('.{1,800}'); //800 is the size of each chunk
  pattern.allMatches(text).forEach((match)=> print(match.group(0)));
}

String? token = '';