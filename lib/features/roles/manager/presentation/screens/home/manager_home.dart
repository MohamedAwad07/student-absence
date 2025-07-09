import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:student_absence/core/routing/app_routes.dart';
import 'package:student_absence/core/utils/nav_bar_cubit.dart';
import 'package:student_absence/core/widgets/app_bar.dart';
import 'package:student_absence/core/utils/app_colors.dart';

class ManagerHomePage extends StatefulWidget {
  const ManagerHomePage({super.key});

  @override
  State<ManagerHomePage> createState() => _ManagerHomePageState();
}

class _ManagerHomePageState extends State<ManagerHomePage> {
  @override
  void initState() {
    super.initState();
    // context.read<SupervisorCubit>().getPendingExcuses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: CustomScrollView(
        slivers: [
          BuildCustomAppBar(
            profileOnPressed: () {
              context.go(AppRoutes.supervisorProfilePage);
              context.read<NavBarCubit>().setTab(4);
            },
          ),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8),
                  // Section Title
                  Text(
                    'الأعذار المحولة من المشرف',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppColors.primary,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'قائمة الأعذار التي تم تحويلها إلى اتخاذ القرار النهائي',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 12),
                  // _ReviewedExcuseList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// class _ReviewedExcuseList extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<SupervisorCubit, SupervisorState>(
//       builder: (context, state) {
//         if (state is SupervisorLoading) {
//           return Skeletonizer(
//             enabled: true,
//             child: Column(
//               children: List.generate(3, (index) => _ExcuseSkeletonCard()),
//             ),
//           );
//         } else if (state is SupervisorPendingExcusesLoaded) {
//           final excuses = state.excuses;
//           if (excuses.isEmpty) {
//             return const Center(child: Text('لا توجد أعذار حالياً'));
//           }
//           return Column(
//             children: excuses.map((excuse) {
//               return Container(
//                 margin: const EdgeInsets.symmetric(vertical: 6),
//                 padding: const EdgeInsets.symmetric(
//                   vertical: 12,
//                   horizontal: 12,
//                 ),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         Text(
//                           excuse.studentName,
//                           style: const TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 15,
//                           ),
//                         ),
//                         const Spacer(),
//                         _StatusChip(
//                           status: excuse.status,
//                           color: _statusColor(excuse.status),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 2),
//                     Text(
//                       'رقم الطالب: ${excuse.studentAcademicNumber}',
//                       style: const TextStyle(
//                         fontSize: 13,
//                         color: Colors.black54,
//                       ),
//                     ),
//                     const SizedBox(height: 2),
//                     Text(
//                       'نوع العذر: ${excuse.type}',
//                       style: const TextStyle(
//                         fontSize: 13,
//                         color: Colors.black54,
//                       ),
//                     ),
//                     const SizedBox(height: 2),
//                     Text(
//                       'تاريخ التقديم: ${excuse.createdAt.toString().split(' ')[0]}',
//                       style: const TextStyle(
//                         fontSize: 13,
//                         color: Colors.black54,
//                       ),
//                     ),
//                     const SizedBox(height: 6),
//                     Align(
//                       alignment: Alignment.bottomLeft,
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: AppColors.primary,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(18),
//                           ),
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 18,
//                             vertical: 4,
//                           ),
//                         ),
//                         onPressed: () {
//                           context.go(
//                             AppRoutes.supervisorExcuseDetails,
//                             extra: excuse,
//                           );
//                           context.read<NavBarCubit>().setTab(1);
//                         },
//                         child: const Text(
//                           'عرض التفاصيل',
//                           style: TextStyle(fontSize: 13, color: Colors.white),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             }).toList(),
//           );
//         } else if (state is SupervisorError) {
//           return Center(child: Text(state.failure.message));
//         } else {
//           return const SizedBox.shrink();
//         }
//       },
//     );
//   }
// }

// class _ExcuseSkeletonCard extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(vertical: 6),
//       padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Skeleton.leaf(
//                 child: Container(
//                   width: 100,
//                   height: 18,
//                   color: Colors.grey[300],
//                 ),
//               ),
//               const Spacer(),
//               Skeleton.leaf(
//                 child: Container(
//                   width: 60,
//                   height: 18,
//                   color: Colors.grey[300],
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 2),
//           Skeleton.leaf(
//             child: Container(width: 120, height: 14, color: Colors.grey[300]),
//           ),
//           const SizedBox(height: 2),
//           Skeleton.leaf(
//             child: Container(width: 100, height: 14, color: Colors.grey[300]),
//           ),
//           const SizedBox(height: 2),
//           Skeleton.leaf(
//             child: Container(width: 140, height: 14, color: Colors.grey[300]),
//           ),
//           const SizedBox(height: 6),
//           Align(
//             alignment: Alignment.bottomLeft,
//             child: Skeleton.leaf(
//               child: Container(
//                 width: 80,
//                 height: 28,
//                 decoration: BoxDecoration(
//                   color: Colors.grey[300],
//                   borderRadius: BorderRadius.circular(18),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// Color _statusColor(String status) {
//   switch (status) {
//     case 'مقبول':
//       return AppColors.primary;
//     case 'قيد المراجعة':
//       return AppColors.secondary;
//     case 'مرفوض':
//       return const Color(0xFFF44336);
//     default:
//       return Colors.grey;
//   }
// }

// class _StatusChip extends StatelessWidget {
//   final String status;
//   final Color color;
//   const _StatusChip({required this.status, required this.color});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 4),
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
//       decoration: BoxDecoration(
//         color: color.withValues(alpha: 0.12),
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Text(
//         status,
//         style: TextStyle(
//           color: color,
//           fontWeight: FontWeight.bold,
//           fontSize: 12,
//         ),
//       ),
//     );
//   }
// }
