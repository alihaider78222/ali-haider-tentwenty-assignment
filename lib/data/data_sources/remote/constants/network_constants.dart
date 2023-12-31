import 'package:mobx_example/core/dio/configs/dio_configs.dart';

class NetworkConstants {
  NetworkConstants._();

  // URLs:----------------------------------------------------------------------
  static const String baseUrlDev = 'https://dev-abc.com/';
  static const String baseUrlQa = 'https://qa-abccom/';
  static const String baseUrlProd = 'https://api.themoviedb.org/3/';

  // timeouts:------------------------------------------------------------------
  static const int receiveTimeout = kDefaultReceiveTimeout;
  static const int connectionTimeout = kDefaultConnectionTimeout;
  static const int cacheTimeOut = kDefaultCacheTimeOutInMinutes;

  // image
  static const String imageUrl = "http://image.tmdb.org/t/p/w500";

  // http://api.themoviedb.org/3/movie/157336/videos

  // urls
  static const String upComingMoviesUrl = "movie/upcoming";
  static const String movieDetailUrl = "movie";
  static const String searchMoviesUrl = "search/movie";
}
