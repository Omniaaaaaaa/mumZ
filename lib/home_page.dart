import 'package:flutter/material.dart';
import 'package:mamyapp/settings_screen.dart';
import 'package:mamyapp/voice_cloning.dart';
import 'ChatBot.dart';
import 'notifications_screen.dart';

class HomePage extends StatefulWidget {
  final String userName;
  final String childName;
  final String childBirth;

  const HomePage({
    Key? key,
    required this.userName,
    required this.childName,
    required this.childBirth,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      HomeContent(
        userName: widget.userName,
        childName: widget.childName,
        childBirth: widget.childBirth,
      ),
      const SettingsScreen(),
      const NotificationsScreen(),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFFFF5EE),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFDAB9),
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu, color: Color(0xFF5D4E37)),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
            ),
          ),
        ],
      ),
      endDrawer: CustomDrawer(
        userName: widget.userName,
        selectedIndex: selectedIndex,
        onItemTap: (index) {
          setState(() {
            selectedIndex = index;
          });
          Navigator.pop(context);
        },
      ),
      body: pages[selectedIndex],
    );
  }
}

// ===== Custom Drawer =====
class CustomDrawer extends StatelessWidget {
  final String userName;
  final int selectedIndex;
  final Function(int) onItemTap;

  const CustomDrawer({
    Key? key,
    required this.userName,
    required this.selectedIndex,
    required this.onItemTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        children: [
          // Header with user info
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 60, 20, 30),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFFFDAB9), Color(0xFFFFCBA4)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const CircleAvatar(
                  radius: 35,
                  backgroundImage: AssetImage('assets/images/baby.png'),
                ),
                const SizedBox(height: 12),
                Text(
                  'مرحبا، $userName',
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF5D4E37),
                  ),
                ),
              ],
            ),
          ),
          // Menu Items
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildDrawerSection(
                  'الرئيسية',
                  [
                    _DrawerItem(
                      icon: Icons.home,
                      title: 'الصفحة الرئيسية',
                      isSelected: selectedIndex == 0,
                      onTap: () => onItemTap(0),
                    ),
                  ],
                ),
                const Divider(height: 1),
                _buildDrawerSection(
                  'حساب الطفل',
                  [
                    _DrawerItem(
                      icon: Icons.child_care,
                      title: 'حساب الطفل و تعديل البيانات',
                      isSelected: false,
                      onTap: () {},
                    ),
                  ],
                ),
                const Divider(height: 1),
                _buildDrawerSection(
                  'مُفضلتك',
                  [
                    _DrawerItem(
                      icon: Icons.favorite_border,
                      title: 'مكتبه القصص',
                      isSelected: false,
                      onTap: () {},
                    ),
                    _DrawerItem(
                      icon: Icons.message,
                      title: 'سجل المحادثات',
                      isSelected: false,
                      onTap: () {},
                    ),
                    _DrawerItem(
                      icon: Icons.child_friendly,
                      title: 'سجل تحليل البكاء',
                      isSelected: false,
                      onTap: () {},
                    ),
                  ],
                ),
                const Divider(height: 1),
                _buildDrawerSection(
                  'الخصوصية والدعم',
                  [
                    _DrawerItem(
                      icon: Icons.privacy_tip,
                      title: 'الخصوصية',
                      isSelected: false,
                      onTap: () {},
                    ),

                    _DrawerItem(
                      icon: Icons.help,
                      title: 'الأسئلة الشائعة',
                      isSelected: false,
                      onTap: () {},
                    ),
                  ],
                ),
                const Divider(height: 1),
                _buildDrawerSection(
                  'عن التطبيق',
                  [
                    _DrawerItem(
                      icon: Icons.info,
                      title: 'حول التطبيق',
                      isSelected: false,
                      onTap: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerSection(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
          child: Text(
            title,
            textAlign: TextAlign.right,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color(0xFF333333),
            ),
          ),
        ),
        ...items,
      ],
    );
  }
}

