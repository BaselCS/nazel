import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/theme/app_dimens.dart';
import 'core/theme/app_theme.dart';
import 'l10n/app_localizations.dart';
import 'presentation/screens/home_screen.dart';

final ValueNotifier<Locale> appLocaleNotifier =
    ValueNotifier<Locale>(const Locale('ar'));

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const NazelApp());
}

class NazelApp extends StatelessWidget {
  const NazelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Locale>(
      valueListenable: appLocaleNotifier,
      builder: (context, currentLocale, _) {
        return ScreenUtilInit(
          designSize: const Size(
            NazelDimens.canvasWidth,
            NazelDimens.canvasHeight,
          ),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return MaterialApp(
              title: 'Nazel - Khuzama Touch',
              debugShowCheckedModeBanner: false,
              theme: NazelTheme.lightTheme,
              locale: currentLocale,
              supportedLocales: AppLocalizations.supportedLocales,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              home: child,
            );
          },
          child: const HomeScreen(),
        );
      },
    );
  }
}

