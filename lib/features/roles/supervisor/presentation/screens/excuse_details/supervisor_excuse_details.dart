import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:student_absence/core/routing/app_routes.dart';
import 'package:student_absence/core/service%20locator/di.dart';
import 'package:student_absence/core/utils/nav_bar_cubit.dart';
import 'package:student_absence/core/widgets/app_bar.dart';
import 'package:student_absence/core/utils/app_colors.dart';
import 'package:student_absence/features/roles/supervisor/data/models/get_excuse_info_model.dart';
import 'package:student_absence/features/roles/supervisor/presentation/controller/supervisor_cubit/supervisor_cubit.dart';
import 'package:student_absence/features/roles/supervisor/data/models/update_excuse_model.dart';
import 'package:url_launcher/url_launcher.dart';

class SupervisorExcuseDetailsPage extends StatefulWidget {
  final GetExcuseInfoModel excuse;
  const SupervisorExcuseDetailsPage({super.key, required this.excuse});

  @override
  State<SupervisorExcuseDetailsPage> createState() =>
      _SupervisorExcuseDetailsPageState();
}

class _SupervisorExcuseDetailsPageState
    extends State<SupervisorExcuseDetailsPage> {
  final TextEditingController _commentController = TextEditingController();
  String? _decision;

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
    final status = _decision == 'accept' ? 'بإنتظار القرار النهائي' : 'مرفوض';
    context.read<SupervisorCubit>().updateExcuseStatus(
      excuseId: widget.excuse.excuseId,
      updateExcuseModel: UpdateExcuseModel(
        supervisorId: FirebaseAuth.instance.currentUser!.uid,
        status: status,
        comment: _commentController.text,
        updatedAt: DateTime.now(),
      ),
    );
  }

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
  Widget build(BuildContext context) {
    return BlocListener<SupervisorCubit, SupervisorState>(
      listener: (context, state) {
        if (state is SupervisorExcuseStatusUpdated) {
          toastLocator.success(context, 'تم تحديث حالة الإذن بنجاح');
          context.go(AppRoutes.supervisorHome);
          context.read<NavBarCubit>().setTab(0);
        } else if (state is SupervisorError) {
          toastLocator.error(context, "خطأ", "حدث خطأ ما");
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.scaffoldBackground,
        body: CustomScrollView(
          slivers: [
            BuildCustomAppBar(
              profileOnPressed: () {
                context.go(AppRoutes.supervisorProfilePage);
                context.read<NavBarCubit>().setTab(4);
              },
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 12.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    // Title
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 4.0,
                      ),
                      child: Text(
                        'تفاصيل العذر',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 2),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        'يمكنك مراجعة تفاصيل العذر واتخاذ القرار للطالب',
                        style: TextStyle(color: Colors.black54, fontSize: 13),
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Excuse Info Card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 12,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'معلومات الطالب',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: AppColors.primary,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const CircleAvatar(
                                    radius: 18,
                                    backgroundColor: AppColors.primary,
                                    child: Icon(
                                      Icons.person,
                                      color: Colors.white,
                                      size: 22,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.excuse.studentName,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                        ),
                                      ),
                                      Text(
                                        'رقم الطالب: ${widget.excuse.studentAcademicNumber}',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.secondary.withValues(
                                alpha: 0.12,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              widget.excuse.status,
                              style: const TextStyle(
                                color: AppColors.secondary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Excuse Details
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 12,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                widget.excuse.type,
                                style: const TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                widget.excuse.createdAt.toString().split(
                                  ' ',
                                )[0],
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'سبب العذر: ${widget.excuse.reason}',
                            style: const TextStyle(fontSize: 13),
                          ),
                          if (widget.excuse.fileURL != null) ...[
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () => _openUrl(widget.excuse.fileURL!),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.attachment,
                                        color: AppColors.secondary,
                                        size: 18,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        widget.excuse.fileURL!.split('/').last,
                                        style: const TextStyle(
                                          color: AppColors.secondary,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                          if (widget.excuse.imageURL != null) ...[
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () =>
                                      _openUrl(widget.excuse.imageURL!),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.image,
                                        color: Colors.green,
                                        size: 18,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        widget.excuse.imageURL!.split('/').last,
                                        style: const TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Notes
                    const Text(
                      'إتخاذ قرار',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _commentController,
                      minLines: 2,
                      maxLines: 4,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(),
                        hintText: 'أضف ملاحظتك ...',
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Decision
                    const Text(
                      'اختر القرار المناسب',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Replace _DecisionRadioGroup with local radio buttons
                    Column(
                      children: [
                        RadioListTile<String>(
                          activeColor: AppColors.primary,
                          value: 'accept',
                          groupValue: _decision,
                          onChanged: (val) => setState(() => _decision = val),
                          title: const Text('قبول العذر'),
                        ),
                        RadioListTile<String>(
                          activeColor: AppColors.primary,
                          value: 'reject',
                          groupValue: _decision,
                          onChanged: (val) => setState(() => _decision = val),
                          title: const Text('رفض العذر'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    // Action Buttons
                    BlocBuilder<SupervisorCubit, SupervisorState>(
                      builder: (context, state) {
                        final isLoading = state is SupervisorLoading;
                        return Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24),
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
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(
                                    color: AppColors.primary,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                ),
                                onPressed: () {
                                  context.go(AppRoutes.supervisorHome);
                                  context.read<NavBarCubit>().setTab(0);
                                },
                                child: const Text(
                                  'رجوع',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 16),
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
