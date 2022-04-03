import 'package:flutter/material.dart';

import 'screen.dart';
import 'library.dart';


class GamePage extends StatefulWidget {
  GamePage(this.level);

  final String level;

  @override
  State<GamePage> createState() => _GamePageState();
}




class _GamePageState extends State<GamePage> {

  PuzzleLibrary _puzzleLibrary = PuzzleLibrary();



  @override
  void initState() {
    super.initState();

    _puzzleLibrary.load('assets/level' + this.widget.level + '.txt').then((value) {
      setState(() {
        loadPuzzle();
      });
    });
  }


  void loadPuzzle()
  {
    if (_puzzleLibrary.isReady) {
      _puzzle = _puzzleLibrary.next();
    }

//    _question = '_43___4_1_______	2431314213244213';
//    _question = _question.replaceAll('_', ' ');
//    int.parse(source)
    reset();
  }

  String _puzzle = '';
  List<String> _value = [];
  //String _question = '';
  int _current = 0;

  /// 生成空白棋局
  ///
  void reset() {
    setState(() {
      _value.clear();
      for (int i = 0; i < 16; ++i) {
        _value.add(_puzzle[i]);
      }
    });
  }

  bool check() {
    for (int i = 0; i < 16; ++i) {
      if (_value[i] != _puzzle[17 + i]) {
        return false;
      }
    }

    return true;
  }




  // Widget buildGameBoard() {
  //
  // }



  /// 数独的 4 * 4 格子
  ///
  List<Widget> buildBlocks() {
    List<Widget> blocks = [];

    for (int i = 0; i < 16; ++i) {
      blocks.add(
          Padding(padding: EdgeInsets.all(3), child:
            SizedBox(height: double.infinity, width: double.infinity,child:
              Container(color: (_puzzle[i] != '_') ? Colors.grey : Colors.white, child:
                TextButton(child:
                  Text(_value[i], textScaleFactor: 4, style: TextStyle(color: Colors.black),),
                  /// 选择了数字之后点击block为设值
                  onPressed: (_puzzle[i] != '_') ? null : _current == 0 ? null : () {
                    setState(() {
                      _value[i] = _current.toString();
                    });
                  },
                  /// 长按为清空内容
                  onLongPress: (_puzzle[i] != '_') ? null : _current == 0 ? null : () {
                    setState(() {
                      _value[i] = '_';
                    });
                  },
                ),
              )
            )
          )
      );
    }

    return blocks;
  }


  /// 选择数字的按钮
  ///
  List<Widget> buildButtons() {
    List<Widget> buttons = [];
    for (int i = 1; i <= 4 ; ++i) {
      buttons.add(
          Padding(padding: EdgeInsets.all(3), child:
            SizedBox(height: double.infinity, width: double.infinity,child:
              Container(color: _current == i ? Colors.pink : Colors.grey, child:
                TextButton(child:
                  Text(i.toString(), textScaleFactor: 4, style: TextStyle(color: Colors.black),),
                  onPressed: () {
                    setState(() {
                      _current = i;
                    });
                  },
                )
              )
            )
          )
      );
    }

    return buttons;
  }


  Widget buildControl(BuildContext context) {
    return Center(child: Row(children: [
            // 黄色按钮 RESET
            Container(color: Colors.yellow, child:
              TextButton(child: Text('重新开始', textScaleFactor: 2, style: TextStyle(color: Colors.black),),
                onPressed: reset,)
            ),
            // 绿色按钮 OK
            Expanded(child: Container(color: Colors.green, child:
              TextButton(child: Text('交卷', textScaleFactor: 2, style: TextStyle(color: Colors.black),),
                onPressed: () {
                  if (check()) {
                    showDialog(context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Text("答案正确！太棒啦！"),
                          actions: [
                            TextButton(child: Text(r'下一题'),
                              onPressed: () {
                                Navigator.pop(context);
                                loadPuzzle();
                            })
                          ],
                        );
                      }
                    );
                  }
                  else {
                    showDialog(context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Text("错啦错啦！"),
                          actions: [
                            TextButton(child: Text(r'继续答题'),
                              onPressed: () => Navigator.pop(context))
                          ],
                        );
                      }
                    );
                  }
                },
              )
            )),
            Container(color: Colors.blue, child:
              TextButton(child: Text('下一题', textScaleFactor: 2, style: TextStyle(color: Colors.black),),
                onPressed: () {
                  showDialog(context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Text("真的要重新开始一局吗？"),
                          actions: [
                            TextButton(child: Text(r'继续本局'),
                                onPressed: () => Navigator.pop(context)),
                            TextButton(child: Text(r'重新开局'),
                                onPressed: () {
                                  Navigator.pop(context);
                                  loadPuzzle();
                                })
                          ],
                        );
                      }
                  );
                }
              )),
    ]));

  }

  @override
  Widget build(BuildContext context) {
    ScreenFit screen = ScreenFit(context);

    if (_puzzleLibrary.isReady) {

      return Scaffold(
        appBar: AppBar(
          title: Text('Mia的小数独 第' + widget.level + '级'),
        ),
        body: Center(
          widthFactor: 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(width: double.infinity, height: 400, child:
              Container(color: Colors.black12, child:
              GridView.count(crossAxisCount: 4, childAspectRatio: 1, children: buildBlocks()),
              )
              ),

              const SizedBox(height: 20, width: 1,),
              SizedBox(width: double.infinity, height: 120, child:
              GridView.count(crossAxisCount: 4, childAspectRatio: 1, children: buildButtons(),),
              ),
              const SizedBox(height: 20, width: 1,),
              buildControl(context)
            ],
          ),
        ),
      );
    }
    else {



      return Scaffold(
        appBar: AppBar(
        ),
        body: Center(child: Text(
          '正在加载题库，请稍候'
        )
        ),
      );

    }
  }
}
