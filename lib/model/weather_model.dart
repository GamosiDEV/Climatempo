import 'package:flutter/material.dart';

class WeatherModel {
  var temperature;
  var feelsLike;
  var minimum;
  var maximum;
  var humidity;
  var sky;
  var clouds;
  var windSpeed;
  var windDegree;
  var rain;
  var dateTime;
  AssetImage icon;

  List weekdays = [
    'Domingo',
    "Segunda-Feira",
    'Terça-Feira',
    'Quarta-Feira',
    'Quinta-Feira',
    'Sexta-Feira',
    'Sabado',
  ];
  List windDirections = [
    '↑ N',
    '↗ NE',
    '→ E',
    '↘ SE',
    '↓ S',
    '↙ SW',
    '← W',
    '↖ NW'
  ];

  WeatherModel(
      {this.temperature,
      this.feelsLike,
      this.minimum,
      this.maximum,
      this.humidity,
      this.sky,
      this.clouds,
      this.windSpeed,
      this.windDegree,
      this.rain,
      this.dateTime,
      this.icon = const AssetImage("lib/assets/icons/01d.png")});

  factory WeatherModel.fromJsonForWeather(Map<String, dynamic> json) {
    return WeatherModel(
      temperature:
          ((json['main']['temp'] - 273.1).toStringAsFixed(0)).toString() + "°",
      feelsLike:
          ((json['main']['feels_like'] - 273.1).toStringAsFixed(0)).toString() +
              "°",
      minimum:
          ((json['main']['temp_min'] - 273.1).toStringAsFixed(0)).toString() +
              "°",
      maximum:
          ((json['main']['temp_max'] - 273.1).toStringAsFixed(0)).toString() +
              "°",
      humidity: json['main']['humidity'].toString() + "%",

      clouds: json['clouds']['all'].toString() + "%",
      windSpeed: ((json['wind']['speed'] * 3.6).toStringAsFixed(2)).toString() +
          "Km/H",
      windDegree: WeatherModel()
          .windDirections[((json['wind']['deg'] / 45) % 8).round()],
      rain: json['rain'] != null ? json['rain']['1h'].toString() : "0",
      dateTime: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),

      //baseado nos codigos setar: icone/situação/descrição
      sky: WeatherModel().skySituation(json['weather'][0]['id']),

      icon:
          AssetImage("lib/assets/icons/" + json['weather'][0]['icon'] + ".png"),
    );
  }

  String skySituation(int skyId) {
    if (skyId >= 200 && skyId <= 232) {
      return "Tempestuoso";
    } else if (skyId >= 300 && skyId <= 321) {
      return "Garoando";
    } else if (skyId >= 500 && skyId <= 531) {
      return "Chuvoso";
    } else if (skyId >= 600 && skyId <= 622) {
      return "Nevando";
    } else if (skyId >= 701 && skyId <= 799) {
      if (skyId == 701) {
        return "Enevoado";
      } else if (skyId == 711) {
        return "Esfumaçado";
      } else if (skyId == 721) {
        return "Enevoado por fumaça";
      } else if (skyId == 731 || skyId == 761 || skyId == 751) {
        return "com Poeira/Areia";
      } else if (skyId == 741) {
        return "com Neblina";
      } else if (skyId == 762) {
        return "com Cinzas";
      } else if (skyId == 771) {
        return "com Ventos Fortes";
      } else if (skyId == 781) {
        return "estado de Tornado";
      }
    } else if (skyId >= 800 && skyId <= 804) {
      return "Nublado";
    }
    return "Limpo";
  }
}
