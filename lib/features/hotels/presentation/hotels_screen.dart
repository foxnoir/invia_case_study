import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:invia_case_study/features/hotels/presentation/bloc/hotels_bloc.dart';
import 'package:invia_case_study/features/router/app_router.dart';
import 'package:invia_case_study/l10n/de_fallback.dart';

@RoutePage()
class HotelsScreen extends StatelessWidget {
  const HotelsScreen({super.key});

  static MaterialPage<void> page() {
    return const MaterialPage(
      name: HotelsRoute.name,
      key: ValueKey(HotelsRoute.name),
      child: HotelsScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HotelsBloc()..add(InitStateEvent()),
      child: const HotelsView(),
    );
  }
}

class HotelsView extends StatelessWidget {
  const HotelsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(AppLocalizations.of(context)?.hotels ?? FallBackString.hotels),
      ),
      body: BlocBuilder<HotelsBloc, HotelsState>(
        builder: (context, state) {
          if (state is HotelsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HotelsLoaded) {
            return ListView.builder(
              itemCount: state.hotels.length,
              itemBuilder: (context, index) {
                final hotel = state.hotels[index];
                return ListTile(
                  title: Text(hotel.name),
                  subtitle: Text(hotel.destination),
                );
              },
            );
          } else if (state is HotelsError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return const Center(child: Text('Start by fetching hotels'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            context.read<HotelsBloc>().add(const FetchHotelsEvent()),
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
