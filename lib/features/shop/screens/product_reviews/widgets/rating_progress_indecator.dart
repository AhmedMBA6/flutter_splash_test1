import 'package:flutter/material.dart';

import '../../../../../utils/constants/sizes.dart';
import 'progress_indecator_and_rating.dart';

class MOverallProductRating extends StatelessWidget {
  const MOverallProductRating({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            '4.4',
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
        const SizedBox(width: MSizes.spaceBetweenItems,),
        const Expanded(
          flex: 7,
          child: Column(
            children: [
              MRatingProgressIndicator(
                text: '5',
                value: 1.0,
              ),
              MRatingProgressIndicator(
                text: '4',
                value: 0.8,
              ),
              MRatingProgressIndicator(
                text: '3',
                value: 0.6,
              ),
              MRatingProgressIndicator(
                text: '2',
                value: 0.4,
              ),
              MRatingProgressIndicator(
                text: '1',
                value: 0.2,
              ),
            ],
          ),
        )
      ],
    );
  }
}
