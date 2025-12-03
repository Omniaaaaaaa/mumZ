import 'package:flutter/material.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFFFF0E8),
        appBar: AppBar(
          backgroundColor: const Color(0xFFFFD4C4),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.menu, color: Color(0xFFE89B88)),
            onPressed: () {},
          ),
          title: const Text(
            'تواصل معنا',
            style: TextStyle(
              color: Color(0xFFE89B88),
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.arrow_right_alt_outlined, color: Color(0xFFE89B88)),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'هل لديك سؤال أو مشكلة؟',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'يسعدنا مساعدتك في أي وقت!\nيمكنك التواصل معنا عبر أحد الطرق التالية:',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 30),

              // Sections
              _buildSection(
                number: '١',
                title: 'البريد الإلكتروني',
                items: [
                  'Email: example@email.com',
                  'للاستفسارات، الإبلاغ عن مشكلة، أو اقتراح ميزة جديدة.',
                ],
              ),

              _buildSection(
                number: '٢',
                title: 'مركز المساعدة',
                items: [
                  'أسئلة شائعة وإرشادات سريعة لحل أغلب المشكلات.',
                ],
              ),

              _buildSection(
                number: '٣',
                title: 'إرسال بلاغ داخل التطبيق',
                items: [
                  'يمكنك إرسال رسالة مباشرة من داخل التطبيق مع وصف المشكلة.',
                ],
              ),

              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // مثال: إعادة توجيه لنفس الصفحة أو أي صفحة تانية
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFB4A0),
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    "تواصل معنا",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              _buildSection(
                number: '٤',
                title: 'تابعينا على صفحاتنا',
                items: [
                  'تحديثات طفيفة ونصائح يومية للأمهات:',
                  'Instagram',
                  'Facebook',
                ],
                isLast: true, // آخر Section بدون خط تحتي
              ),

              const SizedBox(height: 20),
              const Center(
                child: Text(
                  'سعداء دائمًا بمساعدتك️',
                  style: TextStyle(
                    color: Color(0xFFE89B88),
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildSection({
  required String number,
  required String title,
  required List<String> items,
  bool isLast = false,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        '$number. $title',
        style: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 12),
      ...items.map(
            (item) => Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            textDirection: TextDirection.rtl,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '• ',
                style: TextStyle(
                  fontSize: 16,
                  height: 1.6,
                ),
              ),
              Expanded(
                child: Text(
                  item,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    fontSize: 15,
                    height: 1.6,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      if (!isLast) ...[
        const SizedBox(height: 20),
        Container(
          height: 1,
          width: double.infinity,
          color: Colors.grey,
        ),
        const SizedBox(height: 25),
      ],
    ],
  );
}
