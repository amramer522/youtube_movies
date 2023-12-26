import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit.dart';

class MovieDetailsView extends StatelessWidget {
  final int id;

  const MovieDetailsView({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MovieDetailsCubit cubit = BlocProvider.of(context);
    cubit.getData(id);
    return Scaffold(
      appBar: AppBar(title: Text("Movie Details $id")),
      body: BlocBuilder(
        bloc: cubit,
        builder: (context, state) {
          if (state is GetMovieDetailsFailedState) {
            return const Center(child: Text("Failed"));
          } else if (state is GetMovieDetailsSuccessState) {
            MovieDetails model = state.model;
            return ListView(
              children: [
                Container(
                  padding: EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Theme.of(context).primaryColor.withOpacity(.1),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    children: [
                      Image.network(
                        model.backdropPath,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Text(
                              model.title,
                              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Text(
                              model.overview,
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Theme.of(context).hintColor),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.orange,
                                ),
                                const SizedBox(
                                  width: 3,
                                ),
                                Text(
                                  model.voteAverage.toString(),
                                  style: TextStyle(fontWeight: FontWeight.w700, color: Colors.orange),
                                ),
                                Image.network(
                                  model.posterPath,
                                  height: 200,
                                  fit: BoxFit.cover,
                                ),
                              ],
                            ),
                            Text(model.releaseDate),
                            Text(model.budget.toString()),
                            Text(model.revenue.toString()),
                            Text(model.homepage),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
