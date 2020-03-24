part of 'main_screen_bloc.dart';

abstract class MainScreenEvent extends Equatable {
  const MainScreenEvent();
}

class PageSelected extends MainScreenEvent{
  final int index;

  PageSelected(this.index);

  @override 
  List<Object> get props =>[index];
  
}