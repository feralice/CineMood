import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cinemood/constantes/constants.dart';
import 'package:cinemood/model/movie_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MovieCarousel extends StatefulWidget {

  final List<MovieModel>movieList;
  const MovieCarousel({Key? key, required this.movieList}) : super(key: key);

  @override
  State<MovieCarousel> createState() => _MovieCarouselState();
}

class _MovieCarouselState extends State<MovieCarousel> {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
        itemCount: widget.movieList.length,
        itemBuilder: (context,itemIndex,pageViewIndex) {
          return CachedNetworkImage(
              width: double.infinity,
              fit: BoxFit.fill,
              placeholder: (context, url) => Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => Icon(Icons.error),
              imageUrl: kmoviedbImageurl
              + widget.movieList[itemIndex].posterPath.toString());

        },
        options: CarouselOptions(
          height: 180,
          autoPlay: true,
          enlargeCenterPage: true,
          aspectRatio: 16/9
        ));
  }
}
