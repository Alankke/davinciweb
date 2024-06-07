import 'package:cloud_firestore/cloud_firestore.dart';

class SaleModel{
  //Aca State puede ser Cancelado, Pendiente, Abonado(retirado).
  String userId;
  String paymentMethod;
  String state;
  String generatedCode;
  List<Map<String, dynamic>> products;
  double totalAmount;
  Timestamp timestamp;

  SaleModel({
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
        userId: data['UserId'] ?? '',
        paymentMethod: data['PaymentMethod'] ?? '',
        state: data['State'] ?? '',
        generatedCode: data['GeneratedCode'] ?? '',
        products: List<Map<String, dynamic>>.from(data['Products']),
        totalAmount: data['TotalAmount'] ?? '',
        timestamp: data['Timestamp'] ?? Timestamp.now()
      );
    } else {
      return SaleModel.emptySale();
    }
  }

  factory SaleModel.fromMap(Map<String, dynamic> map) {
    return SaleModel(
      userId: map['UserId'],
      paymentMethod: map['PaymentMethod'],
      state: map['State'],
      generatedCode: map['GeneratedCode'],
      products: List<Map<String, dynamic>>.from(map['Products']),
      totalAmount: map['TotalAmount'],
      timestamp: map['Timestamp'],
    );
  }
}