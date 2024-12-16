import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

final player = AudioPlayer()..setReleaseMode(ReleaseMode.loop);

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '我的自傳',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        textTheme: TextTheme(
          bodyText1: TextStyle(fontSize: 16, color: Colors.black87),
          headline6: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final tabs = [
    Screen1(),
    Screen2(),
    Screen3(),
    Screen4(),
  ];

  int previousIndex = 0;
  int currentIndex = 0;

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '我的自傳',
          style: Theme.of(context).textTheme.headline6,
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: tabs[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.teal,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        selectedFontSize: 16,
        unselectedFontSize: 14,
        iconSize: 28,
        currentIndex: currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: currentIndex == 0 ? 32 : 28),
            label: '自我介紹',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: '學習歷程',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.lightbulb),
            label: '學習計畫',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.engineering),
            label: '專業方向',
          ),
        ],
        onTap: (index) {
          setState(() {
            previousIndex = currentIndex;
            currentIndex = index;
            if (previousIndex != currentIndex || player.state != PlayerState.playing) {
              player.stop();
              player.play(AssetSource("audio_${index + 1}.mp3"));
            }
          });
        },
      ),
    );
  }
}

class Screen1 extends StatelessWidget {
  final String bio =
      '我出生在一個溫馨的小家庭。由於父母工作繁忙，我的童年多半由奶奶照顧。在小學時期，我養成了閱讀哲學、歷史和文化相關書籍的習慣，這讓我在學業上表現優異，成績始終名列前茅。'
      '進入高中後，我發現自己對程式設計和遊戲開發有著濃厚的興趣。在老師的指導下，我學會了更多技術，並設定了更高的學術目標。雖然在大學期間面臨心理健康挑戰，但這些經歷使我成長，增強了與他人互動的同理心。';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('自我介紹', style: Theme.of(context).textTheme.headline6),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black54, width: 2),
              borderRadius: BorderRadius.circular(8),
              boxShadow: const [
                BoxShadow(color: Colors.black26, offset: Offset(4, 4), blurRadius: 4),
              ],
            ),
            child: Text(bio, style: Theme.of(context).textTheme.bodyText1),
          ),
          const SizedBox(height: 20),
          Center(
            child: CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/f1.jpg'),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildImageBox('assets/f2.jpg'),
              _buildImageBox('assets/f3.jpg'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildImageBox(String imagePath) {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.teal, width: 2),
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class Screen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '學習歷程內容即將推出',
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }
}

class Screen3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('學習計畫', style: Theme.of(context).textTheme.headline6),
          const SizedBox(height: 10),
          ListView(
            shrinkWrap: true,
            children: [
              ListTile(
                leading: Icon(Icons.check_circle_outline),
                title: Text('學好英文'),
              ),
              ListTile(
                leading: Icon(Icons.check_circle_outline),
                title: Text('學習多種程式語言'),
              ),
              ListTile(
                leading: Icon(Icons.check_circle_outline),
                title: Text('取得專業證照'),
              ),
              ListTile(
                leading: Icon(Icons.check_circle_outline),
                title: Text('培養多元技能'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Screen4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '專業方向內容即將推出',
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }
}
