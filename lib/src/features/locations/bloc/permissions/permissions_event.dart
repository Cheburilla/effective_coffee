part of 'permissions_bloc.dart';

@immutable
sealed class PermissionsEvent extends Equatable {
  const PermissionsEvent();
}

class PermissionRequested extends PermissionsEvent {
  final Permission permission;
  const PermissionRequested(
    this.permission,
  );

  @override
  String toString() => 'PermissionRequested { permission: ${permission.toString()} }';

  @override
  List<Object> get props => [
        permission,
      ];
}

