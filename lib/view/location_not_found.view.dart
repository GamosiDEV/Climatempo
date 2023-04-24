import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class LocaionNotFoundView extends StatelessWidget {
  const LocaionNotFoundView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(Icons.location_off,
              size: MediaQuery.of(context).size.width * 0.25),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Sua localização não foi encontrada',
              style: Theme.of(context).textTheme.subtitle1),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: _sendToSearchView,
            child: Text('Precione para buscar um local',
                style: Theme.of(context).textTheme.subtitle2),
          ),
        ),
      ],
    );
  }

  void _sendToSearchView() {}
}
