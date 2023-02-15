import 'package:equatable/equatable.dart';

class CoffeeImage extends Equatable {
  const CoffeeImage({required this.file});

  factory CoffeeImage.fromJson(Map<String, dynamic> json) =>
      CoffeeImageExtensions.fromJson(json);

  final String file;

  @override
  List<String> get props => [file];
}

extension CoffeeImageExtensions on CoffeeImage {
  Map<String, dynamic> toJson() {
    return {'file': file};
  }

  static CoffeeImage fromJson(Map<String, dynamic> json) {
    return CoffeeImage(file: json['file'] as String);
  }
}
