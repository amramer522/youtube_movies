import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'views/movie_details/cubit.dart';
import 'views/movie_details/view.dart';
import 'views/movies/cubit.dart';
import 'views/movies/view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => MovieDetailsCubit(),),
        BlocProvider(create: (context) => MoviesCubit(),),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.brown),
        home: const MoviesView(),
      ),
    );
  }
}
