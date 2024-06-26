import 'package:effective_coffee/src/features/locations/bloc/map/map_bloc.dart';
import 'package:effective_coffee/src/features/locations/models/location_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LocationsList extends StatelessWidget {
  final List<LocationModel> locations;

  const LocationsList({super.key, required this.locations});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: SizedBox(
                  height: 52,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 24),
                        child: InkWell(
                          child: const Icon(
                            Icons.arrow_back,
                            size: 20,
                          ),
                          onTap: () => Navigator.of(context)
                            ..pop()
                            ..pop(),
                        ),
                      ),
                      Text(
                        AppLocalizations.of(context)!.ourCoffeeshops,
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        title: Text(
                          locations[index].address,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                          size: 20,
                        ),
                        onTap: () {
                          context.read<MapBloc>().add(
                                MapLocationChanged(locations[index]),
                              );
                          Navigator.of(context)
                            ..pop(locations[index])
                            ..pop(locations[index]);
                        },
                      ),
                    );
                  },
                  itemCount: locations.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
