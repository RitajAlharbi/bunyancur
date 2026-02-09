import 'package:flutter/foundation.dart';

enum FavoriteType { product, account }

@immutable
class FavoriteItemModel {
  final String id;
  final FavoriteType type;
  final String? title;
  final String? sellerName;
  final double? price;
  final double? rating;
  final String? imageUrl;
  final String? name;
  final String? role;
  final String? avatarUrl;

  const FavoriteItemModel({
    required this.id,
    required this.type,
    this.title,
    this.sellerName,
    this.price,
    this.rating,
    this.imageUrl,
    this.name,
    this.role,
    this.avatarUrl,
  });

  factory FavoriteItemModel.product({
    required String id,
    required String title,
    required String sellerName,
    required double price,
    required double rating,
    required String imageUrl,
  }) {
    return FavoriteItemModel(
      id: id,
      type: FavoriteType.product,
      title: title,
      sellerName: sellerName,
      price: price,
      rating: rating,
      imageUrl: imageUrl,
    );
  }

  factory FavoriteItemModel.account({
    required String id,
    required String name,
    required String role,
    required double rating,
    String? avatarUrl,
  }) {
    return FavoriteItemModel(
      id: id,
      type: FavoriteType.account,
      name: name,
      role: role,
      rating: rating,
      avatarUrl: avatarUrl,
    );
  }
}
