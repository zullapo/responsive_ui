import 'package:flutter/material.dart';

import '../responsive_ui.dart';

/// Use this inside `Responsive()`
///
/// This Widget requires `Finite width`
class Div extends StatelessWidget {
  final Widget child;
  final Division division;
  final double additionalWidth;
  final double growWidthPercentage;

  const Div({
    Key? key,
    this.division = const Division(),
    required this.child,
    this.additionalWidth = 0,
    this.growWidthPercentage = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int col = 0;
    int offset = 0;
    final double width = MediaQuery.of(context).size.width;
    if (width < Responsive.startColS) {
      col = division.colXS;
      offset = division.offsetXS;
    } else if (width < Responsive.startColM) {
      col = division.widthS;
      offset = division.offsetS;
    } else if (width < Responsive.startColL) {
      col = division.widthM;
      offset = division.offsetM;
    } else if (width < Responsive.startColXL) {
      col = division.widthL;
      offset = division.offsetL;
    } else {
      col = division.widthXL;
      offset = division.offsetXL;
    }

    if (col == 0) {
      return const SizedBox.shrink();
    }

    return LayoutBuilder(
      builder: (ctx, box) {
        final double singleBox = box.maxWidth / 12;
        final double childWidth = singleBox * col;
        final double childOffset = singleBox * offset;

        ///
        /// #5 fixed by @Chappie74
        ///
        final double otherWidths = (12 - col) * singleBox;

        /// Recaluclate childWidth as the calulated width souldn't be greater than box.maxWidth
        final double recalculatedChildWidth = (childWidth + otherWidths) > box.maxWidth
            ? childWidth - ((childWidth + otherWidths) - box.maxWidth)
            : childWidth;

        return SizedBox(
          width: (recalculatedChildWidth + childOffset + additionalWidth) * growWidthPercentage,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              SizedBox(
                width: (recalculatedChildWidth + additionalWidth) * growWidthPercentage,
                child: child,
              ),
            ],
          ),
        );
      },
    );
  }
}
