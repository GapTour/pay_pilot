import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:go_router/go_router.dart';
import 'package:pay_pilot/core/data/params/event_story_params.dart';
import 'package:pay_pilot/core/l10n/generated/l10n.dart';
import 'package:pay_pilot/core/widgets/app_delete_dialog.dart';
import 'package:pay_pilot/features/event_details/data/models/response_event_story.dart';

class EventStoryScreen extends StatefulWidget {
  static const routeName = '/story';
  const EventStoryScreen({super.key});

  @override
  State<EventStoryScreen> createState() => _EventStoryScreenState();
}

class _EventStoryScreenState extends State<EventStoryScreen> {
  final QuillController _controller = QuillController.basic();
  final FocusNode _editorFocusNode = FocusNode();
  final ScrollController _editorScrollController = ScrollController();
  ResponseEventStory? _eventStory;
  late EventStoryParams _storyParams;
  late int _eventID;

  @override
  void initState() {
    super.initState();
    // Load document
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_eventStory == null) return;

      _controller.document = Document.fromJson(
        jsonDecode(_eventStory!.encodedText),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _editorScrollController.dispose();
    _editorFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final arguments = GoRouterState.of(context).extra as Map<String, dynamic>;
    _eventID = arguments['eventID'] as int;
    if (arguments['story'] != null) {
      _eventStory = ResponseEventStory.fromJson(arguments['story'] as String);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.eventStory_appBarTitle),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              _storyParams = EventStoryParams(
                id: _eventStory?.id,
                eventID: _eventID,
                title: _controller.document.getPlainText(0, 10),
                encodedText: jsonEncode(
                  _controller.document.toDelta().toJson(),
                ),
                createAt: _eventStory?.createAt ?? DateTime.now(),
              );
              context.pop({'encoded': _storyParams.toJson()});
            },
            icon: Icon(Icons.save),
          ),
          IconButton(
            onPressed: () {
              AppDeleteDialog.showCustom(
                context,
                onPressed: () {
                  context.pop();
                },
                content: S.current.alertDialog_discardChanges,
              );
            },
            icon: Icon(Icons.cancel_sharp),
          ),
        ],
      ),
      body: Column(
        children: [
          QuillSimpleToolbar(
            controller: _controller,
            config: const QuillSimpleToolbarConfig(
              showFontFamily: false,
              showLink: false,
              showListCheck: false,
              multiRowsDisplay: false,
              showBackgroundColorButton: false,
              showSubscript: false,
              showSuperscript: false,
              color: Colors.white10,
            ),
          ),
          Expanded(
            child: QuillEditor(
              focusNode: _editorFocusNode,
              scrollController: _editorScrollController,
              controller: _controller,
              config: QuillEditorConfig(
                customStyles: DefaultStyles(
                  color: Colors.red,
                  placeHolder: DefaultTextBlockStyle(
                    TextStyle(color: Colors.white38),
                    HorizontalSpacing(0, 0),
                    VerticalSpacing(0, 0),
                    VerticalSpacing(0, 0),
                    BoxDecoration(),
                  ),
                ),
                autoFocus: !kIsWeb,
                placeholder: S.current.eventStory_writeHere,
                padding: EdgeInsets.all(16),
                embedBuilders: [TimeStampEmbedBuilder()],
                showCursor: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TimeStampEmbed extends Embeddable {
  const TimeStampEmbed(String value) : super(timeStampType, value);

  static const String timeStampType = 'timeStamp';

  static TimeStampEmbed fromDocument(Document document) =>
      TimeStampEmbed(jsonEncode(document.toDelta().toJson()));

  Document get document => Document.fromJson(jsonDecode(data));
}

class TimeStampEmbedBuilder extends EmbedBuilder {
  @override
  String get key => 'timeStamp';

  @override
  String toPlainText(Embed node) {
    return node.value.data;
  }

  @override
  Widget build(BuildContext context, EmbedContext embedContext) {
    return Row(
      children: [
        const Icon(Icons.access_time_rounded),
        Text(embedContext.node.value.data as String),
      ],
    );
  }
}
