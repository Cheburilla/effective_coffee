part of 'menu_bloc.dart';

@immutable
sealed class MenuEvent{
  const MenuEvent();
}

class CategoryLoadingStarted extends MenuEvent {
  const CategoryLoadingStarted();

  @override
  String toString() => 'CategoryLoadingStarted';

}

class PageLoadingStarted extends MenuEvent {

  const PageLoadingStarted();

  @override
  String toString() => 'PageLoadingStarted';

}
