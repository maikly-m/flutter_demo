import 'package:demo01/test/test1.dart';
import 'package:flutter/material.dart';

import '../generated/l10n.dart';

class LanguageSwitcher extends StatefulWidget {
  const LanguageSwitcher({super.key});

  @override
  State<LanguageSwitcher> createState() => _LanguageSwitcherState();
}

class _LanguageSwitcherState extends State<LanguageSwitcher> {
  // 当前选中的语言
  String? _currentLanguage;

  @override
  void initState() {
    super.initState();

  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 初始化当前语言
    _currentLanguage = Localizations.localeOf(context).languageCode;
  }

  // 切换语言并重建应用
  void _changeLanguage(String languageCode) {
    setState(() {
      _currentLanguage = languageCode;
    });

    // 重新加载应用以应用新语言
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => MyApp(
          locale: Locale(languageCode),
        ),
      ),
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).helloWorld),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('English'),
            trailing: _currentLanguage == 'en' ? const Icon(Icons.check) : null,
            onTap: () => _changeLanguage('en'),
          ),
          ListTile(
            title: const Text('中文'),
            trailing: _currentLanguage == 'zh' ? const Icon(Icons.check) : null,
            onTap: () => _changeLanguage('zh'),
          ),
          ListTile(
            title: const Text('Español'),
            trailing: _currentLanguage == 'es' ? const Icon(Icons.check) : null,
            onTap: () => _changeLanguage('es'),
          ),
        ],
      ),
    );
  }
}

