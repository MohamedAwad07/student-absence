import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:student_absence/core/routing/app_routes.dart';
import 'package:student_absence/core/service%20locator/di.dart';
import 'package:student_absence/core/utils/nav_bar_cubit.dart';
import 'package:student_absence/core/widgets/app_bar.dart';
import 'package:student_absence/core/utils/app_colors.dart';
import 'package:student_absence/features/roles/student/presentation/controller/student_cubit/student_cubit.dart';
import 'package:student_absence/features/roles/student/data/models/excuse.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:student_absence/core/utils/image_picker.dart';

class StudentAddExcusePage extends StatefulWidget {
  const StudentAddExcusePage({super.key});

  @override
  State<StudentAddExcusePage> createState() => _StudentAddExcusePageState();
}

class _StudentAddExcusePageState extends State<StudentAddExcusePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController reasonController = TextEditingController();
  String? excuseType;
  bool agreed = false;

  String? fileURL;
  String? imageURL;
  bool fileUploading = false;
  bool imageUploading = false;

  final AssetsPickerHelper _pickerHelper = AssetsPickerHelper();

  Future<void> _pickImage() async {
    setState(() => imageUploading = true);
    final url = await _pickerHelper.pickImageFromGallery();
    setState(() {
      imageUploading = false;
      if (url != null) {
        imageURL = url;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('فشل رفع الصورة. حاول مرة أخرى.')),
        );
      }
    });
  }

  Future<void> _pickPdf() async {
    setState(() => fileUploading = true);
    final url = await _pickerHelper.pickPdfFromGallery();
    setState(() {
      fileUploading = false;
      if (url != null) {
        fileURL = url;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('فشل رفع ملف PDF. حاول مرة أخرى.')),
        );
      }
    });
  }

  void _deleteImage() {
    setState(() {
      imageURL = null;
    });
  }

  void _deletePdf() {
    setState(() {
      fileURL = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<StudentCubit, StudentState>(
      listener: (context, state) {
        if (state is StudentExcuseSubmitted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
          context.go(AppRoutes.studentTrackExcuses);
          context.read<NavBarCubit>().setTab(1);
        } else if (state is StudentError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.scaffoldBackground,
        body: CustomScrollView(
          slivers: [
            BuildCustomAppBar(
              profileOnPressed: () {
                context.go(AppRoutes.studentProfilePage);
                context.read<NavBarCubit>().setTab(4);
              },
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 12.0,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 12),
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
                            DropdownMenuItem(
                              value: 'طبي',
                              child: Text('عذر طبي'),
                            ),
                            DropdownMenuItem(
                              value: 'سفر',
                              child: Text('عذر سفر'),
                            ),
                            DropdownMenuItem(
                              value: 'اخري',
                              child: Text('اخري'),
                            ),
                          ],
                          value: excuseType,
                          onChanged: (value) =>
                              setState(() => excuseType = value),
                          validator: (value) =>
                              value == null ? 'يرجى اختيار نوع العذر' : null,
                        ),
                      ),
                      const SizedBox(height: 12),
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
                          validator: (value) => value == null || value.isEmpty
                              ? 'يرجى اختيار التاريخ'
                              : null,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _LabeledField(
                        label: 'سبب الغياب',
                        child: TextFormField(
                          controller: reasonController,
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
                          validator: (value) => value == null || value.isEmpty
                              ? 'يرجى كتابة السبب'
                              : null,
                        ),
                      ),
                      const SizedBox(height: 18),
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
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: (imageUploading || imageURL != null)
                                  ? null
                                  : _pickImage,
                              icon: imageUploading
                                  ? const SizedBox(
                                      width: 16,
                                      height: 16,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Colors.white,
                                      ),
                                    )
                                  : const Icon(Icons.image),
                              label: const Text('إرفاق صورة'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: (fileUploading || fileURL != null)
                                  ? null
                                  : _pickPdf,
                              icon: fileUploading
                                  ? const SizedBox(
                                      width: 16,
                                      height: 16,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Colors.white,
                                      ),
                                    )
                                  : const Icon(Icons.picture_as_pdf),
                              label: const Text('إرفاق PDF'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.secondary,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      if (imageURL != null)
                        _FileChip(
                          fileName: imageURL!.split('/').last,
                          color: Colors.green,
                          onDelete: _deleteImage,
                        ),
                      if (fileURL != null)
                        _FileChip(
                          fileName: fileURL!.split('/').last,
                          color: AppColors.secondary,
                          onDelete: _deletePdf,
                        ),
                      const SizedBox(height: 18),
                      Row(
                        children: [
                          Checkbox(
                            value: agreed,
                            onChanged: (v) =>
                                setState(() => agreed = v ?? false),
                          ),
                          const Expanded(
                            child: Text(
                              'أتعهد بأن البيانات أعلاه صحيحة وجميع الملفات المُرفقة مُطابقة للأصل',
                              style: TextStyle(fontSize: 13),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: BlocBuilder<StudentCubit, StudentState>(
                              builder: (context, state) {
                                return ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                  ),
                                  onPressed: (state is StudentLoading)
                                      ? null
                                      : () {
                                          if (_formKey.currentState!
                                                  .validate() &&
                                              agreed) {
                                            final user = FirebaseAuth
                                                .instance
                                                .currentUser!;
                                            final excuse = StudentExcuseModel(
                                              excuseId: DateTime.now()
                                                  .millisecondsSinceEpoch
                                                  .toString(),
                                              studentId: user.uid,
                                              reason: reasonController.text,
                                              status: 'قيد المراجعة',
                                              type: excuseType ?? 'أخري',
                                              fileURL: fileURL,
                                              imageURL: imageURL,
                                              supervisorId: null,
                                              supervisorComment: null,
                                              managerId: null,
                                              managerComment: null,
                                              createdAt: DateTime.now(),
                                              updatedAt: null,
                                            );
                                            context
                                                .read<StudentCubit>()
                                                .submitExcuse(excuse);
                                          } else {
                                            toastLocator.warning(
                                              context,
                                              'يرجى التأكد من صحة البيانات وتأكيد الموافقة على الشروط والأحكام',
                                            );
                                          }
                                        },
                                  child: (state is StudentLoading)
                                      ? const CircularProgressIndicator()
                                      : const Text(
                                          'تقديم العذر',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.white,
                                          ),
                                        ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
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
class _FileChip extends StatelessWidget {
  final String fileName;
  final Color color;
  final VoidCallback? onDelete;
  const _FileChip({required this.fileName, required this.color, this.onDelete});

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
          GestureDetector(
            onTap: onDelete,
            child: Icon(Icons.close, color: color, size: 18),
          ),
        ],
      ),
    );
  }
}
