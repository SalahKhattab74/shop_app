import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/shop_app/search_model.dart';
import 'package:shop_app/moduels/shop_app/search/cubit/search_states.dart';
import 'package:shop_app/network/endPoints/endPoints.dart';
import 'package:shop_app/network/remote/dio_helper.dart';
import 'package:shop_app/shared/constants.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialStates());
  static SearchCubit get(context) => BlocProvider.of(context);
  SearchModel searchModel;
  void search(String text) {
    emit(SearchLoadingStates());

    DioHelper.postDat(url: SEARCH, data: {
      'text': text,
      token: token,
    })
        .then((value) => {
              searchModel = SearchModel.fromJson(value.data),
              emit(SearchSuccessStates()),
            })
        .catchError((error) {
      print(error.toString());
      emit(SearchErrorStates());
    });
  }
}
