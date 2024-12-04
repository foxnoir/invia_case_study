import 'package:flutter/material.dart';
import 'package:invia_case_study/core/theme/consts.dart';
import 'package:invia_case_study/core/theme/theme_helpers.dart';
import 'package:invia_case_study/features/hotels/domain/entities/hotel.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    required this.title,
    required this.isLoading,
    required this.isLoaded,
    required this.hasError,
    required this.hotels,
    required this.errorMessage,
    required this.onRefresh,
    super.key,
  });

  final String title;
  final bool isLoading;
  final bool isLoaded;
  final bool hasError;
  final List<Hotel> hotels;
  final String errorMessage;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: onRefresh,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  title,
                  style: theme.appBarTheme.titleTextStyle,
                ),
              ),
            ),
            if (isLoading)
              const SliverFillRemaining(
                child: Center(child: CircularProgressIndicator()),
              )
            else if (hasError)
              SliverFillRemaining(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        AppImg.sadPalm,
                        height: getHeight(context) * .4,
                      ),
                      const SizedBox(height: 35),
                      Text(
                        errorMessage,
                        style: theme.textTheme.headlineMedium?.copyWith(
                          color: theme.colorScheme.secondary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              )
            else
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final hotel = hotels[index];
                    return ListTile(
                      title: Text(hotel.name),
                      subtitle: Text(hotel.destination),
                      leading: const Icon(Icons.hotel),
                      onTap: () {},
                    );
                  },
                  childCount: hotels.length,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
