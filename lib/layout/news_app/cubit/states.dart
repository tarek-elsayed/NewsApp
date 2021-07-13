abstract class NewsStates{}


class NewsInitialStates extends NewsStates{}

class NewsBottomNavStates extends NewsStates{}

class NewsGetBusinessSuccessStates extends NewsStates{}

class NewsGetBusinessLoadingStates extends NewsStates{}

class NewsGetBusinessErrorsStates extends NewsStates{
  final String error;
  NewsGetBusinessErrorsStates(this.error);
}

class NewsGetScienceSuccessStates extends NewsStates{}

class NewsGetScienceLoadingStates extends NewsStates{}

class NewsGetScienceErrorsStates extends NewsStates{
  final String error;
  NewsGetScienceErrorsStates(this.error);
}


class NewsGetSportsSuccessStates extends NewsStates{}

class NewsGetSportsLoadingStates extends NewsStates{}

class NewsGetSportsErrorsStates extends NewsStates{
  final String error;
  NewsGetSportsErrorsStates(this.error);
}

class NewsGetSearchSuccessStates extends NewsStates{}

class NewsGetSearchLoadingStates extends NewsStates{}

class NewsGetSearchErrorsStates extends NewsStates{
  final String error;
  NewsGetSearchErrorsStates(this.error);
}