import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:invia_case_study/features/hotels/presentation/bloc/hotels_bloc.dart';
import 'package:invia_case_study/features/network/errors/failure.dart';
import 'package:invia_case_study/global_widgets/app_scaffold.dart';
import 'package:invia_case_study/l10n/de_fallback.dart';

@RoutePage()
class HotelsScreen extends StatelessWidget {
  const HotelsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HotelsBloc()..add(const FetchHotelsEvent()),
      child: const HotelsView(),
    );
  }
}

class HotelsView extends StatelessWidget {
  const HotelsView({super.key});

  Future<void> _handleRefresh({required BuildContext context}) async {
    context.read<HotelsBloc>().add(const FetchHotelsEvent());
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return BlocBuilder<HotelsBloc, HotelsState>(
      builder: (context, state) {
        final hasError = state is HotelsError;
        final hasLoaded = state is HotelsLoaded;

        return AppScaffold(
          title: localizations?.hotels ?? FallBackString.hotels,
          isLoading: state is HotelsLoading,
          isLoaded: state is HotelsLoaded,
          hasError: hasError,
          errorMessage: hasError
              ? _handleErrorMessage(state.failure, context)
              : FallBackString.error,
          hotels: hasLoaded ? state.hotels : [],
          onRefresh: () => _handleRefresh(context: context),
          buttonText: localizations?.toTheOffers ?? FallBackString.toTheOffers,
          location: hasLoaded ? state.location : '',
        );
      },
    );
  }

  String _handleErrorMessage(Failure failure, BuildContext context) {
    final localizations = AppLocalizations.of(context);
    if (failure is ApiFailure) {
      if (failure.message.contains('No internet connection')) {
        return localizations?.noInternet ?? FallBackString.noInternet;
      }
    }
    return localizations?.error ?? FallBackString.error;
  }
}
