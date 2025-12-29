
import 'package:flutter/material.dart';
import 'package:mamyapp/features/chatbot/presentation/pages/chatBot.dart';
import 'package:mamyapp/features/home/presentation/widget/menu_card.dart';
import 'package:mamyapp/features/story_telling/presentation/pages/choose_story.dart';

class HomeContent extends StatelessWidget {
  final String userName;
  final String childName;
  final String childBirth;

  const HomeContent({
    super.key,
    required this.userName,
    required this.childName,
    required this.childBirth,
  });

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
                        // ignore: deprecated_member_use
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
                          builder: (context) => const ChooseStory(),
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
                    onTap: () {
                      
                    },
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