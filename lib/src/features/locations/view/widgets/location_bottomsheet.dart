import 'package:effective_coffee/src/features/locations/bloc/map_bloc.dart';
import 'package:effective_coffee/src/features/locations/models/location_model.dart';
import 'package:effective_coffee/src/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LocationBottomSheet extends StatelessWidget {
  const LocationBottomSheet({super.key, required this.location});

  final LocationModel location;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 142,
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: 24,
          left: 10,
          right: 10,
        ),
        child: Column(
          children: [
            SizedBox(
              height: 52,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  location.address,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: ElevatedButton(
                onPressed: () {
                  context.read<MapBloc>().add(MapLocationChanged(location));
                  Navigator.of(context)
                    ..pop()
                    ..pop();
                },
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.maxFinite, 56),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16))),
                child: Text(
                  AppLocalizations.of(context)!.choose,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: AppColors.white,
                        letterSpacing: 0.4,
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
