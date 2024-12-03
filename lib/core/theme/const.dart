import 'package:flutter/material.dart';
import 'package:invia_case_study/core/theme/colours.dart';
import 'package:invia_case_study/core/theme/fonts.dart';

class ObjectTypeConst {
  static const String bannerVideo = 'bannerVideo';
  static const String banner = 'banner';
  static const String categoryCarousel = 'categoryCarousel';
  static const String wishlistCarousel = 'wishListCarousel';
}

class Consts {
  // padding
  static const double globalContentPaddingS = 6;
  static const double globalContentPaddingM = 12;
  static const double globalContentPaddingL = 24;
  static const double globalWidgetpaddingS = 6;
  static const double globalWidgetpaddingM = 8;
  static const double globalWidgetpaddingL = 12;
  static const double globalWidgetpaddingXL = 16;
  static const double materialBubblePadding = 3;

  // global BoxShadow
  static final globalBoxShadow = BoxShadow(
    spreadRadius: 1,
    blurRadius: 2,
    color: Colours.grey_300,
    offset: const Offset(0, 1),
  );
  static final bottomBtnBoxShadow = BoxShadow(
    color: Colours.grey_200,
    blurRadius: 10,
    offset: const Offset(0, -5),
  );
  static final bottomNavBoxShadow = [
    BoxShadow(
      color: Colors.black.withOpacity(0.1),
      blurRadius: 4,
      offset: const Offset(0, 4), // bottom shadow
    ),
    BoxShadow(
      color: Colors.black.withOpacity(0.1),
      blurRadius: 4,
      offset: const Offset(0, -4), // top shadow
    ),
  ];

// radius
  static const double radius = 6;
  static const double tabItemRadius = 13;
  static const double orderOverviewRadius = 8;

// elevation
  static const double elevation = 4;
  static const double bottomNavBarElevation = 20;

  // border width
  static const double borderTiny = 0.6;
  static const double borderThin = 1;
  static const double borderMedium = 1.5;
  static const double borderThick = 2;
  static const double borderXThick = 4;

  // button height
  static double btnHeight = 42;
  static double btnHeightL = 50;

  // primary and secondary buttons
  static double primaryBtnWidthS = 185;
  static double primaryBtnWidthM = 250;
  static double devSettingsBtn = 80;

  // ring size buttons
  static Color ringSizeBtnEnabledBg = Colours.white_0;
  static Color ringSizeBtnDisabledBg = Colours.grey_100;
  static Color ringSizeBtnOutlineEnabled = Colours.grey_300;
  static Color ringSizeBtnOutlineDisabled = Colours.grey_200;
  static Color ringSizeBtnOutlineSelected = Colours.grey_700;

  static TextStyle ringSizeBtnTextStyle = TextStyle(
    color: Colours.grey_700,
    fontSize: FontSize.small,
    fontWeight: FontWeights.medium,
  );

  // overlay
  static Color overlayColor =
      createMaterialColor(Colours.grey_700).withOpacity(0.2);

  //ringsizer
  static double ringsizerCoinRadiusInPx1 = 34;
  static double ringsizerCoinRadiusInPx2 = 38;
  static double ringsizerCoinRadiusInPx50 = 35;
  static double ringsizerCoinRadiusInPx20 = 30;
  static double ringsizerCoinRadiusMin = 50;
  static double ringsizerCoinRadiusMax = 250;
  static double ringsizerRingsizeContainerHeight = 200;
  static double ringsizerRingMinDiameterPx = 25;
  static double ringsizerRingMaxDiameterPx = 250;
  static double ringsizerMinCircumferencePx = 0;
  static double ringsizerMaxCircumferencePx = 500;

  // metal variant
  static double metalVariantHeight = 40;
  static double metalVariantHeightS = 38;

  // basic Textbutton Style
  static final btnTextStyle = WidgetStateProperty.all(
    const TextStyle(
      fontWeight: FontWeights.light,
      fontSize: FontSize.medium,
    ),
  );

