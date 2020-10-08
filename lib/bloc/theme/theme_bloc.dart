import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:words_app/config/themes.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc()
      : super(ThemeState(themeData: Themes.themeData[AppTheme.LightTheme]));

  @override
  Stream<ThemeState> mapEventToState(
    ThemeEvent event,
  ) async* {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (event is LoadedTheme) {
      yield* _mapLoadedThemeToState(prefs);
    } else if (event is UpdatedTheme) {
      yield* _mapUpdatedThemeToState(prefs);
    }
  }

  Stream<ThemeState> _mapLoadedThemeToState(SharedPreferences prefs) async* {
    yield* _mapSetTheme(prefs, prefs.getBool('isDarkMode') ?? false);
  }

  Stream<ThemeState> _mapUpdatedThemeToState(SharedPreferences prefs) async* {
    yield* _mapSetTheme(prefs, !prefs.getBool('isDarkMode') ?? false);
  }

  Stream<ThemeState> _mapSetTheme(
    SharedPreferences prefs,
    bool isDarkMode,
  ) async* {
    prefs.setBool('isDarkMode', isDarkMode);
    yield ThemeState(
        themeData: Themes
            .themeData[isDarkMode ? AppTheme.DarkTheme : AppTheme.LightTheme]);
  }
}
