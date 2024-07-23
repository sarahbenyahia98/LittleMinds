// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PdfModel {
  final String pdfName;
  final String userName;
  final String createdAt;
  final String pdfUrl;
  PdfModel({
    required this.pdfName,
    required this.userName,
    required this.createdAt,
    required this.pdfUrl,
  });


  PdfModel copyWith({
    String? pdfName,
    String? userName,
    String? createdAt,
    String? pdfUrl,
  }) {
    return PdfModel(
      pdfName: pdfName ?? this.pdfName,
      userName: userName ?? this.userName,
      createdAt: createdAt ?? this.createdAt,
      pdfUrl: pdfUrl ?? this.pdfUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pdfName': pdfName,
      'userName': userName,
      'createdAt': createdAt,
      'pdfUrl': pdfUrl,
    };
  }

  factory PdfModel.fromMap(Map<String, dynamic> map) {
    return PdfModel(
      pdfName: map['pdfName'] as String,
      userName: map['userName'] as String,
      createdAt: map['createdAt'] as String,
      pdfUrl: map['pdfUrl'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PdfModel.fromJson(String source) => PdfModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PdfModel(pdfName: $pdfName, userName: $userName, createdAt: $createdAt, pdfUrl: $pdfUrl)';
  }

  @override
  bool operator ==(covariant PdfModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.pdfName == pdfName &&
      other.userName == userName &&
      other.createdAt == createdAt &&
      other.pdfUrl == pdfUrl;
  }

  @override
  int get hashCode {
    return pdfName.hashCode ^
      userName.hashCode ^
      createdAt.hashCode ^
      pdfUrl.hashCode;
  }
}
