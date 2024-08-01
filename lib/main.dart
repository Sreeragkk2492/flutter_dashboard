import 'package:flutter/material.dart';
import 'package:flutter_dashboard/core/generated/l10n.dart';
import 'package:flutter_dashboard/routes/page.dart';
import 'package:flutter_dashboard/routes/routes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
 
   MyApp({super.key});
 
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
   
   
    return GetMaterialApp(
       supportedLocales: Lang.delegate.supportedLocales,
                localizationsDelegates:  const [
                  Lang.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate, 
                  GlobalCupertinoLocalizations.delegate 
                 
                ],                
      debugShowCheckedModeBanner: false,
  
     getPages: GetPages.routes,
     initialRoute: Routes.LOGIN, 
       
    );
  }
}

