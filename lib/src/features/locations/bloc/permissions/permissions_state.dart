part of 'permissions_bloc.dart';

enum PermissionsStatus {
  idle,
  asked,
}

final class PermissionsState extends Equatable {
  final Map<Permission, PermissionStatus> permissionStore;
  final PermissionsStatus status;

  const PermissionsState({
    this.status = PermissionsStatus.idle,
    required this.permissionStore,
  });

  PermissionsState copyWith({
    PermissionsStatus? status,
    Map<Permission, PermissionStatus>? permissionStore,
  }) {
    return PermissionsState(
      status: status ?? this.status,
      permissionStore: permissionStore ?? this.permissionStore,
    );
  }

  @override
  String toString() {
    return '''PermissionStatus { status: $status, permissions: ${permissionStore.length}}''';
  }

  @override
  List<Object?> get props => [status, permissionStore,];
}
