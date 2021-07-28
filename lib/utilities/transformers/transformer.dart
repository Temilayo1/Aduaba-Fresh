import 'package:flutter/material.dart';
import 'package:transformer_page_view/transformer_page_view.dart';

class Transformer extends PageTransformer {
  Transformer() : super(reverse: false);

  @override
  Widget transform(Widget child, TransformInfo info) {
    double position = info.position;
    if (position < 0.0) {
      const double MIN_SCALE = 0;
      // Scale the page down (between MIN_SCALE and 1)
      double scaleFactor = MIN_SCALE + (1 - MIN_SCALE) * (1 + position);
      return Opacity(
        opacity: 1.0 + position,
        child: new Transform.scale(
          scale: scaleFactor,
          alignment: Alignment.centerLeft,
          child: child,
        ),
      );
    } else {
      return Opacity(
        opacity: 1.0,
        child: new Transform.scale(
          scale: 1,
          alignment: Alignment.centerRight,
          child: child,
        ),
      );
    }

    // if (position <= 0) {
    //   const double MIN_SCALE = 0.5;
    //   // Scale the page down (between MIN_SCALE and 1)
    //   double scaleFactor = MIN_SCALE + (1 - MIN_SCALE) * (1 + position);
    //
    //
    //   return new Opacity(
    //     opacity: 1.0 + position,
    //     child: new Transform.translate(
    //       offset: new Offset(-position * info.width, 0.0),
    //       child: new Transform.scale(
    //         // scale: scaleFactor,
    //         scale: 1.0 + position,
    //         alignment: Alignment.centerLeft,
    //         child: child,
    //       ),
    //     ),
    //   );
    // } else if (position <= 1) {
    //   return new Opacity(
    //     opacity: 1.0,
    //     child: new Transform.translate(
    //       offset: new Offset(0.0, 0.0),
    //       child: new Transform.scale(
    //         // scale: 1.0,
    //         scale: 1.0 - position,
    //         alignment: Alignment.centerRight,
    //         child: child,
    //       ),
    //     ),
    //   );
    // }

    // return child;
  }
}
