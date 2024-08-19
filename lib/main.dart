import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gen_ai_trial/di/injectable.dart';
import 'package:gen_ai_trial/features/chat/cubit/chat_cubit.dart';
import 'package:gen_ai_trial/features/chat/models/message.dart';
import 'package:gen_ai_trial/features/chat/ui/chat_screen.dart';
import 'package:gen_ai_trial/features/file_picker/blocs/pick_files_cubit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => PickFilesCubit(filePickerHelper: getIt()),
          ),
          BlocProvider(
            create: (_) => ChatCubit(chat: getIt()),
          )
        ],
        child: const MyHomePage(title: 'Google AI testing'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _promptController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _promptController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Flexible(
              child: BlocBuilder<ChatCubit, ChatState>(
                builder: (context, state) => state.maybeWhen(
                  initial: () => const Center(
                    child: Text('Ask a Prompt to get started'),
                  ),
                  error: (message) => Center(
                    child: Text('an Error occurred there: $message'),
                  ),
                  loaded: (history) => ChatScreen(chatHistory: history),
                  loading: (history) => ChatScreen(chatHistory: history),
                  orElse: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
            ),
            TextFormField(
              controller: _promptController,
              maxLines: 10,
              minLines: 1,
              textInputAction: TextInputAction.newline,
              decoration: InputDecoration(
                hintText: 'Enter your prompt',
                suffixIcon: BlocBuilder<ChatCubit, ChatState>(
                  builder: (context, state) => state.maybeWhen(
                      orElse: () => IconButton(
                            onPressed: () {
                              context.read<ChatCubit>().sendMessage(
                                    Message(
                                        text: _promptController.text,
                                        fromUser: true),
                                  );
                              _promptController.clear();
                            },
                            icon: const Icon(Icons.send),
                          ),
                      loading: (history) => const CircularProgressIndicator()),
                ),
                prefixIcon: IconButton(
                  onPressed: () => context.read<PickFilesCubit>().pickFiles(),
                  icon: const Icon(Icons.attach_file),
                ),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
