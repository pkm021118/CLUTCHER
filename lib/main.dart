import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk_auth/kakao_flutter_sdk_auth.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  KakaoSdk.init(nativeAppKey: 'ded1e76461debd51174e75a1cf0f40d7');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CLUTCHER',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoadingScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    });

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/loading_background.png'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/login_background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 500), // 버튼 위에 50 픽셀의 여백 추가
            GestureDetector(
              onTap: () async {
                try {
                  if (await isKakaoTalkInstalled()) {
                    await UserApi.instance.loginWithKakaoTalk();
                    print('카카오톡으로 로그인 성공');
                  } else {
                    await UserApi.instance.loginWithKakaoAccount();
                    print('카카오계정으로 로그인 성공');
                  }
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                } catch (error) {
                  print('카카오 로그인 실패: $error');
                }
              },
              child: Image.asset(
                'assets/login_button_icon.png',
                width: 400,
                height: 50,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0; // _selectedIndex를 초기화합니다.

  final List<Widget> _widgetOptions = <Widget>[
    InkWell(
      onTap: () {
        // 홈 버튼을 눌렀을 때 수행할 동작
        print('홈 버튼이 눌렸습니다.');
      },
      child: Image.asset('assets/Home_index_image.png'), // Index 0: 홈에 해당하는 이미지 추가
    ),
    Text('Index 1: 채팅'),
    Text('Index 2: 스타일'), // 기존의 "스타일" 인덱스 복구
    Text('Index 3: 저장됨'),
    Text('Index 4: 내 정보'),
    Text('Index 5: 커스텀'), // 새로운 "커스텀" 인덱스 추가
    Text('Index 6: 중고거래'), // 새로운 "중고거래" 인덱스 추가
    Text('Index 7: 광고'), // 새로운 "광고" 인덱스 추가
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onCustomButtonTapped() {
    // 새로운 "커스텀" 인덱스를 선택할 때 수행할 동작
    print('커스텀 버튼이 눌렸습니다.');
  }

  void _onSecondButtonTapped() {
    // 새로운 "중고거래" 인덱스를 선택할 때 수행할 동작
    print('중고거래 버튼이 눌렸습니다.');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: AppBar(
          title: Row(
            children: [
              if (_selectedIndex == 0) // 홈 화면일 때만 이미지 추가
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Image.asset(
                    'assets/CLUTCHER.png',
                    width: 140,
                    height: 120,
                  ),
                ),
            ],
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _widgetOptions.elementAt(_selectedIndex),
            if (_selectedIndex == 0) // 홈 화면일 때만 버튼 추가
              SizedBox(height: 5), // 추가된 버튼 사이의 간격 조정
            if (_selectedIndex == 0) // 홈 화면일 때만 버튼 추가
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: _onCustomButtonTapped, // 첫 번째 추가 버튼이 눌렸을 때 수행할 동작
                        child: Image.asset('assets/custom.png', width: 180, height: 100), // 첫 번째 버튼 이미지 추가 및 크기 조절
                      ),
                      SizedBox(width: 5), // 버튼 사이의 간격 조정
                      GestureDetector(
                        onTap: _onSecondButtonTapped, // 두 번째 추가 버튼이 눌렸을 때 수행할 동작
                        child: Image.asset('assets/carrot.png', width: 180, height: 100), // 두 번째 버튼 이미지 추가 및 크기 조절
                      ),
                    ],
                  ),
                  SizedBox(height: 10), // 버튼 사이의 간격 조정
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // 세 번째 추가 버튼이 눌렸을 때 수행할 동작
                          print('세 번째 추가 버튼이 눌렸습니다.');
                        },
                        child: Image.asset('assets/photo1.png', width: 190, height: 200), // 세 번째 버튼 이미지 추가 및 크기 조절
                      ),
                      SizedBox(width: 0), // 버튼 사이의 간격 조정
                      GestureDetector(
                        onTap: () {
                          // 네 번째 추가 버튼이 눌렸을 때 수행할 동작
                          print('네 번째 추가 버튼이 눌렸습니다.');
                        },
                        child: Image.asset('assets/photo2.png', width: 190, height: 200), // 네 번째 버튼 이미지 추가 및 크기 조절
                      ),
                    ],
                  ),
                ],
              ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image.asset('assets/Home_icon.png'),
            activeIcon: Image.asset('assets/Home_icon_active.png'),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/Chat_icon.png'),
            activeIcon: Image.asset('assets/Chat_icon_active.png'),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/Style_icon.png'),
            activeIcon: Image.asset('assets/Style_icon_active.png'),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/Saved_icon.png'),
            activeIcon: Image.asset('assets/Saved_icon_active.png'),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/My_icon.png'),
            activeIcon: Image.asset('assets/My_icon_active.png'),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
        selectedFontSize: 14,
        unselectedFontSize: 14,
      ),
    );
  }
}
