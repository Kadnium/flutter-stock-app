import 'package:flutter/material.dart';



class AppHeader extends StatelessWidget with PreferredSizeWidget {
  const AppHeader({Key? key}) : super(key: key);
 
  @override
  Widget build(BuildContext context) {
    
    return AppBar(
      iconTheme: Theme.of(context).iconTheme,
      title:const  Center(child: Icon(Icons.bar_chart_sharp,),)
      ,
      // actions: [
      //   IconButton(
      //       onPressed: () {
      //         context.read<AppState>().openDrawer(context);
      //       },
      //       icon: const Icon(Icons.menu))      
      // ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
