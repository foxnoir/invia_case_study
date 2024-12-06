import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:invia_case_study/features/favorites/presentation/bloc/favorites_bloc.dart';
import 'package:invia_case_study/features/network/errors/failure.dart';
import 'package:invia_case_study/global_widgets/app_scaffold/presentation/app_scaffold.dart';
import 'package:invia_case_study/l10n/de_fallback.dart';

@RoutePage()
class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FavoritesBloc()..add(const FetchFavoritesEvent()),
      child: const FavoritesView(),
    );
  }
}

class FavoritesView extends StatelessWidget {
  const FavoritesView({super.key});

  Future<void> _handleRefresh(BuildContext context) async {
    context.read<FavoritesBloc>().add(const FetchFavoritesEvent());
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FavoritesBloc>().add(const FetchFavoritesEvent());
    });

    return BlocBuilder<FavoritesBloc, FavoritesState>(
      builder: (context, state) {
        final localizations = AppLocalizations.of(context);
        final isLoading = state is FavoritesLoading;
        final hasError = state is FavoritesError;
        final hasLoaded = state is FavoritesLoaded;

        return AppScaffold(
          isFavoriteTab: true,
          title: localizations?.hotels ?? FallBackString.hotels,
          isLoading: isLoading,
          isLoaded: hasLoaded,
          hasError: hasError,
          errorMessage: hasError
              ? _handleErrorMessage(state.failure, context)
              : FallBackString.error,
          hotelList: hasLoaded ? state.favorites : [],
          onRefresh: () => _handleRefresh(context),
          buttonText: localizations?.toOffers ?? FallBackString.toOffers,
        );
      },
    );
  }
}
