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
    return const MaterialApp(
      title: '案内ひろば',
      debugShowCheckedModeBanner: false,
      home: LoginScreen(
        appName: 'Support Hub',
        originalHome: SupportHubOriginalHome(),
      ),
    );
  }
}

class SupportHubOriginalHome extends StatelessWidget {
  const SupportHubOriginalHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '案内ひろば',
          style: TextStyle(
            color: Color(0xFF060660),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        // 💡 全体をContainerでラップ
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter, // 上から
            end: Alignment.bottomCenter, // 下へ
            colors: [
              Color(0xFFffffff), // 白 (上)
              Color(0xFFF4B9C0), // 赤 (下)
            ],
          ),
        ),
        child: HoneycombMenu(),
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
        '体力表示',
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
        '日誌作成',
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
