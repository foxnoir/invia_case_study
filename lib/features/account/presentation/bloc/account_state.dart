part of 'account_bloc.dart';

class AccountState extends Equatable {
  const AccountState({required this.locale});
  final Locale locale;

  AccountState copyWith({Locale? locale}) {
    return AccountState(
      locale: locale ?? this.locale,
    );
  }

  @override
  List<Object?> get props => [locale];
}
