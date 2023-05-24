import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class LocationNotFoundView extends StatelessWidget {
  final VoidCallback getLocationCallback;
  final ValueSetter<int> changeScreenCallback;
  const LocationNotFoundView(
      {super.key,
      required this.getLocationCallback,
      required this.changeScreenCallback});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
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
            child: Text('Nenhuma cidade selecionada ou encontrada',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleSmall),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: _sendToSearchView,
              child: Text('Precione aqui para buscar um local',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('ou',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleSmall),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: getLocationCallback,
              child: Text(
                'Aqui para buscar sua localização',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _sendToSearchView() {
    changeScreenCallback(2);
  }
}
