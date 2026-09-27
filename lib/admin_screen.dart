import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'main.dart';

// ==========================================
// 管理者用画面 (Support Hub)
// ==========================================

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  static const Color iconColor = Color(0xFFAB0000);
  static const Color gradientBaseColor = Color(0xFFF4B9C0);

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
      child: DefaultTabController(
        length: 4,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.white, gradientBaseColor],
            ),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.white.withOpacity(0.9),
              elevation: 0,
              centerTitle: true,
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: AdminHomeScreen.iconColor),
                tooltip: '戻る',
                onPressed: () => Navigator.maybePop(context),
              ),
              title: Text(
                '総合案内',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AdminHomeScreen.iconColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                ),
              ),
              bottom: TabBar(
                labelColor: AdminHomeScreen.iconColor,
                unselectedLabelColor: Colors.black54,
                indicatorColor: AdminHomeScreen.iconColor,
              labelStyle: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                height: 1.1,
              ),
              unselectedLabelStyle: TextStyle(
                fontSize: 11,
                height: 1.1,
              ),
              tabs: [
                Tab(
                  icon: Icon(Icons.people_alt_outlined),
                  child: Text(
                    '個人データ\n一覧',
                    textAlign: TextAlign.center,
                  ),
                ),
                Tab(
                  icon: Icon(Icons.analytics_outlined),
                  child: Text(
                    '分析\n職員用メモ',
                    textAlign: TextAlign.center,
                  ),
                ),
                Tab(
                  icon: Icon(Icons.app_settings_alt_outlined),
                  child: Text(
                    '機能編集\n管理',
                    textAlign: TextAlign.center,
                  ),
                ),
                Tab(
                  icon: Icon(Icons.import_export_outlined),
                  child: Text(
                    '外部出力\n連携',
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              _PersonalDataTab(iconColor: iconColor),
              _AnalysisTab(iconColor: iconColor),
              _AppEditTab(iconColor: iconColor),
              _ExportTab(iconColor: iconColor),
            ],
          ),
        ),
      ),
    ),
  );
}
}

class _AdminSubHeader extends StatelessWidget {
  final Color iconColor;
  const _AdminSubHeader({required this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 左上：「設定」ボタン（タップしても動作しない）
          OutlinedButton.icon(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: iconColor,
              side: BorderSide(color: iconColor.withOpacity(0.5)),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 8,
              ),
            ),
            icon: const Icon(Icons.settings, size: 18),
            label: const Text('設定'),
          ),

          // 右上：「使い方」プルダウンメニューボタン
          PopupMenuButton<String>(
            color: Colors.white,
            surfaceTintColor: Colors.white,
            onSelected: (String value) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: iconColor,
                  content: Text(
                    '$value が選択されました',
                    style: const TextStyle(color: Colors.white),
                  ),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                value: '使い方１',
                child: Text('使い方１', style: TextStyle(color: iconColor)),
              ),
              PopupMenuItem<String>(
                value: '使い方２',
                child: Text('使い方２', style: TextStyle(color: iconColor)),
              ),
              PopupMenuItem<String>(
                value: '使い方３',
                child: Text('使い方３', style: TextStyle(color: iconColor)),
              ),
            ],
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(color: iconColor.withOpacity(0.5)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.help_outline,
                    size: 18,
                    color: iconColor,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    '使い方',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: iconColor,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    Icons.arrow_drop_down,
                    size: 18,
                    color: iconColor,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PersonalDataTab extends StatelessWidget {
  final Color iconColor;
  const _PersonalDataTab({required this.iconColor});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _AdminSubHeader(iconColor: iconColor),
        Card(
          color: Colors.white.withOpacity(0.9),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: iconColor.withOpacity(0.2)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(Icons.people_alt_outlined, size: 40, color: iconColor),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '個人データ一覧',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: iconColor,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        '登録されている利用者の個人データ管理を行います。',
                        style: TextStyle(fontSize: 12, color: Colors.black87),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _AnalysisTab extends StatelessWidget {
  final Color iconColor;
  const _AnalysisTab({required this.iconColor});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _AdminSubHeader(iconColor: iconColor),
        Card(
          color: Colors.white.withOpacity(0.9),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: iconColor.withOpacity(0.2)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(Icons.analytics_outlined, size: 40, color: iconColor),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '分析 / 職員用メモ',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: iconColor,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'データ分析結果および職員間のメモを共有・管理します。',
                        style: TextStyle(fontSize: 12, color: Colors.black87),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _AppEditTab extends StatelessWidget {
  final Color iconColor;
  const _AppEditTab({required this.iconColor});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _AdminSubHeader(iconColor: iconColor),
        Card(
          color: Colors.white.withOpacity(0.9),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: iconColor.withOpacity(0.2)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(Icons.app_settings_alt_outlined, size: 40, color: iconColor),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '機能編集 / 管理',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: iconColor,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'アプリの設定変更や画面構成のカスタマイズを行います。',
                        style: TextStyle(fontSize: 12, color: Colors.black87),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ExportTab extends StatelessWidget {
  final Color iconColor;
  const _ExportTab({required this.iconColor});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _AdminSubHeader(iconColor: iconColor),
        Card(
          color: Colors.white.withOpacity(0.9),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: iconColor.withOpacity(0.2)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(Icons.import_export_outlined, size: 40, color: iconColor),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '外部出力 / 連携',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: iconColor,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'データの外部出力（CSV等）および外部システム連携を行います。',
                        style: TextStyle(fontSize: 12, color: Colors.black87),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
