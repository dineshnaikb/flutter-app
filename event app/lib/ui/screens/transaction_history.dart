import 'dart:developer';

import 'package:events/core/app_theme.dart';
import 'package:events/logic/cubit/transactions_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../model/transaction_model.dart';

class TransactionHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).backgroundColor,
          iconTheme: IconThemeData(color: Theme.of(context).appBarIconColor),
          elevation: 0,
          title: Image.asset(
            Theme.of(context).logo,
            width: 22.0.w,
          ),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 2.0.h,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 8.0.w),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Transaction History",
                    style: GoogleFonts.raleway(
                        fontSize: 20.0.sp,
                        color: Theme.of(context).textPrimaryColor),
                  ),
                ),
                SizedBox(
                  height: 2.0.h,
                ),
                Flexible(
                  child: BlocBuilder<TransactionsCubit, TransactionsState>(
                    builder: (context, state) {
                      BlocProvider.of<TransactionsCubit>(context)
                          .loadNotifications();
                      if (state is TransactionsLoaded) {
                        DateTime date = DateTime.now();
                        List<TransactionModel> transactions =
                            BlocProvider.of<TransactionsCubit>(context)
                                .listofdata;
                        return ListView.builder(
                            itemCount: transactions.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.symmetric(horizontal: 5.0.w),
                                child: Card(
                                  elevation: 0,
                                  color: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                  child: ListTile(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    contentPadding:
                                        EdgeInsets.symmetric(vertical: 5),
                                    leading: Container(
                                        height: double.infinity,
                                        child: CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              transactions[index].pic!),
                                        )),
                                    title: Text(
                                      transactions[index].tittle!,
                                      style: GoogleFonts.raleway(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    subtitle: Container(
                                        margin: EdgeInsets.only(top: 0.5.h),
                                        child: Text(
                                            transactions[index].date_time!)),
                                    trailing: Container(
                                      width: 12.0.w,
                                      margin: EdgeInsets.only(top: 1.0.h),
                                      alignment: Alignment.topCenter,
                                      child: Text(
                                        "\$${transactions[index].Payment!}",
                                        style: GoogleFonts.raleway(
                                            fontSize: 12.0.sp,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            });
                      }
                      log(BlocProvider.of<TransactionsCubit>(context)
                          .listofdata
                          .length
                          .toString());
                      return Center(child: CircularProgressIndicator());
                    },
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
