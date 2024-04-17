import 'package:effective_coffee/src/features/locations/bloc/map_bloc.dart';
import 'package:effective_coffee/src/features/locations/models/location_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LocationsList extends StatelessWidget {
  final List<LocationModel> locations;

  const LocationsList({super.key, required this.locations});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(
                Icons.arrow_back,
                size: 20,
              ),
              Text(AppLocalizations.of(context)!.ourCoffeeshops),
            ],
          ),
          const Divider(),
          ListView.builder(
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: ListTile(
                  title: Text(
                    locations[index].address,
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    context.read<MapBloc>().add(
                          MapLocationChanged(locations[index]),
                        );
                    Navigator.of(context)
                      ..pop()
                      ..pop();
                  },
                ),
              );
            },
            itemCount: locations.length,
          )
        ],
      ),
    );
  }
}
