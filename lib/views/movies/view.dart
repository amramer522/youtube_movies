import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_movies/views/movie_details/view.dart';
import 'package:youtube_movies/views/movies/cubit.dart';
import 'model.dart';

part 'item.dart';

class MoviesView extends StatelessWidget {
  const MoviesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MoviesCubit cubit = BlocProvider.of(context);
    cubit.getData();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Movies"),
      ),
      body: BlocBuilder(
        bloc: cubit,
        buildWhen: (previous, current) => current is! GetMoviesFromPaginationLoadingState && current is! GetMoviesFromPaginationFailedState && current is! GetMoviesInitialState,
        builder: (context, state) {
          print(state);
          if (state is GetMoviesLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GetMoviesFailedState) {
            return Center(
              child: Text(state.msg),
            );
          } else if (state is GetMoviesSuccessState) {
            return NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                if (notification.metrics.pixels == notification.metrics.maxScrollExtent && notification is ScrollUpdateNotification) {
                  print("loading");
                  MoviesCubit cubit = BlocProvider.of(context);
                  cubit.getData(fromLoading: true);
                }
                return true;
              },
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemBuilder: (context, index) => _Item(model: state.list[index]),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 16,
                ),
                itemCount: state.list.length,
              ),
            );
          } else {
            return const Text("Un Handled State");
          }
        },
      ),
      bottomNavigationBar: SafeArea(
        child: SizedBox(
          height: 60,
          child: BlocBuilder<MoviesCubit, MoviesStates>(
            buildWhen: (previous, current) =>
                current is GetMoviesFromPaginationLoadingState || current is GetMoviesInitialState || current is GetMoviesSuccessState || current is GetMoviesFromPaginationFailedState,
            builder: (context, state) {
              if (state is GetMoviesFromPaginationLoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is GetMoviesFromPaginationFailedState) {
                return Center(
                  child: Text(state.msg),
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ),
      ),
    );
  }
}
