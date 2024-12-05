part of 'account_bloc.dart';

abstract class AccountEvent extends Equatable {
  const AccountEvent();

  @override
  List<Object?> get props => [];
}

class ChangeLocaleEvent extends AccountEvent {
  const ChangeLocaleEvent(this.locale);
  final Locale locale;

  @override
  List<Object?> get props => [locale];
}
