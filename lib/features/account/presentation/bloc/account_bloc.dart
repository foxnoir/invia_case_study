import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:invia_case_study/core/di/di.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc({SharedPreferences? sharedPreferences})
      : _sharedPreferences = sharedPreferences ?? DI.getIt<SharedPreferences>(),
        super(
          AccountState(
            locale: _loadInitialLocale(
              sharedPreferences ?? DI.getIt<SharedPreferences>(),
            ),
          ),
        ) {
    on<ChangeLocaleEvent>(_onChangeLocale);
  }

  final SharedPreferences _sharedPreferences;
  static const String _localeKey = 'LOCALE';

  static Locale _loadInitialLocale(SharedPreferences prefs) {
    final localeCode = prefs.getString(_localeKey) ?? 'de';
    return Locale(localeCode);
  }

  Future<void> _onChangeLocale(
    ChangeLocaleEvent event,
    Emitter<AccountState> emit,
  ) async {
    await _sharedPreferences.setString(_localeKey, event.locale.languageCode);
    emit(state.copyWith(locale: event.locale));
  }

  Locale get currentLocale => state.locale;
}
