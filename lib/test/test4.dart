// 颜色常量
import 'dart:ui';

import 'package:flutter/material.dart';

class AppColors {
  // 主色调
  static const Color primary = Color(0xFF4285F4);
  static const Color primaryLight = Color(0xFF73A7FF);
  static const Color primaryDark = Color(0xFF0052CC);

  // 中性色
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color gray100 = Color(0xFFF5F5F5);
  static const Color gray200 = Color(0xFFEEEEEE);
  static const Color gray300 = Color(0xFFE0E0E0);

  // 功能色
  static const Color success = Color(0xFF0F9D58);
  static const Color error = Color(0xFFD93025);
  static const Color warning = Color(0xFFF4B400);
}

// 尺寸常量（单位：逻辑像素）
class AppSizes {
  // 字体大小
  static const double fontXXL = 24;
  static const double fontXL = 20;
  static const double fontL = 18;
  static const double fontM = 16;
  static const double fontS = 14;
  static const double fontXS = 12;

  // 边距/间距
  static const double paddingXXS = 4;
  static const double paddingXS = 8;
  static const double paddingS = 12;
  static const double paddingM = 16;
  static const double paddingL = 24;
  static const double paddingXL = 32;

  // 圆角
  static const double radiusS = 4;
  static const double radiusM = 8;
  static const double radiusL = 16;
  static const double radiusXL = 24;
}

// 文本样式常量（基础字体配置）
class AppTextStyles {
  // 字体家族
  static const String fontFamilySans = "Roboto";
  static const String fontFamilySerif = "Georgia";
  static const String fontFamilyChinese = "NotoSansSC";
}


// 文本样式集合
class AppTextThemes {
  // 标题样式
  static TextStyle title1 = TextStyle(
    fontSize: AppSizes.fontXXL,
    fontWeight: FontWeight.bold,
    color: AppColors.black,
    fontFamily: AppTextStyles.fontFamilySans,
  );

  static TextStyle title2 = TextStyle(
    fontSize: AppSizes.fontXL,
    fontWeight: FontWeight.w600,
    color: AppColors.black,
    fontFamily: AppTextStyles.fontFamilySans,
  );

  // 正文样式
  static TextStyle body1 = TextStyle(
    fontSize: AppSizes.fontM,
    color: AppColors.black,
    height: 1.5, // 行高
  );

  static TextStyle body2 = TextStyle(
    fontSize: AppSizes.fontS,
    color: AppColors.gray300,
    height: 1.4,
  );

  // 按钮文本样式
  static TextStyle button = TextStyle(
    fontSize: AppSizes.fontM,
    fontWeight: FontWeight.w500,
    color: AppColors.white,
  );
}

// 按钮样式集合
class AppButtonStyles {
  // 主按钮
  static ButtonStyle primary = ElevatedButton.styleFrom(
    backgroundColor: AppColors.primary,
    padding: EdgeInsets.symmetric(
      horizontal: AppSizes.paddingM,
      vertical: AppSizes.paddingS,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSizes.radiusM),
    ),
    textStyle: AppTextThemes.button,
  );

  // 次要按钮
  static ButtonStyle secondary = ElevatedButton.styleFrom(
    backgroundColor: AppColors.gray100,
    foregroundColor: AppColors.black,
    padding: EdgeInsets.symmetric(
      horizontal: AppSizes.paddingM,
      vertical: AppSizes.paddingS,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSizes.radiusM),
      side: BorderSide(color: AppColors.gray300),
    ),
  );
}

// 卡片样式
class AppCardStyles {
  static CardThemeData defaultCard = CardThemeData(
    elevation: 2,
    margin: EdgeInsets.all(AppSizes.paddingS),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSizes.radiusM),
    ),
    color: AppColors.white,
  );
}

