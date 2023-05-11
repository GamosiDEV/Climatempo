class WeatherModel {
  var temperature;
  var feelsLike;
  var minimum;
  var maximum;
  var humidity;
  var sky;
  var description;
  var clouds;
  var windSpeed;
  var windDegree;
  var gust;
  var rain;
  var dateTime;

  WeatherModel({
    this.temperature,
    this.feelsLike,
    this.minimum,
    this.maximum,
    this.humidity,
    this.sky,
    this.description,
    this.clouds,
    this.windSpeed,
    this.windDegree,
    this.gust,
    this.rain,
    this.dateTime,
  });

  factory WeatherModel.fromJsonForWeather(Map<String, dynamic> json) {
    return WeatherModel(
      temperature: (json['main']['temp'] - 273.1).toStringAsFixed(0),
      feelsLike: json['main']['feels_like'],
      minimum: (json['main']['temp_min'] - 273.1).toStringAsFixed(0),
      maximum: (json['main']['temp_max'] - 273.1).toStringAsFixed(0),
      humidity: json['main']['humidity'],
      sky: json['weather'][0]['main'],
      description: json['weather'][0]['description'],
      clouds: json['clouds']['all'],
      windSpeed: json['wind']['speed'] * 3.6,
      windDegree: json['wind']['deg'],
      gust: json['wind']['gust'],
      rain: json['rain'] != null ? json['rain']['1h'] : 0.0,
      dateTime: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
    );
  }
}
