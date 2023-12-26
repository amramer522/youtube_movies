import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:youtube_movies/views/weather/model.dart';

class WeatherView extends StatefulWidget {
  const WeatherView({Key? key}) : super(key: key);

  @override
  State<WeatherView> createState() => _WeatherViewState();
}

class _WeatherViewState extends State<WeatherView> {
  final cityController = TextEditingController(text: "mansoura");

  bool isLoading = false;
  bool isFailed = false;
  WeatherData? model;

  getData() async {
    isLoading = true;
    setState(() {});

    try {
      final response = await Dio().get("https://api.openweathermap.org/data/2.5/weather?q=${cityController.text}&appid=509dc5d730ff2dd6003b22f30ae93313");
      print(response.data);
      model = WeatherData.fromJson(response.data);
    } on DioException catch (ex) {
      isFailed = true;
    }

    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Weather App")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            TextFormField(
              controller: cityController,
            ),
            SizedBox(
              height: 16,
            ),
            ElevatedButton(
                onPressed: () {
                  getData();
                },
                child: Text("Get")),
            isLoading
                ? CircularProgressIndicator()
                : isFailed
                    ? Center(
                        child: Text("Failed"),
                      )
                    : model != null
                        ? Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.network("https://openweathermap.org/img/wn/${model!.weather[0].icon}@2x.png",height: 200,width: 200,fit: BoxFit.fill,),
                              Text(model!.main.temp.toString()),
                              Text(model!.name),
                              Text(
                                model!.wind.speed.toString(),
                              ),
                            ],
                          )
                        : SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
