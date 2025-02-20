import 'package:flutter/material.dart';
import 'package:invia_case_study/core/theme/consts.dart';
import 'package:invia_case_study/features/hotels/domain/entities/hotel_entity.dart';
import 'package:invia_case_study/global_widgets/app_card/widgets/app_card_details_section.dart';
import 'package:invia_case_study/global_widgets/app_card/widgets/app_card_img_section.dart';

class AppCard extends StatelessWidget {
  const AppCard({
    required this.imgUrl,
    required this.buttonText,
    required this.hotel,
    required this.isFavoriteTab,
    required this.onButtonPressed,
    super.key,
  });

  final String imgUrl;
  final String buttonText;
  final VoidCallback? onButtonPressed;
  final HotelEntity hotel;
  final bool isFavoriteTab;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 4,
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppCardImgSection(
            imgUrl: imgUrl,
            hotel: hotel,
            isFavoriteTab: isFavoriteTab,
          ),
          AppCardDetailsSection(hotel: hotel, isFavoriteTab: isFavoriteTab),
          Padding(
            padding: const EdgeInsets.only(
              bottom: Consts.cardPadding,
              left: Consts.cardPadding,
              right: Consts.cardPadding,
            ),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onButtonPressed,
                child: Text(buttonText),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
