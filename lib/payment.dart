import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:test_db/constants.dart';
import 'package:test_db/customWidgets.dart';
import 'package:test_db/database.dart';
import 'package:test_db/User.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:test_db/loading_screen.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PaymentScreen(
        packageID: "2",
        bill: 199.99,
      ),
    ),
  );
}

class PaymentScreen extends StatefulWidget {
  final double bill;
  final String packageID;

  const PaymentScreen({super.key, required this.packageID, required this.bill});

  @override
  State<PaymentScreen> createState() =>
      _PackageSummaryState(packageID: packageID, bill: bill);
}

class _PackageSummaryState extends State<PaymentScreen> {
  String packageID;
  double bill;
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;

  OutlineInputBorder? border;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  _PackageSummaryState({required this.packageID, required this.bill});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              CreditCardWidget(
                cardBgColor: Color(0xFF015766),
                cardNumber: cardNumber,
                expiryDate: expiryDate,
                cardHolderName: cardHolderName,
                cvvCode: cvvCode,
                showBackView:
                    isCvvFocused, //true when you want to show cvv(back) view
                onCreditCardWidgetChange: (CreditCardBrand) {},
                obscureCardNumber: false,
                obscureCardCvv: false,
                isHolderNameVisible: true,
              ),
              CreditCardForm(
                formKey: formKey,
                obscureCvv: true,
                cardNumber: cardNumber,
                cvvCode: cvvCode,
                isHolderNameVisible: true,
                isCardNumberVisible: true,
                isExpiryDateVisible: true,
                cardHolderName: cardHolderName,
                expiryDate: expiryDate,
                themeColor: kPrimaryColor,
                textColor: Colors.black,
                cardNumberDecoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Card Number',
                  hintText: 'XXXX XXXX XXXX XXXX',
                  hintStyle: kCaptionTextStyle,
                  labelStyle: kCaptionTextStyle,
                  focusedBorder: border,
                  enabledBorder: border,
                ),
                expiryDateDecoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintStyle: kCaptionTextStyle,
                  labelStyle: kCaptionTextStyle,
                  focusedBorder: border,
                  enabledBorder: border,
                  labelText: 'Expired Date',
                  hintText: 'XX/XX',
                ),
                cvvCodeDecoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintStyle: kCaptionTextStyle,
                  labelStyle: kCaptionTextStyle,
                  focusedBorder: border,
                  enabledBorder: border,
                  labelText: 'CVV',
                  hintText: 'XXX',
                ),
                cardHolderDecoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintStyle: kCaptionTextStyle,
                  labelStyle: kCaptionTextStyle,
                  focusedBorder: border,
                  enabledBorder: border,
                  labelText: 'Card Holder Name',
                ),
                onCreditCardModelChange: (CreditCardModel? creditCardModel) {
                  setState(() {
                    cardNumber = creditCardModel!.cardNumber;
                    expiryDate = creditCardModel.expiryDate;
                    cardHolderName = creditCardModel.cardHolderName;
                    cvvCode = creditCardModel.cvvCode;
                    isCvvFocused = creditCardModel.isCvvFocused;
                  });
                },
              ),
              Text(
                "Total BIll: $bill SAR",
                style: kHeading1TextStyle,
              ),
              CustomBigButton(
                  label: "Pay",
                  onPressed: () {
                    print(cardNumber);
                    print(expiryDate);
                    print(cardHolderName);
                    print(cvvCode);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoadingTransaction(),
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
