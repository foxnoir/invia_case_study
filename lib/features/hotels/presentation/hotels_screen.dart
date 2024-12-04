import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:invia_case_study/features/hotels/presentation/bloc/hotels_bloc.dart';
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

  Future<void> _handleRefresh(BuildContext context) async {
    context.read<HotelsBloc>().add(const FetchHotelsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HotelsBloc, HotelsState>(
      builder: (context, state) {
        final hasError = state is HotelsError;
        final hasLoaded = state is HotelsLoaded;

        return AppScaffold(
          title: AppLocalizations.of(context)?.hotels ?? FallBackString.hotels,
          isLoading: state is HotelsLoading,
          isLoaded: state is HotelsLoaded,
          hasError: hasError,
          errorMessage: hasError ? state.message : 'eheysehvrhervh',
          hotels: hasLoaded ? state.hotels : [],
          onRefresh: () => _handleRefresh(context),
        );
      },
    );
  }
}
