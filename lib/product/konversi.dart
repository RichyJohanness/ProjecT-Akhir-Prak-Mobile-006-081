import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const primaryColor = Color(0xff254252);
const backgroundColor = Color(0xfff2f5f8);
const accentColor = Color(0xff4caf50);

class CurrencyConversionPage extends StatefulWidget {
  final double totalPrice;

  const CurrencyConversionPage({Key? key, required this.totalPrice}) : super(key: key);

  @override
  _CurrencyConversionPageState createState() => _CurrencyConversionPageState();
}

class _CurrencyConversionPageState extends State<CurrencyConversionPage> {
  late double convertedPriceIDR;
  late double convertedPriceMYR;
  late double convertedPriceJPY;

  String? activeConversion;
  String? convertedTime;

  @override
  void initState() {
    super.initState();
    // Menghitung konversi mata uang saat inisialisasi state
    convertedPriceIDR = widget.totalPrice * 14250;
    convertedPriceMYR = widget.totalPrice * 4.4;
    convertedPriceJPY = widget.totalPrice * 110;
  }

  String _convertTimeTo(String timezone) {
    final easternTime = DateTime.utc(2023, 1, 1, 5, 0); // 12 AM US ET = 5 AM UTC
    late DateTime converted;
    if (timezone == 'WIB') {
      converted = easternTime.add(Duration(hours: 7)); // UTC+7
    } else if (timezone == 'WITA') {
      converted = easternTime.add(Duration(hours: 8)); // UTC+8
    } else if (timezone == 'WIT') {
      converted = easternTime.add(Duration(hours: 9)); // UTC+9
    }
    return DateFormat('HH:mm').format(converted);
  }

  void _onConvertButtonPressed(String timezone) {
    setState(() {
      if (activeConversion == timezone) {
        activeConversion = null;
        convertedTime = null;
      } else {
        activeConversion = timezone;
        convertedTime = _convertTimeTo(timezone);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(
          'Checkout',
          style: TextStyle(
            fontFamily: 'Raleway',
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.white,
          ),
        ),
        backgroundColor: primaryColor,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: accentColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                'Total dalam USD: \$${widget.totalPrice.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                  fontFamily: 'Raleway',
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: [
                _buildCurrencyConversionButton('IDR', Icons.money, convertedPriceIDR, 'Rp'),
                _buildCurrencyConversionButton('MYR', Icons.attach_money, convertedPriceMYR, 'RM'),
                _buildCurrencyConversionButton('JPY', Icons.monetization_on, convertedPriceJPY, '¥'),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: accentColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  Text(
                    'Diskon untuk Warga Indo From US',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                      fontFamily: 'Raleway',
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Khusus Indonesia, silahkan Checkout di Jam 12.00 AM Waktu US untuk klaim Diskon!! Lihat waktu anda dibawah ini agar tidak kelewatan!!',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: primaryColor,
                      fontFamily: 'Raleway',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: [
                _buildTimeConversionButton('WIB', Icons.access_time, 'WIB'),
                _buildTimeConversionButton('WITA', Icons.access_time, 'WITA'),
                _buildTimeConversionButton('WIT', Icons.access_time, 'WIT'),
              ],
            ),
            if (convertedTime != null) ...[
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: accentColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  'Anda dapat Klaim Diskon di jam $convertedTime $activeConversion',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                    fontFamily: 'Raleway',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildCurrencyConversionButton(String label, IconData icon, double convertedPrice, String currencySymbol) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        padding: EdgeInsets.symmetric(vertical: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 36, color: Colors.white),
          const SizedBox(height: 10),
          Text(
            label,
            style: TextStyle(
              fontSize: 18,
              fontFamily: 'Raleway',
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            '${NumberFormat.currency(locale: 'id', symbol: currencySymbol).format(convertedPrice)}',
            style: TextStyle(
              fontSize: 14,
              fontFamily: 'Raleway',
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildTimeConversionButton(String label, IconData icon, String timezone) {
    return ElevatedButton(
      onPressed: () => _onConvertButtonPressed(timezone),
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        padding: EdgeInsets.symmetric(vertical: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 36, color: Colors.white),
          const SizedBox(height: 10),
          Text(
            label,
            style: TextStyle(
              fontSize: 18,
              fontFamily: 'Raleway',
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
