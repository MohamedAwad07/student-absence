import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:student_absence/core/routing/app_routes.dart';
import 'package:student_absence/core/service%20locator/di.dart';
import 'package:student_absence/core/utils/nav_bar_cubit.dart';
import 'package:student_absence/core/widgets/app_bar.dart';
import 'package:student_absence/core/utils/app_colors.dart';
import 'package:student_absence/features/roles/supervisor/data/models/get_excuse_info_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:student_absence/features/roles/manager/data/models/update_excuse_manager.dart';
import 'package:student_absence/features/roles/manager/presentation/controller/manager_cubit/manager_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

class ManagerExcuseDetails extends StatefulWidget {
  final GetExcuseInfoModel excuse;
  const ManagerExcuseDetails({super.key, required this.excuse});

  @override
  State<ManagerExcuseDetails> createState() => _ManagerExcuseDetailsState();
}

class _ManagerExcuseDetailsState extends State<ManagerExcuseDetails> {
  final TextEditingController _commentController = TextEditingController();
  String? _decision;

  void _openUrl(String url) async {
    final uri = Uri.tryParse(url);
    if (uri == null) {
      toastLocator.error(context, "خطأ", "تعذر فتح الرابط");
      return;
    }
    try {
      final launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
      if (!launched) {
        toastLocator.error(context, "خطأ", "تعذر فتح الرابط");
      }
    } catch (e) {
      toastLocator.error(context, "خطأ", "تعذر فتح الرابط");
    }
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _onConfirm() {
    if (_decision == null || _commentController.text.isEmpty) {
      toastLocator.warning(context, ' يرجي إختيار القرار وكتابة الملاحظات');
      return;
    }
    final status = _decision == 'accept' ? 'مقبول' : 'مرفوض';
    context.read<ManagerCubit>().updateExcuseStatus(
      excuseId: widget.excuse.excuseId,
      managerUpdateExcuseModel: ManagerUpdateExcuseModel(
        managerId: FirebaseAuth.instance.currentUser!.uid,
        status: status,
        comment: _commentController.text,
        updatedAt: DateTime.now(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ManagerCubit, ManagerState>(
      listener: (context, state) {
        if (state is ManagerExcuseStatusUpdated) {
          toastLocator.success(context, 'تم تحديث حالة الإذن بنجاح');
          context.go(AppRoutes.managerHome);
          context.read<NavBarCubit>().setTab(0);
        } else if (state is ManagerError) {
          toastLocator.error(context, "خطأ", "حدث خطأ ما");
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.scaffoldBackground,
        body: CustomScrollView(
          slivers: [
            BuildCustomAppBar(
              profileOnPressed: () {
                context.go(AppRoutes.managerProfilePage);
                context.read<NavBarCubit>().setTab(4);
              },
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 8.0,
                  right: 16.0,
                  top: 6,
                  bottom: 12,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Back and Title
                    Row(
                      children: [
                        const Text(
                          'تفاصيل العذر',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: AppColors.primary,
                          ),
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            context.go(AppRoutes.managerHome);
                            context.read<NavBarCubit>().setTab(0);
                          },
                          child: const Text(
                            'عودة لسجل الأعذار',
                            style: TextStyle(
                              fontSize: 13,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // Excuse Type and Student Info
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.excuse.type,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: AppColors.primary,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                const Text(
                                  'اسم الطالب:',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.black54,
                                  ),
                                ),
                                Text(
                                  widget.excuse.studentName,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                const Text(
                                  'رقم الطالب:',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.black54,
                                  ),
                                ),
                                Text(
                                  widget.excuse.studentAcademicNumber,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                const Text(
                                  'تاريخ التقديم:',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.black54,
                                  ),
                                ),
                                Text(
                                  widget.excuse.createdAt.toString().split(
                                    ' ',
                                  )[0],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Icon(
                            Icons.info_outline,
                            color: AppColors.primary,
                            size: 28,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Excuse Reason
                    const Text(
                      'سبب العذر',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.excuse.reason,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Attachments
                    const Text(
                      'المرفقات',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (widget.excuse.fileURL != null)
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey.shade100,
                              foregroundColor: AppColors.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                            ),
                            onPressed: () {
                              _openUrl(widget.excuse.fileURL!);
                            },
                            icon: const Icon(
                              Icons.picture_as_pdf,
                              color: AppColors.primary,
                              size: 20,
                            ),
                            label: Text(
                              widget.excuse.fileURL!.split('/').last,
                              style: const TextStyle(
                                fontSize: 13,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        if (widget.excuse.imageURL != null)
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey.shade100,
                                foregroundColor: AppColors.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                elevation: 0,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                              ),
                              onPressed: () {
                                _openUrl(widget.excuse.imageURL!);
                              },
                              icon: const Icon(
                                Icons.image,
                                color: AppColors.primary,
                                size: 20,
                              ),
                              label: Text(
                                widget.excuse.imageURL!.split('/').last,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Academic Notes
                    const Text(
                      'ملاحظات المراجع الأكاديمي',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      margin: const EdgeInsets.only(bottom: 12, left: 12),
                      decoration: BoxDecoration(
                        color: AppColors.containerBackground2Pink,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.excuse.updatedAt.toString().split(' ')[0],
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black54,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            widget.excuse.supervisorComment ??
                                "لا يوجد ملاحظات",
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Decision
                    const Text(
                      'اتخاذ قرار نهائي',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Text(
                          'القرار:',
                          style: TextStyle(fontSize: 13, color: Colors.black87),
                        ),
                        const SizedBox(width: 12),
                        Row(
                          children: [
                            Radio<String>(
                              value: 'accept',
                              groupValue: _decision,
                              onChanged: (val) =>
                                  setState(() => _decision = val),
                            ),
                            const Text('قبول', style: TextStyle(fontSize: 13)),
                            const SizedBox(width: 8),
                            Radio<String>(
                              value: 'reject',
                              groupValue: _decision,
                              onChanged: (val) =>
                                  setState(() => _decision = val),
                            ),
                            const Text('رفض', style: TextStyle(fontSize: 13)),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'ملاحظات:',
                      style: TextStyle(fontSize: 13, color: Colors.black87),
                    ),
                    const SizedBox(height: 4),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: TextField(
                        controller: _commentController,
                        minLines: 2,
                        maxLines: 4,
                        decoration: InputDecoration(
                          hintText: 'أضف ملاحظات هنا ...',
                          hintStyle: const TextStyle(
                            fontSize: 13,
                            color: Colors.black38,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 10,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: BlocBuilder<ManagerCubit, ManagerState>(
                        builder: (context, state) {
                          final isLoading = state is ManagerLoading;
                          return Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                              ),
                              onPressed: isLoading ? null : _onConfirm,
                              child: isLoading
                                  ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Colors.white,
                                      ),
                                    )
                                  : const Text(
                                      'تأكيد القرار',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                      ),
                                    ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
