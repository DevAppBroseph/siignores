import 'package:equatable/equatable.dart';

class OfferEntity extends Equatable {
  final int id;
  final String header;
  final String description;
  final String? image;

  OfferEntity({
    required this.id,
    required this.header,
    required this.image,
    required this.description,
  });



  @override
  List<Object> get props => [
        id,
        header,
        description,

      ];
}
