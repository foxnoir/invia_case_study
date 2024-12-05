import 'package:flutter/material.dart';
import 'package:invia_case_study/core/theme/consts.dart';
import 'package:invia_case_study/features/hotels/domain/entities/hotel.dart';
import 'package:invia_case_study/global_widgets/app_card/app_card_details_section.dart';
import 'package:invia_case_study/global_widgets/app_card/app_card_img_section.dart';

class AppCard extends StatelessWidget {
  const AppCard({
    required this.imgUrl,
    required this.buttonText,
    required this.onButtonPressed,
    required this.hotel,
    this.content,
    super.key,
  });

  final String imgUrl;
  final Widget? content;
  final String buttonText;
  final VoidCallback onButtonPressed;
  final Hotel hotel;

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
          AppCardImgSection(content: content, imgUrl: imgUrl, hotel: hotel),
          AppCardDetailsSection(hotel: hotel),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: Consts.cardPadding),
            child: Divider(),
          ),
          if (content != null)
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Consts.cardPadding,
              ),
              child: content,
            ),
          Padding(
            padding: const EdgeInsets.all(Consts.cardPadding),
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
