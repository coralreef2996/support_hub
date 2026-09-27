import 'package:flutter/material.dart';
import 'dart:math';
import 'login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFC2185B)),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          foregroundColor: Color(0xFF1A1A1A),
          elevation: 0,
          toolbarHeight: 56.0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: Color(0xFF1A1A1A),
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            elevation: 2,
          ),
        ),
      ),
      home: const LoginScreen(
        appName: '案内ひろば',
        originalHome: SupportHubOriginalHome(),
      ),
    );
  }
}

// ==========================================
// 画面共通ヘッダー（設定・使い方）
// ==========================================
Widget buildSupportHubUserHeader(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(top: 12.0, left: 16.0, right: 16.0, bottom: 12.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        OutlinedButton.icon(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: const Color(0xFFAB0000),
            side: BorderSide(color: const Color(0xFFAB0000).withValues(alpha: 0.5)),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          ),
          icon: const Icon(Icons.settings, size: 18),
          label: const Text('設定'),
        ),
        PopupMenuButton<String>(
          color: Colors.white,
          surfaceTintColor: Colors.white,
          onSelected: (String value) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: const Color(0xFFAB0000),
                content: Text('$value が選択されました', style: const TextStyle(color: Colors.white)),
                duration: const Duration(seconds: 2),
              ),
            );
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            const PopupMenuItem<String>(
              value: '使い方１',
              child: Text('使い方１', style: TextStyle(color: Color(0xFFAB0000))),
            ),
            const PopupMenuItem<String>(
              value: '使い方２',
              child: Text('使い方２', style: TextStyle(color: Color(0xFFAB0000))),
            ),
            const PopupMenuItem<String>(
              value: '使い方３',
              child: Text('使い方３', style: TextStyle(color: Color(0xFFAB0000))),
            ),
          ],
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(color: const Color(0xFFAB0000).withValues(alpha: 0.5)),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.help_outline, size: 18, color: Color(0xFFAB0000)),
                SizedBox(width: 6),
                Text('使い方', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFFAB0000))),
                SizedBox(width: 4),
                Icon(Icons.arrow_drop_down, size: 18, color: Color(0xFFAB0000)),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

class SupportHubOriginalHome extends StatelessWidget {
  const SupportHubOriginalHome({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginScreen(
                appName: '案内ひろば',
                originalHome: SupportHubOriginalHome(),
              ),
            ),
          );
        }
      },
      child: Scaffold(
      appBar: AppBar(
        title: const Text(
          '案内ひろば',
          style: TextStyle(
            color: Color(0xFF1A1A1A),
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        toolbarHeight: 56.0,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        foregroundColor: const Color(0xFF1A1A1A),
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFffffff),
              Color(0xFFF4B9C0),
            ],
          ),
        ),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              buildSupportHubUserHeader(context),
              const HoneycombMenu(),
            ],
          ),
        ),
      ),
    ),
  );
}
}

class HexagonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final double radius = size.width / 2;
    final Offset center = Offset(size.width / 2, size.height / 2);

    for (int i = 0; i < 6; i++) {
      double angle = pi / 6 + (pi / 3) * i;
      double x = center.dx + radius * cos(angle);
      double y = center.dy + radius * sin(angle);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class HexagonButton extends StatelessWidget {
  final double size;
  final Color color;
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const HexagonButton({
    super.key,
    required this.size,
    required this.color,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final double hexagonWidth = size;
    final double hexagonHeight = size * (2 / sqrt(3));

    return SizedBox(
      width: hexagonWidth,
      height: hexagonHeight,
      child: ClipPath(
        clipper: HexagonClipper(),
        child: Material(
          color: color,
          child: InkWell(
            onTap: onTap,
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: size * 0.1),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(icon, size: size * 0.3, color: Color(0xFF060660)),
                    const SizedBox(height: 4),
                    Text(
                      label,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF060660),
                        fontSize: size * 0.12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HoneycombMenu extends StatelessWidget {
  const HoneycombMenu({super.key});

  final double HEX_SIZE = 90.0;
  final double SPACING = 3.0;
  static final double HEX_FACTOR = 2 / sqrt(3);
  double get hexHeight => HEX_SIZE * HEX_FACTOR;

  // 六角形の中心間距離（辺に沿う配置）
  double get r => HEX_SIZE + SPACING;

  Widget _buildHexagon(
    String label,
    IconData icon,
    Color color,
    double dx,
    double dy,
  ) {
    return Positioned(
      left: dx,
      top: dy,
      child: HexagonButton(
        size: HEX_SIZE,
        color: color,
        icon: icon,
        label: label,
        onTap: () {
          debugPrint('$label tapped!');
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double totalWidth = HEX_SIZE * 4.0;
    final double totalHeight = hexHeight * 4.0;
    final double centerX = totalWidth / 2 - HEX_SIZE / 2;
    final double centerY = totalHeight / 2 - hexHeight / 2;

    // 60度回転した頂点座標（時計回り）
    List<Offset> offsets = [
      Offset(centerX + r * cos(pi / 3), centerY + r * sin(pi / 3)), // menu1
      Offset(centerX + r * cos(0), centerY + r * sin(0)), // menu2
      Offset(centerX + r * cos(-pi / 3), centerY + r * sin(-pi / 3)), // menu3
      Offset(
        centerX + r * cos(-2 * pi / 3),
        centerY + r * sin(-2 * pi / 3),
      ), // menu4
      Offset(centerX + r * cos(-pi), centerY + r * sin(-pi)), // menu5
      Offset(
        centerX + r * cos(-4 * pi / 3),
        centerY + r * sin(-4 * pi / 3),
      ), // menu6
    ];

    // 段組み配置
    List<Widget> hexagons = [
      // 1段目
      _buildHexagon(
        '勤怠管理',
        Icons.work,
        Color(0xFFFFBF7F),
        offsets[3].dx,
        offsets[3].dy,
      ),
      _buildHexagon(
        '体調記録',
        Icons.favorite,
        Color(0xFFBFFF7F),
        offsets[2].dx,
        offsets[2].dy,
      ),

      // 2段目
      _buildHexagon(
        '簡易連絡',
        Icons.chat_bubble,
        Color(0xFFFF7FBF),
        offsets[4].dx,
        offsets[4].dy,
      ),
      _buildHexagon(
        '作業手順',
        Icons.assignment,
        Color(0xFF7878D1),
        centerX,
        centerY,
      ),
      _buildHexagon(
        '服薬管理',
        Icons.medical_services,
        Color(0xFF7FFFBF),
        offsets[1].dx,
        offsets[1].dy,
      ),

      // 3段目
      _buildHexagon(
        '適性診断',
        Icons.person_search,
        Color(0xFFBF7FFF),
        offsets[5].dx,
        offsets[5].dy,
      ),
      _buildHexagon(
        '日報作成',
        Icons.mode_edit,
        Color(0xFF7FBFFF),
        offsets[0].dx,
        offsets[0].dy,
      ),
    ];

    return Center(
      child: SizedBox(
        width: totalWidth,
        height: totalHeight,
        child: Stack(children: hexagons),
      ),
    );
  }
}
