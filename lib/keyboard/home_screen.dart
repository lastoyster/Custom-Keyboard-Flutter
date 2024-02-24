import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomKeyboard extends StatefulWidget {
  const CustomKeyboard({Key? key}) : super(key: key);

  @override
  _CustomKeyboardState createState() => _CustomKeyboardState();
}

class _CustomKeyboardState extends State<CustomKeyboard> {
  late List<List<dynamic>> keys;
  late String amount;

  @override
  void initState() {
    super.initState();
    keys = [
      ['1', '2', '3'],
      ['4', '5', '6'],
      ['7', '8', '9'],
      [
        '.',
        '0',
        const Icon(
          Icons.backspace,
          color: Colors.black,
        )
      ],
    ];
    amount = '';
  }

  onKeyTap(dynamic val) {
    if (val == '0' && amount.isEmpty) {
      return;
    }
    setState(() {
      amount = amount + val.toString();
    });
  }

  onBackspacePress() {
    if (amount.isEmpty) {
      return;
    }

    setState(() {
      amount = amount.substring(0, amount.length - 1);
    });
  }

  Widget renderKeyboard() {
    return Column(
      children: keys.map((x) {
        return Row(
          children: x.map(
            (y) {
              return Expanded(
                child: KeyboardKey(
                  label: y,
                  onTap: () {
                    if (y is Widget) {
                      onBackspacePress();
                    } else {
                      onKeyTap(y);
                    }
                  },
                ),
              );
            },
          ).toList(),
        );
      }).toList(),
    );
  }

  Widget renderAmount() {
    String display = 'Enter Phone Number';
    TextStyle style = const TextStyle(
      fontSize: 30.0,
      fontWeight: FontWeight.bold,
      color: Colors.grey,
    );

    if (amount.isNotEmpty) {
      // NumberFormat f = NumberFormat('#,###');
      display = amount;
      // display = f.format(int.parse(amount));
      style = style.copyWith(
        color: Colors.black,
      );
    }

    return Expanded(
      child: Center(
        child: Text(
          display,
          style: style,
        ),
      ),
    );
  }

  Widget renderConfirmButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      child: GestureDetector(
        onTap: amount.isNotEmpty ? () {} : null,
        child: Container(
          height: 50.0,
          width: double.infinity,
          decoration: BoxDecoration(
            color: amount.isNotEmpty ? Colors.blue : Colors.grey,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Center(
            child: Text(
              'Submit',
              style: TextStyle(
                color: amount.isNotEmpty ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              renderAmount(),
              renderKeyboard(),
              const SizedBox(
                height: 10,
              ),
              renderConfirmButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class KeyboardKey extends StatelessWidget {
  final dynamic label;
  final Function()? onTap;

  const KeyboardKey({
    Key? key,
    required this.label,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
            width: 0.5,
          ),
        ),
        child: label is Widget ? label : Text(label.toString()),
      ),
    );
  }
}
