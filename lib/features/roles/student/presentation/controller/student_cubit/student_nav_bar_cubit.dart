import 'package:flutter_bloc/flutter_bloc.dart';

class StudentNavBarCubit extends Cubit<int> {
  StudentNavBarCubit() : super(0);

  void setTab(int index) => emit(index);
} 