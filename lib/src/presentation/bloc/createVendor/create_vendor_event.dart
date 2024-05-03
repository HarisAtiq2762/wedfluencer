import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:wedfluencer/src/infrastructure/domain/create_vendor/vendor_dto.dart';

class CreateVendorEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class VendorCreationEvent extends CreateVendorEvent {
  final VendorDTO dto;
  final BuildContext context;
  VendorCreationEvent({required this.dto, required this.context});
  @override
  List<Object?> get props => [dto];
}
