import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/weather_cubit/weather_cubit.dart';
import 'package:weather_app/cubits/weather_cubit/weather_state.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/pages/search_page.dart';
import 'package:weather_app/pages/shared/success_state.dart';

import 'shared/default_home.dart';

class HomePage extends StatelessWidget {
  // WeatherModel? weatherData;
  @override
  Widget build(BuildContext context) {
    // weatherData = BlocProvider.of<WeatherCubit>(context).weatherModel;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return SearchPage();
              }));
            },
            icon: const Icon(Icons.search),
          ),
        ],
        title: const Text('Weather App'),
      ),
      body: BlocBuilder<WeatherCubit, WeatherState>(
        builder: (context, state) {
          if (state is WeatherLoading) {
            return const LoadingState();
          } else if (state is WeatherSuccess) {
            return SuccessBody(weatherData: state.weatherModel);
          } else if (state is WeatherFailure) {
            return const FailureState();
          } else {
            return const DefaultHomePage();
          }
        },
      ),
    );
  }
}

class FailureState extends StatelessWidget {
  const FailureState({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Not Found'),
    );
  }
}

class LoadingState extends StatelessWidget {
  const LoadingState({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
