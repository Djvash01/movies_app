import 'package:flutter/material.dart';
import 'package:movies_app/Models/models.dart';
import 'package:movies_app/widgets/widgets.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(
            title: movie.title,
            backdropPath: movie.fullBackdropPath,
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              _PosterAndTitle(
                id: movie.heroId!,
                title: movie.title,
                originalTitle: movie.originalTitle,
                rating: movie.voteAverage.toString(),
                posterPath: movie.fullPosterImg,
              ),
              _Overview(description: movie.overview,),
              _Overview(description: movie.overview,),
              _Overview(description: movie.overview,),
              CastingCard(movieId: movie.id,),
            ]),
          ),
        ],
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  final String title;
  final String backdropPath;
  const _CustomAppBar(
      {Key? key, required this.title, required this.backdropPath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          color: Colors.black12,
          padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
          alignment: Alignment.bottomCenter,
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
        ),
        background: FadeInImage(
          placeholder: const AssetImage('assets/loading.gif'),
          image: NetworkImage(backdropPath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {
  final String id;
  final String title;
  final String posterPath;
  final String originalTitle;
  final String rating;
  const _PosterAndTitle(
      {Key? key,
      required this.id,
      required this.title,
      required this.posterPath,
      required this.originalTitle,
      required this.rating})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(children: [
        Hero(
          tag: id,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              height: 150,
              placeholder: const AssetImage('assets/no-image.jpg'),
              image: NetworkImage(posterPath),
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: textTheme.headline5,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              Text(
                originalTitle,
                style: textTheme.subtitle1,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.star_outlined,
                    size: 15,
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    rating,
                    style: textTheme.caption,
                  ),
                ],
              ),
            ],
          ),
        )
      ]),
    );
  }
}

class _Overview extends StatelessWidget {
  final String description;
  const _Overview({Key? key, required this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Text(
        description,
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }
}
