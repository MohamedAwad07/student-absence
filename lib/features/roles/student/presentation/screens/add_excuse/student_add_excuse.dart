import 'package:flutter/material.dart';
import 'package:student_absence/core/widgets/app_bar.dart';
import 'package:student_absence/core/utils/app_colors.dart';

class StudentAddExcusePage extends StatelessWidget {
  const StudentAddExcusePage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController dateController = TextEditingController();
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: CustomScrollView(
        slivers: [
          StudentHomeAppBar(profileOnPressed: () {}),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 12.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),
                  // Title
                  const Center(
                    child: Text(
                      'نموذج تقديم العذر',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Center(
                    child: Text(
                      'يرجى تعبئة النموذج وتقديم العذر مع إرفاق المستندات المطلوبة',
                      style: TextStyle(color: Colors.black54, fontSize: 13),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 18),
                  // Excuse Type Dropdown
                  _LabeledField(
                    label: 'نوع العذر',
                    child: DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'اختر نوع العذر',
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                      ),
                      items: const [
                        DropdownMenuItem(value: 'طبي', child: Text('عذر طبي')),
                        DropdownMenuItem(value: 'سفر', child: Text('عذر سفر')),
                        DropdownMenuItem(value: 'اخري', child: Text('اخري')),
                      ],
                      onChanged: (value) {},
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Date Picker
                  _LabeledField(
                    label: 'تاريخ الغياب',
                    child: TextFormField(
                      controller: dateController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'اختر التاريخ',
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                      ),
                      readOnly: true,
                      onTap: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        );
                        if (picked != null) {
                          dateController.text =
                              "${picked.year.toString().padLeft(4, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Reason
                  _LabeledField(
                    label: 'سبب الغياب',
                    child: TextFormField(
                      minLines: 2,
                      maxLines: 4,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'اكتب السبب بشكل تفصيلي',
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  // File Upload Section
                  const Text(
                    'إرفاق الملفات',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'يمكنك إرفاق المستندات الخاصة بالعذر (PDF، صور).',
                    style: TextStyle(color: Colors.black54, fontSize: 12),
                  ),
                  const SizedBox(height: 10),
                  const _FileUploadDemo(),
                  const SizedBox(height: 18),
                  // Checkbox
                  Row(
                    children: [
                      Checkbox(value: true, onChanged: (v) {}),
                      const Expanded(
                        child: Text(
                          'أتعهد بأن البيانات أعلاه صحيحة وجميع الملفات المُرفقة مُطابقة للأصل',
                          style: TextStyle(fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Submit and Cancel Buttons
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                          onPressed: () {},
                          child: const Text(
                            'تقديم العذر',
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: AppColors.primary),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                          onPressed: () {},
                          child: const Text(
                            'إلغاء',
                            style: TextStyle(
                              fontSize: 15,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LabeledField extends StatelessWidget {
  final String label;
  final Widget child;
  const _LabeledField({required this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ),
        const SizedBox(height: 4),
        child,
      ],
    );
  }
}

class _FileUploadDemo extends StatelessWidget {
  const _FileUploadDemo();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Upload area
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 18),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.shade400,
              style: BorderStyle.solid,
            ),
            borderRadius: BorderRadius.circular(12),
            color: Colors.grey.shade100,
          ),
          child: const Column(
            children: [
              Icon(Icons.cloud_upload, color: AppColors.primary, size: 32),
              SizedBox(height: 8),
              Text('اسحب الملفات هنا أو', style: TextStyle(fontSize: 13)),
              SizedBox(height: 4),
              ElevatedButton(
                onPressed: null,
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(AppColors.primary),
                  foregroundColor: WidgetStatePropertyAll(Colors.white),
                  padding: WidgetStatePropertyAll(
                    EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  ),
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                  ),
                ),
                child: Text('اختر ملف'),
              ),
              SizedBox(height: 4),
              Text(
                'يسمح برفع ملفات (JPG, PNG, PDF) بحد أقصى 5 ميجا',
                style: TextStyle(fontSize: 11, color: Colors.black54),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        // Static file chips
        const _FileChip(
          fileName: 'آدم_تقرير_طبي.pdf',
          color: AppColors.secondary,
        ),
        const _FileChip(
          fileName: 'wow_صورة_الإجازة_المرضية.png',
          color: Colors.green,
        ),
      ],
    );
  }
}

class _FileChip extends StatelessWidget {
  final String fileName;
  final Color color;
  const _FileChip({required this.fileName, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(
            fileName.endsWith('.pdf') ? Icons.picture_as_pdf : Icons.image,
            color: color,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              fileName,
              style: TextStyle(fontWeight: FontWeight.w600, color: color),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 8),
          Icon(Icons.close, color: color, size: 18),
        ],
      ),
    );
  }
}
