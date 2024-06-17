import 'package:bloc/bloc.dart';
import 'package:education_app/features/course/features/materials/domain/entities/resource.dart';
import 'package:education_app/features/course/features/materials/domain/usecases/add_material.dart';
import 'package:education_app/features/course/features/materials/domain/usecases/get_materials.dart';
import 'package:equatable/equatable.dart';

part 'material_state.dart';

class MaterialCubit extends Cubit<MaterialState> {
  MaterialCubit({
    required AddMaterial addMaterial,
    required GetMaterials getMaterials,
  })  : _addMaterial = addMaterial,
        _getMaterials = getMaterials,
        super(MaterialInitial());

  final AddMaterial _addMaterial;
  final GetMaterials _getMaterials;

  Future<void> addMaterials(List<Resource> materials) async {
    emit(const AddingMaterials());

    for (final material in materials) {
      final result = await _addMaterial(material);
      result.fold(
        (failure) {
          emit(MaterialError(failure.errorMessage));
          return;
        },
        (_) => null,
      );
    }
    emit(const MaterialsAdded());
  }

  Future<void> getMaterials(String courseId) async {
    emit(const AddingMaterials());
    final result = await _getMaterials(courseId);
    result.fold(
      (failure) => emit(MaterialError(failure.errorMessage)),
      (materials) => emit(MaterialsLoaded(materials)),
    );
  }
}
