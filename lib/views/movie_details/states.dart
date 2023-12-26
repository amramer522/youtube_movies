part of 'cubit.dart';

class GetMovieDetailsStates {}

class GetMovieDetailsLoadingState extends GetMovieDetailsStates {}

class GetMovieDetailsFailedState extends GetMovieDetailsStates {
  final String msg;
  GetMovieDetailsFailedState({required this.msg});
}

class GetMovieDetailsSuccessState extends GetMovieDetailsStates {
  late MovieDetails model;

  GetMovieDetailsSuccessState({required this.model});
}
