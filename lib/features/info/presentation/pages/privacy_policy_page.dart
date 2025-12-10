import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

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
            onPressed: () {
            },
          ),
          title: const Text(
            'سياسة الخصوصية',
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
                'نلتزم بحماية بياناتك وبيانات طفلك',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'وضمان استخدامها بأمان داخل التطبيق.',
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
                title: 'البيانات التي نجمعها',
                items: [
                  'اسم الطفل، العمر والصورة (اختياري).',
                  'تسجيلات الصوت للفحص أو تحليل البكاء.',
                  'سجل الفحوصات والتشخيص ونتائج التحليل.',
                ],
              ),

              _buildSection(
                number: '٢',
                title: 'استخدام البيانات',
                items: [
                  'تحسين دقة تحليل بكاء الطفل.',
                  'إنشاء القصص الصوتية.',
                  'تحسين تجربة المساعد الذكي.',
                ],
              ),

              _buildSection(
                number: '٣',
                title: 'حماية البيانات',
                items: [
                  'تخزين آمن ومشفر.',
                  'عدم مشاركة البيانات مع أي طرف خارجي.',
                  'عدم استخدام البيانات لأغراض تسويقية.',
                ],
              ),

              _buildSection(
                number: '٤',
                title: 'التحكم ببياناتك',
                items: [
                  'يمكنك تعديل أو حذف بيانات طفلك وجميع التسجيلات والفحوصات وسجل التحليل في أي وقت.',
                ],
              ),

              _buildSection(
                number: '٥',
                title: 'تحديث السياسة',
                items: [
                  'قد يتم تحديث هذه السياسة.',
                  'سيتم إعلامك عند حدوث تغييرات مهمة.',
                ],
                isLast: true,
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
