import 'package:flutter/material.dart';

class BankPage extends StatelessWidget {
  const BankPage({super.key});

  final List<Map<String, dynamic>> _banks = const [
    {'name': 'Qpay wallet', 'icon': 'assets/images/qpay.png'},
    {'name': 'Хаан банк', 'icon': 'assets/images/banks/khan.png'},
    {'name': 'ХХБанк', 'icon': 'assets/images/banks/khh.png'},
    {'name': 'М банк', 'icon': 'assets/images/banks/mbank.png'},
    {'name': 'SocialPay', 'icon': 'assets/images/banks/socialpay.png'},
    {'name': 'Хас банк', 'icon': 'assets/images/banks/khas.png'},
    {'name': 'Төрийн банк', 'icon': 'assets/images/banks/turiin.png'},
    {'name': 'Most money', 'icon': 'assets/images/banks/most.png'},
    {'name': 'Богд банк', 'icon': 'assets/images/banks/bogd.png'},
    {'name': 'ТХБанк', 'icon': 'assets/images/banks/tx.png'},
    {'name': 'УХБанк', 'icon': 'assets/images/banks/ux.png'},
    {'name': 'Ариг банк', 'icon': 'assets/images/banks/arig.png'},
    {'name': 'ЧХБанк', 'icon': 'assets/images/banks/chx.png'},
    {'name': 'MonPay', 'icon': 'assets/images/banks/monpay.png'},
    {'name': 'Toki', 'icon': 'assets/images/banks/toki.png'},
    {'name': 'Ard', 'icon': 'assets/images/banks/ard.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leadingWidth: 60,
        leading: Padding(
          padding: const EdgeInsets.only(left: 24),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 20,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey
                ),
                borderRadius: 
                BorderRadius.circular(100)
              ),
              child: Icon(Icons.arrow_back_ios_rounded,
                  size: 20, color: Colors.black),
            ),
            )
          ),
        ),
        title: const Text(
          'Төлбөрийн сонголт',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            width: double.infinity,
            height: 1,
            color: Colors.grey.shade200,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: GridView.builder(
          itemCount: _banks.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 12,
            mainAxisSpacing: 20,
            childAspectRatio: 0.85,
          ),
          itemBuilder: (context, index) {
            final bank = _banks[index];
            return GestureDetector(
              onTap: () {
                // handle bank selection
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 66,
                    height: 66,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade200),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        bank['icon'],
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Icon(
                            Icons.account_balance,
                            color: Color(0xFF0072DB),
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    bank['name'],
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Colors.black87,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}