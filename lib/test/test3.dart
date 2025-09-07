import 'package:flutter/material.dart';
import '../generated/l10n.dart';

import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:flutter_svg/flutter_svg.dart';

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Intl Demo',
      home: HomePage(),
    );
  }
}


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My App")),
      body: Center(
        // child: Column(
        //   // 重要：Column在滚动容器中应使用crossAxisAlignment而非默认的stretch
        //   children: [
        //     Text("test", style: TextStyle(fontSize: 24)),
        //     Divider(),
        //     // 基本用法
        //     Image.asset(
        //       'assets/images/logo.png',
        //       width: 200,
        //       height: 200,
        //       fit: BoxFit.contain, // 图片缩放方式
        //       errorBuilder: (context, error, stackTrace) {
        //         // 图片加载失败时显示的组件
        //         return const Icon(Icons.error);
        //       },
        //     ),
        //
        //     // 作为图标使用（小图片）
        //     Image.asset(
        //       'assets/images/icons/icon_add.png',
        //       width: 24,
        //       height: 24,
        //     ),
        //     Image.asset(
        //       'assets/images/logo.png',
        //       cacheWidth: 400,  // 缓存的宽度
        //       cacheHeight: 300, // 缓存的高度
        //     ),
        //     Image.network(
        //       'https://picsum.photos/200/300',
        //       width: 200,
        //       height: 300,
        //       loadingBuilder: (context, child, loadingProgress) {
        //         if (loadingProgress == null) return child;
        //         // 加载中显示进度指示器
        //         return CircularProgressIndicator(
        //           value: loadingProgress.expectedTotalBytes != null
        //               ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
        //               : null,
        //         );
        //       },
        //     ),
        //     LocalSvgExample()
        //   ],
        // ),
        child: LocalSvgExample(),

      ),
    );
  }
}


// 加载JSON资源
Future<Map<String, dynamic>> loadConfig() async {
  try {
    // 读取资源文件
    String jsonString = await rootBundle.loadString('assets/data/config.json');
    // 解析JSON
    return json.decode(jsonString);
  } catch (e) {
    print('加载配置失败: $e');
    return {};
  }
}

// 在Widget中使用
class ConfigWidget extends StatefulWidget {
  const ConfigWidget({super.key});

  @override
  _ConfigWidgetState createState() => _ConfigWidgetState();
}

class _ConfigWidgetState extends State<ConfigWidget> {
  late Future<Map<String, dynamic>> _configFuture;

  @override
  void initState() {
    super.initState();
    _configFuture = loadConfig();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _configFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            return Text('App名称: ${snapshot.data?['app_name'] ?? '未知'}');
          } else {
            return const Text('加载配置失败');
          }
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}


class LocalSvgExample extends StatelessWidget {
  const LocalSvgExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('本地SVG示例')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 基本用法
            SvgPicture.asset(
              'assets/images/autocomplete.svg',
              width: 200,
              height: 200,
              fit: BoxFit.contain, // 缩放方式
            ),

            const SizedBox(height: 20),

            // 带颜色过滤（修改SVG颜色）
            SvgPicture.asset(
              'assets/images/autocomplete.svg',
              width: 50,
              height: 50,
              colorFilter: const ColorFilter.mode(
                Colors.blue, // 要修改的颜色
                BlendMode.srcIn,
              ),
            ),

            const SizedBox(height: 20),

            // 加载失败时显示替代组件
            SvgPicture.asset(
              'assets/images/Banner.svg', // 不存在的文件
              width: 100,
              height: 100,
              placeholderBuilder: (context) => const CircularProgressIndicator(),
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.error, color: Colors.red, size: 100);
              },
            ),
          ],
        ),
      ),
    );
  }
}

