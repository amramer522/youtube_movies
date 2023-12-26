import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'model.dart';

part 'states.dart';

class MovieDetailsCubit extends Cubit<GetMovieDetailsStates> {
  MovieDetailsCubit() : super(GetMovieDetailsStates());

  Future<void> getData(int id) async {
    emit(GetMovieDetailsLoadingState());
    try {
      final response = await Dio().get("https://api.themoviedb.org/3/movie/$id?api_key=2001486a0f63e9e4ef9c4da157ef37cd");
      MovieDetails model = MovieDetails.fromJson(response.data);
      print(model.title);
      emit(GetMovieDetailsSuccessState(model: model));
    } on DioException catch (ex) {
      emit(GetMovieDetailsFailedState(msg: ex.message ?? "Failed"));
    }
  }
}
