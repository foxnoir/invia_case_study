import 'package:flutter/material.dart';
import 'package:invia_case_study/core/theme/consts.dart';

class AppCardDetailsTextRow extends StatelessWidget {
  const AppCardDetailsTextRow({
    required this.leftText,
    required this.rightText,
    required this.context,
    super.key,
  });
  final String leftText;
  final String rightText;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 4, right: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Text(
              leftText,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodySmall,
            ),
          ),
          SizedBox(
            height: 18,
            child: VerticalDivider(
              color: AppColor.grey.withOpacity(0.4),
            ),
          ),
          Flexible(
            child: Text(
              rightText,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}
