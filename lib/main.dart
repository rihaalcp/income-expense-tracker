import 'package:exinapp/madel/transaction_model.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(ExpenseTrackerApp());
}

class ExpenseTrackerApp extends StatelessWidget {
  const ExpenseTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker App',
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFF5F7FB),
        fontFamily: 'Poppins',
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<TransactionModel> transactions = [
    TransactionModel(title: "Salary",description: "Monthly Salary", amount: 20000, isIncome: true),
    TransactionModel(title: "Bill",description: "Electricity Bill", amount: 2500, isIncome: false),
    TransactionModel(title: "Shopping",description: "Home Products", amount: 4000, isIncome: false),
  ];
  void addTransaction(
      String title,
      String description,
      double amount,
      bool isIncome
      ) {
    setState(() {
      transactions.add(
        TransactionModel(title: title,description: description, amount: amount, isIncome: isIncome),
      );
    });
  }

  double get totalBalance {
    double balance = 0;
    for (var item in transactions) {
      if (item.isIncome) {
        balance += item.amount;
      } else {
        balance -= item.amount;
      }
    }
    return balance;
  }

  double get totalIncome {
    double income = 0;
    for (var item in transactions) {
      if (item.isIncome) {
        income += item.amount;
      }
    }
    return income;
  }
  double get totalExpense{
    double expense =0;
    for(var item in transactions){
      if(!item.isIncome){
        expense+=item.amount;
      }
    }
    return expense;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Expense Tracker",),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: LinearGradient(
                  colors: [
                  Color(0xFF5B67F1),
                  Color(0xFF7A84FF)
                  ]
                )
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Total Balance",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 34,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text(
                    "₹${totalBalance.toStringAsFixed(0)}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 24,),
            Row(
              children: [
                Expanded(
                  child: buildCard(
                    "INCOME",
                    totalIncome,
                    Colors.green,
                    true
                  ),
                ),
                SizedBox(width: 16,),
                Expanded(
                  child: buildCard(
                    "EXPENSE",
                    totalExpense,
                    Color(0xFF9c2a22),
                    false
                  ),
                )
              ],
            ),
            SizedBox(height: 24,),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Transactions",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            SizedBox(height: 10,),
            Expanded(
              child: ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (context,index){
                  final item = transactions[index];
                  return Container(
                    margin: EdgeInsets.only(bottom: 14),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                          blurRadius: 8
                        )
                      ]
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: item.isIncome
                          ? Colors.green.withOpacity(0.1)
                          : Colors.red.withOpacity(0.1),
                          child: Icon(
                            item.isIncome ? Icons.arrow_downward : Icons.arrow_upward,
                            color: item.isIncome ? Colors.green : Colors.red,
                          ),
                        ),
                        SizedBox(width: 14,),
                        Expanded(
                        child:Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                       Text(
                            item.title,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600
                            ),
                         overflow: TextOverflow.ellipsis,
                          ),

                            SizedBox(height: 4,),
                            Text(
                                  item.description,
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w200,
                                      fontSize: 12
                                  ),
                              overflow: TextOverflow.ellipsis,
                                )

                          ],
                        ),
                  ),
                        Text(
                          "${item.isIncome ? '+' : '-'} ₹${item.amount}",
                          style: TextStyle(
                            color: item.isIncome ? Colors.green : Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 17
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF5B67F1),
        onPressed: (){
          showAddTransactionDialog();
        },
        child: Icon(Icons.add),
      ),
    );
  }
  Widget buildCard(
      String title,
      double amount,
      Color color,
      bool isIncome
      ){
    return Container(
      padding: EdgeInsets.all(18),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8
            ),
          ]
      ),

      child:Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center ,
        children: [
          CircleAvatar(
            backgroundColor: isIncome ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
          child:Icon(
            isIncome ? Icons.arrow_upward : Icons.arrow_downward,
            color: isIncome ? Colors.green : Colors.red
          ),
          ),
          SizedBox(width: 10,),
          Column(
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16),
          ),
          // SizedBox(height: 10),
          Text(
            "₹${amount.toStringAsFixed(0)}",
            style: TextStyle(
                color: color,
                fontSize: 22,
                fontWeight: FontWeight.bold
            ),
          ),

        ],
      ),
    ],
      )
    );
  }
  void showAddTransactionDialog(){
    final titleController = TextEditingController();
    final amountController = TextEditingController();
    final descriptionController =  TextEditingController();
    bool isIncome = false;
    showDialog(
        context: context,
        builder: (context){
          return StatefulBuilder(
              builder: (context,setDialogState){
                return AlertDialog(
                  title: Text("Add Transactions"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: titleController,
                        decoration: InputDecoration(
                          labelText: "Title",
                        ),
                      ),
                      SizedBox(height: 10,),
                      TextField(
                        controller: amountController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Amount",
                        ),
                      ),
                      SizedBox(height: 10,),
                      TextField(
                        controller: descriptionController,
                        decoration: InputDecoration(
                          labelText: "Description"
                        ),
                      ),
                      SizedBox(height: 12,),
                      SwitchListTile(
                        title: Text("Income"),
                        value : isIncome,
                        onChanged: (value){
                          setDialogState((){
                            isIncome = value;
                          });
                        },
                      )
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      child: Text("Cancel"),
                    ),
                    ElevatedButton(
                      onPressed: (){
                        final title = titleController.text;
                        final description = descriptionController.text;
                        final amount = double.tryParse(
                            amountController.text
                        );
                        if(title.isNotEmpty && amount != null){
                          addTransaction(
                              title,
                              description,
                              amount,
                              isIncome
                          );
                          Navigator.pop(context);

                        }
                      },
                      child: Text("Add"),
                    )
                  ],
                );
              }
          );
        }
    );
  }
}
