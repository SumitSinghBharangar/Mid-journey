// ignore_for_file: file_names, non_constant_identifier_names


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/prompt_bloc.dart';

class PromptScreen extends StatefulWidget {
  const PromptScreen({super.key});

  @override
  State<PromptScreen> createState() => _PromptScreenState();
}

class _PromptScreenState extends State<PromptScreen> {
  TextEditingController controller = TextEditingController();
  final PromptBloc promptBloc = PromptBloc();

  @override
  void initState() {
    promptBloc.add(PromtInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var sh = MediaQuery.of(context).size.height;
    // var sw = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Generate Images🚀',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<PromptBloc, PromptState>(
        bloc: promptBloc,
        listener: (context, state) {},
        builder: (context, state) {
          switch (state.runtimeType) {
            case PromptGeneratingImageLoadState:
              return const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 4,
                ),
              );

            case PromptGeneratingImageErrorState:
              return const Center(
                child: Text("Something went wrong"),
              );

            case PromptGeneratingImageSuccessState:
              final Successstate = state as PromptGeneratingImageSuccessState;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: Container(
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            fit: BoxFit.cover,
                            image: MemoryImage(Successstate.uint8list),
                          )),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        height: sh * 0.25,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: sh * 0.015,
                            ),
                            const Text(
                              'Enter your Prompt',
                              style: TextStyle(
                                  fontSize: 23, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: sh * 0.015,
                            ),
                            TextField(
                              controller: controller,
                              cursorColor: Colors.deepPurple,
                              decoration: InputDecoration(
                                  hintText: "Enter your prompt here  . . . . .",
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.deepPurple),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12))),
                            ),
                            SizedBox(
                              height: sh * 0.015,
                            ),
                            SizedBox(
                              height: sh * 0.07,
                              width: double.maxFinite,
                              child: ElevatedButton.icon(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.deepPurple)),
                                  onPressed: () {
                                    if (controller.text.isNotEmpty) {
                                      promptBloc.add(PromptEnteredEvent(
                                          prompt: controller.text));
                                    }
                                  },
                                  icon: const Icon(Icons.generating_tokens),
                                  label: const Text('Generate')),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );

            default:
              return Container();
          }
        },
      ),
    );
  }
}
