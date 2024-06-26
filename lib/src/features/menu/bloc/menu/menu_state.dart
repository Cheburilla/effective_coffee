part of 'menu_bloc.dart';

enum MenuStatus {
  progress,
  success,
  error,
  idle,
}

final class MenuState extends Equatable {
  final MenuStatus status = MenuStatus.idle;
  final List<CategoryModel> categories;
  final List<ProductModel> items;

  const MenuState({
    required this.categories,
    required this.items,
    required MenuStatus status,
  });

  MenuState copyWith({
    List<CategoryModel>? categories,
    List<ProductModel>? items,
    MenuStatus? status,
  }) {
    return MenuState(
      status: status ?? this.status,
      categories: categories ?? this.categories,
      items: items ?? this.items,
    );
  }

  @override
  String toString() {
    return '''MenuStatus { status: $status, categories: ${categories.length}, items: ${items.length} }''';
  }

  @override
  List<Object?> get props => [
        status,
        categories,
        items,
      ];
}
