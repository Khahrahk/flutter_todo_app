import 'package:flutter/material.dart';
import 'package:flutter_todo_app/resources/views/components/side_menu.dart';
import 'package:stacked/stacked.dart';

import '../../../app/Models/Theme.dart';

class MultipleThemesView extends StatelessWidget {
  const MultipleThemesView({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return ViewModelBuilder<MultipleThemesViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: const Text('Themes'),
          centerTitle: true,
        ),
        backgroundColor: theme.colorScheme.primary,
        body: themeList(model),
        drawer: sideMenu(context)
      ),
      viewModelBuilder: () => MultipleThemesViewModel(),
    );
  }

  Widget themeList(MultipleThemesViewModel model){
    return Column(
      children: <Widget>[ 
        Center(
          child: Wrap(
            spacing: 5,
            runSpacing: 5,
            alignment: WrapAlignment.start,
            direction: Axis.horizontal,
            children: model.themes.map((themeData) => GestureDetector(
              onTap: () => model.setTheme(themeData),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Container(
                  width: 90,
                  height: 90,
                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: themeData.color
                  ),
                ),
              ),
            )).toList(),
          ),
        ),
      ]
    );
  }
}