class AppTheme {
  // 亮色主题
  static ThemeData light() {
    return ThemeData(
      // 基础配置
      brightness: Brightness.light,
      primaryColor: AppColors.primary,
      fontFamily: AppTextStyles.fontFamilySans,

      // 文本主题（整合预设文本样式）
      textTheme: TextTheme(
        headlineLarge: AppTextThemes.title1,
        headlineMedium: AppTextThemes.title2,
        bodyLarge: AppTextThemes.body1,
        bodyMedium: AppTextThemes.body2,
        labelLarge: AppTextThemes.button,
      ),

      // 按钮主题
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: AppButtonStyles.primary,
      ),

      // 卡片主题
      cardTheme: AppCardStyles.defaultCard,

      // 输入框主题
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusM),
          borderSide: BorderSide(color: AppColors.gray300),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppSizes.paddingS,
          vertical: AppSizes.paddingXS,
        ),
        hintStyle: TextStyle(
          color: AppColors.gray300,
          fontSize: AppSizes.fontS,
        ),
      ),

      // 全局边距（可选：通过 extensions 扩展自定义属性）
      extensions: [
        AppSpacingTheme(
          paddingSmall: AppSizes.paddingS,
          paddingMedium: AppSizes.paddingM,
          paddingLarge: AppSizes.paddingL,
        ),
      ],
    );
  }

  // 暗色主题（复用亮色主题的结构，仅修改颜色）
  static ThemeData dark() {
    final lightTheme = light();
    return lightTheme.copyWith(
      brightness: Brightness.dark,
      primaryColor: AppColors.primaryLight,
      textTheme: lightTheme.textTheme.apply(
        bodyColor: AppColors.white,
        displayColor: AppColors.white,
      ),
      cardTheme: lightTheme.cardTheme.copyWith(
        color: AppColors.gray300,
      ),
    );
  }
}

// 自定义主题扩展（存储额外的样式资源，如全局边距）
class AppSpacingTheme extends ThemeExtension<AppSpacingTheme> {
  final double paddingSmall;
  final double paddingMedium;
  final double paddingLarge;

  AppSpacingTheme({
    required this.paddingSmall,
    required this.paddingMedium,
    required this.paddingLarge,
  });

  @override
  AppSpacingTheme copyWith({
    double? paddingSmall,
    double? paddingMedium,
    double? paddingLarge,
  }) {
    return AppSpacingTheme(
      paddingSmall: paddingSmall ?? this.paddingSmall,
      paddingMedium: paddingMedium ?? this.paddingMedium,
      paddingLarge: paddingLarge ?? this.paddingLarge,
    );
  }

  @override
  AppSpacingTheme lerp(AppSpacingTheme? other, double t) {
    if (other == null) return this;
    return AppSpacingTheme(
      paddingSmall: lerpDouble(paddingSmall, other.paddingSmall, t)!,
      paddingMedium: lerpDouble(paddingMedium, other.paddingMedium, t)!,
      paddingLarge: lerpDouble(paddingLarge, other.paddingLarge, t)!,
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 获取主题扩展（自定义边距）
    final spacing = Theme.of(context).extension<AppSpacingTheme>()!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "主题示例",
          style: Theme.of(context).textTheme.headlineMedium, // 使用标题样式
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(spacing.paddingMedium), // 使用自定义边距
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 使用正文样式
            Text(
              "这是一段正文文本",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            SizedBox(height: spacing.paddingSmall),

            // 使用次要文本样式
            Text(
              "这是一段辅助文本",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(height: spacing.paddingMedium),

            // 使用主按钮样式
            ElevatedButton(
              onPressed: () {},
              child: Text("主按钮"),
            ),
            SizedBox(height: spacing.paddingSmall),

            // 使用次要按钮样式
            ElevatedButton(
              style: AppButtonStyles.secondary, // 直接使用预设按钮样式
              onPressed: () {},
              child: Text("次要按钮"),
            ),
          ],
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      title: 'Flutter Intl Demo',
      home: HomePage(),
    );
  }
}