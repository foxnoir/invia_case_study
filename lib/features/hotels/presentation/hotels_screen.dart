import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:invia_case_study/core/utils/app_test_consts.dart';
import 'package:invia_case_study/features/hotels/presentation/bloc/hotels_bloc.dart';
import 'package:invia_case_study/features/network/errors/failure.dart';
import 'package:invia_case_study/global_widgets/app_scaffold/presentation/app_scaffold.dart';
import 'package:invia_case_study/l10n/de_fallback.dart';

@RoutePage()
class HotelsScreen extends StatelessWidget {
  const HotelsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppTestConsts.isRouteTesting
        ? Container()
        : BlocProvider(
            create: (_) => HotelsBloc()..add(const FetchHotelsEvent()),
            child: const HotelsView(),
          );
  }
}

class HotelsView extends StatelessWidget {
  const HotelsView({super.key});

  Future<void> _handleRefresh(BuildContext context) async {
    context.read<HotelsBloc>().add(const FetchHotelsEvent());
  }

  String _handleErrorMessage(Failure failure, BuildContext context) {
    final localizations = AppLocalizations.of(context);
    if (failure is ApiFailure &&
        failure.message.contains('No internet connection')) {
      return localizations?.noInternet ?? FallBackString.noInternet;
    }
    return localizations?.error ?? FallBackString.error;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HotelsBloc, HotelsState>(
      builder: (context, state) {
        final localizations = AppLocalizations.of(context);
        final isLoading = state is HotelsLoading;
        final hasError = state is HotelsError;
        final hasLoaded = state is HotelsLoaded;

        return AppScaffold(
          isFavoriteTab: false,
          title: localizations?.hotels ?? FallBackString.hotels,
          isLoading: isLoading,
          isLoaded: hasLoaded,
          hasError: hasError,
          errorMessage: hasError
              ? _handleErrorMessage(state.failure, context)
              : FallBackString.error,
          hotelList: hasLoaded ? state.hotels : [],
          onRefresh: () => _handleRefresh(context),
          buttonText: localizations?.toOffers ?? FallBackString.toOffers,
          location: hasLoaded ? state.location : '',
        );
      },
    );
  }
}
