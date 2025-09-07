import 'package:demo01/test/test2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../generated/l10n.dart';

class MyApp extends StatelessWidget {
  // 添加Locale参数，可选，默认为null（使用系统语言）
  final Locale? locale;

  // 构造函数，接收locale参数
  const MyApp({super.key, this.locale});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Intl Demo',
      // 应用指定的语言（如果有）
      locale: locale,
      // 配置本地化代理
      localizationsDelegates: [
        S.delegate, // Flutter Intl生成的代理
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      // 支持的语言列表（由Flutter Intl自动生成）
      supportedLocales: S.delegate.supportedLocales,
      // 语言解析回调（当指定的locale不被支持时使用）
      localeResolutionCallback: (deviceLocale, supportedLocales) {
        // 如果指定了locale且被支持，则使用它
        if (locale != null && supportedLocales.contains(locale)) {
          return locale;
        }
        // 否则使用设备语言或默认语言
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == deviceLocale?.languageCode) {
            return supportedLocale;
          }
        }
        // 最终 fallback 到第一个支持的语言
        return supportedLocales.first;
      },
      home: HomePage(),
    );
  }
}


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).welcome("My App"))),
      body: Center(
        child: Column(
          children: [
            Text(S.of(context).helloWorld, style: TextStyle(fontSize: 24)),
            ElevatedButton(child: Text("change language"), onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => LanguageSwitcher()));
            }),
          ],
        ),
      ),
    );
  }
}
