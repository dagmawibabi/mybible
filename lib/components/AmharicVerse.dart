import 'package:flutter/material.dart';
import 'package:mybible/components/eachVerse.dart';
import 'package:mybible/models/savedVerses.dart';

class AmharicVerse extends StatefulWidget {
  AmharicVerse({
    required Key key,
    required this.index,
    required this.amharicChapter,
    required this.setPreviousEmptyVerse,
    required this.previousEmptyVerse,
    required this.showDifferentVersions,
    required this.selectVerses,
    required this.eachNumberFontSize,
    required this.eachVerseFontSize,
    required this.selectedVerse,
  }) : super(key: key);

  int index;
  dynamic amharicChapter;
  Function setPreviousEmptyVerse;
  int previousEmptyVerse;
  Function showDifferentVersions;
  Function selectVerses;
  List<SavedVerse> selectedVerse;
  double eachVerseFontSize;
  double eachNumberFontSize;
  @override
  State<AmharicVerse> createState() => AmharicVerseState();
}

class AmharicVerseState extends State<AmharicVerse>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    Map<String, dynamic> eachVerse = widget.amharicChapter[widget.index];
    // In case the verse is empty or it's a line break
    if (eachVerse["text"] == "") {
      return Container();
    }
    // this verse is empty but it's number should be displayed together with the next verse
    else if (eachVerse["text"] == "-") {
      if (widget.previousEmptyVerse == 0) {
        // setState(() {
        widget.setPreviousEmptyVerse(eachVerse["ID"]);
        // });
      }
      return Container();
    } else {
      int id = eachVerse["ID"];
      if (widget.previousEmptyVerse != 0) {
        String displayId = widget.previousEmptyVerse < eachVerse["ID"]
            ? "${widget.previousEmptyVerse}-${eachVerse['ID']}"
            : eachVerse["ID"].toString();
        widget.setPreviousEmptyVerse(0);

        eachVerse = {
          "text": eachVerse["text"],
          // "ID": "$previousEmptyVerse-${eachVerse['ID']}",
          "ID": displayId,
          "isMultiVerse": true
        };
      }
      return GestureDetector(
        onTap: () {
          widget.showDifferentVersions(id);
        },
        onLongPress: () {
          widget.selectVerses(id.toString(), eachVerse["text"]);
        },
        child: EachVerse(
          verseData: eachVerse,
          fontSize: widget.eachVerseFontSize,
          eachNumberFontSize: widget.eachNumberFontSize,
          selectedVerse: widget.selectedVerse,
          isIndented: true,
        ),
      );
    }
  }

  @override
  bool get wantKeepAlive => true;
}
