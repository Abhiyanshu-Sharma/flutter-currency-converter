import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CurrencyService {
  Future<double?> fetchExchangeRate(
    String fromcurrency,
    String tocurrency,
  ) async {
    try {
      final url = Uri.parse('https://open.er-api.com/v6/latest/$fromcurrency');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        final Map<String, dynamic> rates =
            data['rates'] as Map<String, dynamic>;

        if (!rates.containsKey(tocurrency)) {
          throw Exception("Currency not found.");
        }

        return (rates[tocurrency] as num).toDouble();
      } else {
        throw Exception("Failed to Load: Status code: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("Error in Fetching data: $e");
      return null;
    }
  }
}
