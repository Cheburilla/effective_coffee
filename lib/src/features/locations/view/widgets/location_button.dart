import 'package:effective_coffee/src/features/locations/bloc/map_bloc.dart';
import 'package:effective_coffee/src/features/locations/view/map_screen.dart';
import 'package:effective_coffee/src/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocationButton extends StatelessWidget {
  const LocationButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapBloc, MapState>(builder: (context, state) {
      if (state.status == MapStatus.idle) {
        final currentLocation = state.currentLocation;
        if (currentLocation != null) {
          return SizedBox(
            height: 40,
            child: InkWell(
              onTap: () => {_navigateToMap(context)},
              child: Row(
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    color: AppColors.lightblue,
                    size: 24,
                  ),
                  Text(currentLocation.address),
                ],
              ),
            ),
          );
        }
      }
      return const SizedBox.shrink();
    });
  }

  Future<void> _navigateToMap(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MapScreen()),
    );
  }
}
