import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatBar extends StatelessWidget {
  final List<double> expenses;
  ChatBar(this.expenses);

  @override
  Widget build(BuildContext context) {
    double mostExpensive = 0.0;
    expenses.forEach((double price) {
      if (price > mostExpensive) {
        mostExpensive = price;
      }
    });

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text("Weekly Spending",
              style: GoogleFonts.ubuntu(
                textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2),
              )),
          SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.arrow_back),
                iconSize: 30,
              ),
              Text("May 6, 2022 - May 12, 2022",
                  style: GoogleFonts.ubuntu(
                    textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  )),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.arrow_forward),
                iconSize: 30,
              )
            ],
          ),
          SizedBox(
            height: 4,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Bar(
                  label: "Sun",
                  spendAmount: expenses[0],
                  mostExpensive: mostExpensive),
              Bar(
                  label: "Mon",
                  spendAmount: expenses[1],
                  mostExpensive: mostExpensive),
              Bar(
                  label: "Tue",
                  spendAmount: expenses[2],
                  mostExpensive: mostExpensive),
              Bar(
                  label: "Wed",
                  spendAmount: expenses[3],
                  mostExpensive: mostExpensive),
              Bar(
                  label: "Thu",
                  spendAmount: expenses[4],
                  mostExpensive: mostExpensive),
              Bar(
                  label: "Fri",
                  spendAmount: expenses[5],
                  mostExpensive: mostExpensive),
              Bar(
                  label: "Sat",
                  spendAmount: expenses[6],
                  mostExpensive: mostExpensive),
            ],
          )
        ],
      ),
    );
  }
}

class Bar extends StatelessWidget {
  final String label;
  final double spendAmount;
  final double mostExpensive;

  final double _maxBarHeight = 150;

  Bar(
      {required this.label,
      required this.spendAmount,
      required this.mostExpensive});

  @override
  Widget build(BuildContext context) {
    final double barHeight = spendAmount / mostExpensive * _maxBarHeight;
    return Column(
      children: [
        Text("\$${barHeight.toStringAsFixed(2)}",
            style: GoogleFonts.ubuntu(
              textStyle: TextStyle(fontWeight: FontWeight.w600),
            )),
        SizedBox(height: 4),
        Container(
          height: barHeight,
          width: 16,
          decoration: BoxDecoration(
              color: Colors.green, borderRadius: BorderRadius.circular(6)),
        ),
        SizedBox(height: 5),
        Text(label,
            style: GoogleFonts.ubuntu(
              textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ))
      ],
    );
  }
}