// ===== Drawer Item Widget =====
class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const _DrawerItem({
    required this.icon,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      leading: Icon(
        icon,
        color: isSelected ? const Color(0xFFFFB347) : const Color(0xFF888888),
        size: 22,
      ),
      title: Text(
        title,
        textAlign: TextAlign.right,
        style: TextStyle(
          fontSize: 13,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          color: isSelected ? const Color(0xFF333333) : const Color(0xFF666666),
        ),
      ),
      selected: isSelected,
      selectedTileColor: const Color(0xFFFFF5EE),
      onTap: onTap,
    );
  }
}

// ===== HomeContent =====
class HomeContent extends StatelessWidget {
  final String userName;
  final String childName;
  final String childBirth;

  const HomeContent({
    Key? key,
    required this.userName,
    required this.childName,
    required this.childBirth,
  }) : super(key: key);

  String _calculateAge(String birthDateString) {
    try {
      DateTime birthDate = DateTime.parse(birthDateString);
      DateTime today = DateTime.now();
      int age = today.year - birthDate.year;
      if (today.month < birthDate.month ||
          (today.month == birthDate.month && today.day < birthDate.day)) {
        age--;
      }
      return '$age سنة';
    } catch (e) {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          // Header Section
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFFFDAB9), Color(0xFFFFCBA4)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Text(
                  'الصفحة الرئيسية',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF5D4E37),
                  ),
                ),
                const SizedBox(height: 20),
                // User Info Card
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    textDirection: TextDirection.rtl,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 65,
                        height: 65,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage('assets/images/baby.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'اهلا $userName',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF333333),
                              ),
                              textAlign: TextAlign.right,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              childName,
                              style: const TextStyle(
                                fontSize: 13,
                                color: Color(0xFF888888),
                              ),
                              textAlign: TextAlign.right,
                            ),
                            Text(
                              'عمر الطفل: ${_calculateAge(childBirth)}',
                              style: const TextStyle(
                                fontSize: 13,
                                color: Color(0xFF888888),
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Menu Items
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  MenuCard(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFFF8DC), Color(0xFFFFE77A)],
                    ),
                    imageAsset: 'assets/images/11 (2).png',
                    title: 'المساعد الذكي للام',
                    subtitle: 'اسأل عن امور الرضاعة و التطعيمات',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AiAssistantScreen(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 15),
                  MenuCard(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFFE4B5), Color(0xFFFFD4A3)],
                    ),
                    imageAsset: 'assets/images/12 (2).png',
                    title: 'قصص بصوتك',
                    subtitle: 'احكي قصة يومية ودع طفلك يلعب بصوتك',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const VoiceCloningScreen(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 15),
                  MenuCard(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFE6E6FA), Color(0xFFD8BFD8)],
                    ),
                    imageAsset: 'assets/images/13 (1).png',
                    title: 'حللي بكاء طفلك',
                    subtitle: 'سجلي صوت طفلك لتحليل سبب بكائه فوريا',
                    onTap: () {},
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

// ===== MenuCard =====
class MenuCard extends StatefulWidget {
  final Gradient gradient;
  final String imageAsset;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const MenuCard({
    Key? key,
    required this.gradient,
    required this.imageAsset,
    required this.title,
    required this.subtitle,
    required this.onTap,
  }) : super(key: key);

  @override
  State<MenuCard> createState() => _MenuCardState();
}

class _MenuCardState extends State<MenuCard> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          isPressed = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          isPressed = false;
        });
        widget.onTap();
      },
      onTapCancel: () {
        setState(() {
          isPressed = false;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        transform: isPressed
            ? (Matrix4.identity()..translate(0, -5, 0))
            : Matrix4.identity(),
        decoration: BoxDecoration(
          gradient: widget.gradient,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(isPressed ? 0.3 : 0.08),
              blurRadius: isPressed ? 12 : 8,
              offset: Offset(0, isPressed ? 8 : 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(18),
        child: Row(
          textDirection: TextDirection.rtl,
          children: [
            Container(
              width: 55,
              height: 55,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(widget.imageAsset),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    widget.title,
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF333333),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.subtitle,
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xFF666666),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}