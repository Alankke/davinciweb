import 'package:cloud_firestore/cloud_firestore.dart';

class SaleModel{
  //Aca State puede ser Cancelado, Pendiente, Abonado(retirado).
  final String id;
  String userId;
  String paymentMethod;
  String state;
  String generatedCode;
  List<Map<String, dynamic>> products;
  double totalAmount;
  Timestamp timestamp;

  SaleModel({
    required this.id,
    required this.userId,
    required this.paymentMethod,
    required this.state,
    required this.generatedCode,
    required this.products,
    required this.totalAmount,
    required this.timestamp
    });

  Map<String, dynamic> toJson() {
    return {
      'UserId': userId,
      'PaymentMethod': paymentMethod,
      'State': state,
      'GeneratedCode': generatedCode,
      'Products': products,
      'TotalAmount': totalAmount,
      'Timestamp': timestamp
    };
  }

  static SaleModel emptySale() => SaleModel(
    id: '',
    userId: '',
    paymentMethod: '',
    state: '',
    generatedCode: '',
    products: [],
    totalAmount: 0,
    timestamp: Timestamp.now(),
  );

    factory SaleModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    if (document.data() != null) {
      return SaleModel(
        id: document.id,
        userId: data['UserId'] ?? '',
        paymentMethod: data['Payment Method'] ?? '',
        state: data['State'] ?? '',
        generatedCode: data['Code'] ?? '',
        products: List<Map<String, dynamic>>.from(data['Products'] ?? []),
        totalAmount: (data['Total Amount'] ?? 0).toDouble(),
        timestamp: data['Timestamp'] ?? Timestamp.now(),
      );
    } else {
      return SaleModel.emptySale();
    }
  }

  factory SaleModel.fromJson(Map<String, dynamic> json) {
    return SaleModel(
      id: json['id'],
      userId: json['UserId'],
      paymentMethod: json['PaymentMethod'],
      state: json['State'],
      generatedCode: json['GeneratedCode'],
      products: List<Map<String, dynamic>>.from(json['Products']),
      totalAmount: json['TotalAmount'],
      timestamp: json['Timestamp'],
    );
  }
}