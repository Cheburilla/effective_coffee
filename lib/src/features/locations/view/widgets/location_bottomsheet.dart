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
    return /*SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.91,
      child:*/
        DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          //top: 18,
          bottom: 10,
          left: 10,
          right: 10,
        ),
        child: Scaffold(
          body: ColoredBox(
            color: AppColors.white,
            child: Column(
              children: [
                SizedBox(
                  width:
                      Theme.of(context).bottomSheetTheme.dragHandleSize?.width,
                  height:
                      Theme.of(context).bottomSheetTheme.dragHandleSize?.height,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Theme.of(context).bottomSheetTheme.dragHandleColor,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    context.read<MapBloc>().add(MapLocationChanged(location));
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.maxFinite, 56),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.choose,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: AppColors.white,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
