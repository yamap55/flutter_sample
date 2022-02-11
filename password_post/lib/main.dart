import 'package:flutter/material.dart';
import 'package:password_post/footer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Password Post',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'パスワードポスト'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(children: [
        for (var i = 1; 1 <= 10; i++)
          ((i) => Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.vpn_key),
                    title: Text('data$i'),
                  ),
                  const Divider(thickness: 1.5)
                ],
              ))(i)
      ]),
      bottomNavigationBar: const Footer(),
    );
  }
}

// TODO: リストの表示を動的に
// TODO: フロートアクションボタンをタップ時に、リストを1つ追加表示
// TODO: 新しい画面を追加し、リストをタップした時に遷移
// TODO: 新しい画面のレイアウト作成
// TODO: 新しい画面にリストからデータを引き継ぐ
