import 'package:intl/intl.dart';

class DaVinciFormatter{
  static String formatDate(DateTime? date){
    date ??= DateTime.now();
    return DateFormat('dd-MM-yyyy').format(date);
  }

  static String formatCurrency(double amount){
    return NumberFormat.currency(locale: 'es_AR', symbol: '\$', name: 'ARS').format(amount);
  }
  
}