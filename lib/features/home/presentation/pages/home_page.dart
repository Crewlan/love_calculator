import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:love_calculator/core/utils/app_colors.dart';

import '../../../../core/locale/custom_localization.dart';
import '../../../../injection_container.dart';
import '../../../../main.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController fNameController = TextEditingController();
  final TextEditingController sNameController = TextEditingController();
  final _homeBloc = sl<HomeBloc>();

  @override
  void dispose() {
    sNameController.clear();
    fNameController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) => _builderScreen(state),
        ),
      ),
    );
  }

  Widget _builderScreen(HomeState state) {
    switch (state.status) {
      case HomeStatus.loading:
        return _loading(state);
      case HomeStatus.ready:
        return _ready(state);
      case HomeStatus.error:
        return Text(state.message!);
    }
  }

  Widget _loading(HomeState state) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 50),
          _buildLocale(context),
          const SizedBox(height: 30),
          TextField(
            controller: fNameController,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: CustomLocalization.of(context).translate('first_name'),
              labelStyle: GoogleFonts.poppins(color: AppColors.redLightest),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.redLightest,
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          TextField(
            controller: sNameController,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: CustomLocalization.of(context).translate('second_name'),
              labelStyle: GoogleFonts.poppins(color: AppColors.redLightest),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.redLightest,
                ),
              ),
            ),
            cursorColor: AppColors.redLightest,
          ),
          const SizedBox(height: 30),
          TextButton(
            onPressed: () => onPressedButton(),
            child: Text(
              CustomLocalization.of(context).translate('check_compatibility'),
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: AppColors.redLightest,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _ready(HomeState state) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
        image: DecorationImage(
          alignment: Alignment.bottomCenter,
          image: NetworkImage('https://i.pinimg.com/originals/c7/61/b8/c761b801b219a6c6d0a9f3281f51f582.gif'),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30),
          _buildLocale(context),
          const SizedBox(height: 30),
          Text(
            CustomLocalization.of(context).translate('result'),
            style: GoogleFonts.poppins(fontSize: 26),
          ),
          const SizedBox(height: 30),
          Visibility(
            visible: App.of(context)!.getLocale() == const Locale('pt', 'BR'),
            child: Text(
              '${CustomLocalization.of(context).translate('compatibility')} ${state.result!.fName} ${CustomLocalization.of(context).translate('and')} ${state.result!.sName} ${CustomLocalization.of(context).translate('and_is')} ${state.result!.percentage}${CustomLocalization.of(context).translate('percentage')}',
              style: GoogleFonts.poppins(fontSize: 20),
            ),
          ),
          Visibility(
            visible: App.of(context)!.getLocale() == const Locale('en', 'US'),
            child: Text(
              ' ${state.result!.fName} ${CustomLocalization.of(context).translate('and')} ${state.result!.sName} ${CustomLocalization.of(context).translate('compatibility')} ${state.result!.percentage}${CustomLocalization.of(context).translate('percentage')}',
              style: GoogleFonts.poppins(fontSize: 20),
            ),
          ),
          const SizedBox(height: 30),
          Text(
            state.result!.result!,
            style: GoogleFonts.poppins(fontSize: 16),
          ),
          const SizedBox(height: 30),
          TextField(
            controller: fNameController,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: CustomLocalization.of(context).translate('first_name'),
              labelStyle: GoogleFonts.poppins(fontSize: 14, color: AppColors.redLightest),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.redLightest,
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          TextField(
            controller: sNameController,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: CustomLocalization.of(context).translate('second_name'),
              labelStyle: GoogleFonts.poppins(fontSize: 14, color: AppColors.redLightest),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.redLightest,
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          Center(
            child: TextButton(
              onPressed: () => onPressedButton(),
              child: Text(
                CustomLocalization.of(context).translate('check_compatibility'),
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: AppColors.redLightest,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocale(BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            child: Text(
              'PT',
              style: GoogleFonts.poppins(
                  color:
                      App.of(context)!.getLocale() == const Locale('pt', 'BR') ? AppColors.blueLight : AppColors.black),
            ),
            onTap: () => App.of(context)!.setLocale(
              const Locale('pt', 'BR'),
            ),
          ),
          const SizedBox(width: 20),
          GestureDetector(
            child: Text(
              'EN',
              style: GoogleFonts.poppins(
                  color:
                      App.of(context)!.getLocale() == const Locale('en', 'US') ? AppColors.blueLight : AppColors.black),
            ),
            onTap: () => App.of(context)!.setLocale(
              const Locale('en', 'US'),
            ),
          ),
        ],
      ),
    );
  }

  void onPressedButton() {
    sNameController.text == '' ||
            fNameController.text == '' ||
            sNameController.text.isEmpty ||
            fNameController.text.isEmpty
        ? Flushbar(
            title: CustomLocalization.of(context).translate('check_text'),
            message: CustomLocalization.of(context).translate('check_details'),
            flushbarStyle: FlushbarStyle.FLOATING,
            flushbarPosition: FlushbarPosition.TOP,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            duration: const Duration(seconds: 2),
            backgroundColor: AppColors.blueLight,
          ).show(context)
        : _homeBloc.add(LoadResult(fName: fNameController.text, sName: sNameController.text));
  }
}
