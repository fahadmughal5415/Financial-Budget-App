import 'package:budget_app/data/data.dart';
import 'package:budget_app/helper/helper_color.dart';
import 'package:budget_app/models/category_model.dart';
import 'package:budget_app/models/expense_model.dart';
import 'package:budget_app/screens/category_screen.dart';
import 'package:budget_app/widgets/bar_chat.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: Colors.green,
          expandedHeight: 60,
          forceElevated: true,
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(
              "Simple Budget",
              style: GoogleFonts.ubuntu(),
            ),
            centerTitle: true,
          ),
          leading: IconButton(
            onPressed: () {},
            icon: Icon(Icons.settings),
            iconSize: 30,
            color: Colors.white,
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(Icons.add),
                iconSize: 30,
                color: Colors.white)
          ],
        ),
        SliverList(
          delegate:
              SliverChildBuilderDelegate((BuildContext context, int index) {
            if (index == 0) {
              return Container(
                //  height: 100,
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black45,
                        blurRadius: 6,
                        offset: Offset(0, 2))
                  ],
                ),
                child: ChatBar(weeklySpending),
              );
            } else {
              final Category category = catergories[index - 1];
              double totalAmountSpent = 0.0;
              category.expenses.forEach((Expense expense) {
                totalAmountSpent += expense.cost;
              });
              return _buildCategories(category, totalAmountSpent);
            }
          }, childCount: 1 + catergories.length),
        ),
      ],
    ));
  }

  Widget _buildCategories(Category category, double totalAmountSpent) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CategoryScreen(category),
        ),
      ),
      child: Container(
        margin: EdgeInsets.all(8),
        //color: Colors.red,
        height: 100,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.black45, blurRadius: 6.0, offset: Offset(0, 2))
            ]),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    category.name,
                    style: GoogleFonts.ubuntu(
                        textStyle: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600)),
                  ),
                  Text(
                    "\$${(category.maxAmount - totalAmountSpent).toStringAsFixed(2)} / \$${category.maxAmount.toStringAsFixed(2)}",
                    style: GoogleFonts.ubuntu(
                      textStyle:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                  )
                ],
              ),
              SizedBox(height: 10),
              LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                final double maxBarWidth = constraints.maxWidth;
                final percent = (category.maxAmount - totalAmountSpent) /
                    category.maxAmount;
                double barWidth = percent * maxBarWidth;

                if (barWidth < 0) {
                  barWidth = 0;
                }
                return Stack(
                  children: [
                    Container(
                        height: 20,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(15))),
                    Container(
                        height: 20,
                        width: barWidth,
                        decoration: BoxDecoration(
                            color: getColor(context, percent),
                            borderRadius: BorderRadius.circular(15))),
                  ],
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