  // warning label
  static const double warningLabelHeight = 15;

  // icon text buttons
  static double iconBtnWith = primaryBtnWidthS / 3;
  static TextStyle iconBtnTextStyleLight = TextStyle(
    fontSize: FontSize.small,
    fontWeight: FontWeights.light,
    color: Colours.magenta,
  );
  static TextStyle iconBtnTextStyleBold = TextStyle(
    fontSize: FontSize.small,
    fontWeight: FontWeights.bold,
    color: Colours.magenta,
  );

  // bottom bar
  static double navIconWidth = 24;

  // SVG Icons colors can not be controlled directly from the theme.
  // Var to control icon and label colors at selected / not selected globally.
  static Color bottomNavItemSelected = Colours.magenta;
  static Color bottomNavItemNotSelected = Colours.grey_500;
  static Color iconColor = Colours.magenta;

  // global icons
  static double globalIconSizeL = 20;
  static double globalIconSizeM = 18;
  static double globalIconSizeS = 12;
  static double globalIconSizeXS = 10;

  // Dialogs
  static double dialogPaddingLarge = 18;
  static double dialogPaddingSmall = 10;
  static double dialogBtnPadding = 5;
  static double dialogBtnHeight = 52;
  static double dialogInsetPaddingH = 20;
  static double dialogInsetPaddingV = 60;
  static double dialogImageHeight = 120;
  static TextStyle dialogTitleTextStyle = TextStyle(
    fontSize: FontSize.large,
    fontWeight: FontWeights.bold,
    color: Colours.grey_700,
  );
  static double fontSizeSmall = FontSize.small;
  static TextStyle dialogContentTextStyle =
      TextStyle(fontSize: FontSize.medium, color: Colours.grey_700);
  static TextStyle dialogBtnPrimaryColorTextStyle =
      TextStyle(fontSize: FontSize.medium, color: Colours.magenta);
  static TextStyle dialogBtnGreyColorTextStyle =
      TextStyle(fontSize: FontSize.medium, color: Colours.grey_700);
  static BoxDecoration dialogBtnBorder = BoxDecoration(
    border: Border(
      top: BorderSide(color: Colours.grey_300),
    ),
  );

  // Spinner
  static Color spinnerColor = Colours.magenta;
  static double spinnerStrokeW = 3;
  static double spinnerHeightS = 42;
  static double spinnerHeightM = 132;

  // Check Box
  static double checkboxHeight = 25;
  static double checkboxTextPadding = 2;

  // Tag
  static double tagHeight = 24;
  static double tagLabelPadding = 4;

  // Taops
  static double tapLength = 60;
  static double tapPaddingBottom = 10;

  static double tabIndicatorWeight = 3;

  // Video Player
  static double videoAspectRatio = 1.067;
  static double videoContainerBottomMargin = 30;

  // Video Play Control
  static double playControlHeight = 55;
  static double playControlHeightWithoutProgressBar = 35;
  static double playControlHorizentalPadding = 70;
  static double playControlBottomPadding = 2;
  static double playControlDurationLabelHorientalPading = 5;
  static int playControlPresentingAnimationDuration = 500;
  static int playControlDisappearDuration = 5000;

  // Conntainer
  static Color containerLight = Colours.white_0;
  static Color containerSemiLight = Colours.alphaWhite_150;
  static Color containerDark = Colours.black_0;
  static double listItemHeight = 164;
  static double listItemImageSize = 120;
  static double similarProductsContainerHeight = 128;
  static double similarProductsImageSize = 52;

  // Product Grid
  static double productGridItemHeight = 430;
  static double productGridBrandHeight = 40;
  static double productGridIProductNameHeight = 40;
  static double productGridVariantHeight = 16;

  //Slider
  static double globalSliderTrackLimiterHeightS = 22;
  // static double globalSliderTrackLimiterHeightL = 98.0;
  static double globalSliderTrackStrokeSizeS = 2;
  static double globalSliderTrackStrokeSizeL = 16;
}
