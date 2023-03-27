import 'package:untitled/models/shop_app/change_favorites_model.dart';

abstract class ShopStates{}

class ShopInitialState extends ShopStates{}

class ShopChangeBottomNavState extends ShopStates{}

class ShopUserDataState extends ShopStates{}

class ShopLoadingHomeDataState extends ShopStates{}

class ShopSuccessHomeDataState extends ShopStates{}

class ShopErrorHomeDataState extends ShopStates{}

class ShopSuccessCategoriesState extends ShopStates{}

class ShopErrorCategoriesState extends ShopStates{}

class ShopSuccessChangeFavoritesState extends ShopStates{

  final ChangeFavoritesModel model;

  ShopSuccessChangeFavoritesState(this.model);
}

class ShopChangeFavoritesState extends ShopStates{}

class ShopErrorChangeFavoritesState extends ShopStates{}

class ShopSuccessGetFavoritesState extends ShopStates{}

class ShopErrorGetFavoritesState extends ShopStates{}

class ShopLoadingGetFavoritesState extends ShopStates{}

class ShopSuccessUserDataState extends ShopStates{}

class ShopErrorUserDataState extends ShopStates{
  final String error;
  ShopErrorUserDataState(this.error);
}

class ShopLoadingUserDataState extends ShopStates{}

class ShopSuccessUpdateUserState extends ShopStates{}

class ShopErrorUpdateUserState extends ShopStates{
  final String error;
  ShopErrorUpdateUserState(this.error);
}

class ShopLoadingUpdateUserState extends ShopStates{}

