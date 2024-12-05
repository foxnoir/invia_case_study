import 'package:flutter/material.dart';
import 'package:invia_case_study/core/log/logger.dart';
import 'package:invia_case_study/core/theme/consts.dart';

class AppCard extends StatelessWidget {
  const AppCard({
    required this.imgUrl,
    required this.content,
    required this.buttonText,
    required this.onButtonPressed,
    super.key,
  });

  final String imgUrl;
  final Widget content;
  final String buttonText;
  final VoidCallback onButtonPressed;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.network(
            imgUrl != '' ? imgUrl : AppImg.placeHolder,
            height: 150,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              try {} catch (ex) {
                logger.i(ex.toString());
              }
              return const Image(
                fit: BoxFit.fitHeight,
                image: AssetImage(AppImg.placeHolder),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: content,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onButtonPressed,
                child: Text(
                  buttonText,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
