import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

part 'permissions_event.dart';
part 'permissions_state.dart';

class PermissionsBloc extends Bloc<PermissionsEvent, PermissionsState> {
  PermissionsBloc()
      : super(const PermissionsState(
            permissionStore: <Permission, PermissionStatus>{})) {
    on<PermissionRequested>(_onPermissionRequested);
  }

  Future<void> _onPermissionRequested(PermissionRequested event, emit) async {
    emit(
      state.copyWith(status: PermissionsStatus.asked),
    );
    Permission permission = event.permission;
    Map<Permission, PermissionStatus> permissionsStore = Map.from(state.permissionStore);
    final PermissionStatus status = await permission.request();
    permissionsStore.addAll({permission: status});
    emit(
      state.copyWith(
        status: PermissionsStatus.idle,
        permissionStore: permissionsStore,
      ),
    );
  }
}
