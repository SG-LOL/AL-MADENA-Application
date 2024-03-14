import 'package:flutter/material.dart';
import '../core/app_export.dart';

/// A collection of pre-defined text styles for customizing text appearance,
/// categorized by different font families and weights.
/// Additionally, this class includes extensions on [TextStyle] to easily apply specific font families to text.

class CustomTextStyles {
  // Body text style
  static get bodyLargeABeeZeeBlack900 =>
      theme.textTheme.bodyLarge!.aBeeZee.copyWith(
        color: appTheme.black900,
        fontSize: 18.fSize,
      );
  static get bodyLargeABeeZeeBlack90017 =>
      theme.textTheme.bodyLarge!.aBeeZee.copyWith(
        color: appTheme.black900,
        fontSize: 17.fSize,
      );
  static get bodyLargeBlack900 => theme.textTheme.bodyLarge!.copyWith(
        color: appTheme.black900,
        fontSize: 18.fSize,
      );
  static get bodyLargeGray60001 => theme.textTheme.bodyLarge!.copyWith(
        color: appTheme.gray60001,
      );
  static get bodyLargeMontserratBlack900 =>
      theme.textTheme.bodyLarge!.montserrat.copyWith(
        color: appTheme.black900,
        fontSize: 18.fSize,
      );
  static get bodyLargeMontserratBlack90019 =>
      theme.textTheme.bodyLarge!.montserrat.copyWith(
        color: appTheme.black900,
        fontSize: 19.fSize,
      );
  static get bodyLargeMontserratGray80002 =>
      theme.textTheme.bodyLarge!.montserrat.copyWith(
        color: appTheme.gray80002,
      );
  static get bodyLargeMontserratGray80002_1 =>
      theme.textTheme.bodyLarge!.montserrat.copyWith(
        color: appTheme.gray80002,
      );
  static get bodyLargeMontserratGray900 =>
      theme.textTheme.bodyLarge!.montserrat.copyWith(
        color: appTheme.gray900,
      );
  static get bodyLargeMontserratIndigoA700 =>
      theme.textTheme.bodyLarge!.montserrat.copyWith(
        color: appTheme.indigoA700,
        fontSize: 18.fSize,
      );
  static get bodyLargeMontserratIndigoA70001 =>
      theme.textTheme.bodyLarge!.montserrat.copyWith(
        color: appTheme.indigoA70001,
        fontSize: 18.fSize,
      );
  static get bodyLargeMontserratOnPrimary =>
      theme.textTheme.bodyLarge!.montserrat.copyWith(
        color: theme.colorScheme.onPrimary,
        fontSize: 18.fSize,
      );
  static get bodyMediumABeeZeeBlack900 =>
      theme.textTheme.bodyMedium!.aBeeZee.copyWith(
        color: appTheme.black900,
        fontSize: 14.fSize,
      );
  static get bodyMediumABeeZeeGray400 =>
      theme.textTheme.bodyMedium!.aBeeZee.copyWith(
        color: appTheme.gray400,
        fontSize: 14.fSize,
      );
  static get bodyMediumABeeZeeGray40014 =>
      theme.textTheme.bodyMedium!.aBeeZee.copyWith(
        color: appTheme.gray400,
        fontSize: 14.fSize,
      );
  static get bodyMediumABeeZeeGray80002 =>
      theme.textTheme.bodyMedium!.aBeeZee.copyWith(
        color: appTheme.gray80002,
        fontSize: 14.fSize,
      );
  static get bodyMediumPoppinsBlack900 =>
      theme.textTheme.bodyMedium!.poppins.copyWith(
        color: appTheme.black900,
        fontSize: 13.fSize,
      );
  static get bodyMediumPoppinsBlack90014 =>
      theme.textTheme.bodyMedium!.poppins.copyWith(
        color: appTheme.black900,
        fontSize: 14.fSize,
      );
  static get bodyMediumPoppinsGray700 =>
      theme.textTheme.bodyMedium!.poppins.copyWith(
        color: appTheme.gray700,
        fontSize: 13.fSize,
      );
  static get bodyMediumPoppinsGray70014 =>
      theme.textTheme.bodyMedium!.poppins.copyWith(
        color: appTheme.gray700,
        fontSize: 14.fSize,
      );
  static get bodyMediumPoppinsGray700_1 =>
      theme.textTheme.bodyMedium!.poppins.copyWith(
        color: appTheme.gray700,
      );
  static get bodySmallGray700 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.gray700,
      );
  // Headline text style
  static get headlineMediumBold => theme.textTheme.headlineMedium!.copyWith(
        fontWeight: FontWeight.w700,
      );
  static get headlineMediumGray80002 =>
      theme.textTheme.headlineMedium!.copyWith(
        color: appTheme.gray80002,
        fontWeight: FontWeight.w700,
      );
  static get headlineMediumWhiteA700 =>
      theme.textTheme.headlineMedium!.copyWith(
        color: appTheme.whiteA700,
      );
  static get headlineSmallGray80002 => theme.textTheme.headlineSmall!.copyWith(
        color: appTheme.gray80002,
        fontWeight: FontWeight.w700,
      );
  static get headlineSmallPoppinsGray80001 =>
      theme.textTheme.headlineSmall!.poppins.copyWith(
        color: appTheme.gray80001,
        fontWeight: FontWeight.w500,
      );
  // Title style
  static get titleLargeMontserrat => theme.textTheme.titleLarge!.montserrat;
  static get titleLargeMontserratGray80002 =>
      theme.textTheme.titleLarge!.montserrat.copyWith(
        color: appTheme.gray80002,
        fontSize: 23.fSize,
        fontWeight: FontWeight.w700,
      );
  static get titleLargeMontserratIndigoA700 =>
      theme.textTheme.titleLarge!.montserrat.copyWith(
        color: appTheme.indigoA700,
      );
  static get titleLargeMontserratWhiteA700 =>
      theme.textTheme.titleLarge!.montserrat.copyWith(
        color: appTheme.whiteA700,
        fontSize: 22.fSize,
      );
  static get titleLargeMontserratWhiteA700_1 =>
      theme.textTheme.titleLarge!.montserrat.copyWith(
        color: appTheme.whiteA700,
      );
  static get titleLargePoppinsGray70001 =>
      theme.textTheme.titleLarge!.poppins.copyWith(
        color: appTheme.gray70001,
        fontWeight: FontWeight.w500,
      );
  static get titleMediumBlack900 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.black900,
        fontSize: 18.fSize,
      );
  static get titleMediumBlack900_1 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.black900,
      );
  static get titleMediumGray600 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.gray600,
      );
  static get titleMediumGray60001 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.gray60001,
      );
  static get titleMediumMontserratBlack900 =>
      theme.textTheme.titleMedium!.montserrat.copyWith(
        color: appTheme.black900,
      );
  static get titleMediumMontserratGray80002 =>
      theme.textTheme.titleMedium!.montserrat.copyWith(
        color: appTheme.gray80002,
        fontWeight: FontWeight.w700,
      );
  static get titleMediumMontserratGray80002Bold =>
      theme.textTheme.titleMedium!.montserrat.copyWith(
        color: appTheme.gray80002,
        fontWeight: FontWeight.w700,
      );
  static get titleMediumMontserratIndigoA70001 =>
      theme.textTheme.titleMedium!.montserrat.copyWith(
        color: appTheme.indigoA70001,
        fontSize: 18.fSize,
        fontWeight: FontWeight.w700,
      );
  static get titleSmallGray500 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.gray500,
      );
  static get titleSmallInteBlack900 =>
      theme.textTheme.titleSmall!.inter.copyWith(
        color: appTheme.black900,
      );
  static get titleSmallMontserratBlack900 =>
      theme.textTheme.titleSmall!.montserrat.copyWith(
        color: appTheme.black900,
      );
}

extension on TextStyle {
  TextStyle get abyssinicaSIL {
    return copyWith(
      fontFamily: 'Abyssinica SIL',
    );
  }

  TextStyle get inter {
    return copyWith(
      fontFamily: 'Inter',
    );
  }

  TextStyle get montserrat {
    return copyWith(
      fontFamily: 'Montserrat',
    );
  }

  TextStyle get poppins {
    return copyWith(
      fontFamily: 'Poppins',
    );
  }

  TextStyle get aBeeZee {
    return copyWith(
      fontFamily: 'ABeeZee',
    );
  }
}
