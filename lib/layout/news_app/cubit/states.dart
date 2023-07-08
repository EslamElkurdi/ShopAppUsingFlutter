
abstract class NewsAppStates {}

class NewsAppInitialState extends NewsAppStates {}

class NewsAppBottomNavBar extends NewsAppStates {}



class NewsAppGetBusinessLoadingState extends NewsAppStates {}

class NewsGetBusinessSuccessState extends NewsAppStates {}

class NewsGetBusinessErrorState extends NewsAppStates {

  final error;

  NewsGetBusinessErrorState(this.error);
}



class NewsAppGetScienceLoadingState extends NewsAppStates {}

class NewsGetScienceSuccessState extends NewsAppStates {}

class NewsGetScienceErrorState extends NewsAppStates {

  final error;

  NewsGetScienceErrorState(this.error);
}



class NewsAppGetSportsLoadingState extends NewsAppStates {}

class NewsGetSportsSuccessState extends NewsAppStates {}

class NewsGetSportsErrorState extends NewsAppStates {

  final error;

  NewsGetSportsErrorState(this.error);
}


class NewsAppDarkModeState extends NewsAppStates {

}

class NewsAppLightModeState extends NewsAppStates {

}


class NewsAppGetSearchLoadingState extends NewsAppStates {}

class NewsGetSearchSuccessState extends NewsAppStates {}

class NewsGetSearchErrorState extends NewsAppStates {

  final error;

  NewsGetSearchErrorState(this.error);
}