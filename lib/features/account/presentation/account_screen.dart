import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:invia_case_study/core/theme/consts.dart';
import 'package:invia_case_study/features/account/presentation/bloc/account_bloc.dart';
import 'package:invia_case_study/l10n/de_fallback.dart';

@RoutePage()
class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appLocalizations = AppLocalizations.of(context);

    return BlocBuilder<AccountBloc, AccountState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              appLocalizations?.account ?? FallBackString.account,
            ),
            actions: [
              GestureDetector(
                onTap: () {
                  final currentLocale =
                      context.read<AccountBloc>().state.locale.languageCode;
                  final newLocale = currentLocale == 'en'
                      ? const Locale('de')
                      : const Locale('en');
                  context.read<AccountBloc>().add(ChangeLocaleEvent(newLocale));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Image.asset(
                    state.locale.languageCode == 'de'
                        ? AppImg.en_flag
                        : AppImg.de_flag,
                    height: 25,
                  ),
                ),
              ),
            ],
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: theme.colorScheme.secondary,
                    child: Icon(
                      Icons.person,
                      size: 50,
                      color: theme.colorScheme.surface,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Fox Noir',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(),
                    child: SizedBox(
                      width: double.infinity,
                      child: Center(
                        child: Text(
                          appLocalizations?.editAccount ??
                              FallBackString.editAccount,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
