import '../../domain/entities/offer_entity.dart';

class OfferModel extends OfferEntity{
  OfferModel({
    required int id,
    required String header,
    required String description,
    required String? image,

  }) : super(
    id: id, 
    header: header,
    image: image,
    description: description,
  );

  factory OfferModel.fromJson(Map<String, dynamic> json) => OfferModel(
    id: json['id'] ?? 1,
    header: json['header'],
    image: json['image'],
    description: json['description'],
    
  );
}