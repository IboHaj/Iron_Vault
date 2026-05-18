import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:iron_vault/notifiers/credentials_holder_notifier.dart';
import 'package:iron_vault/utils/utils.dart';
import 'package:iron_vault/views/main_view.dart';
import 'package:iron_vault/widgets/custom_appbar.dart';
import 'package:iron_vault/widgets/custom_snackbar.dart';

class LockscreenView extends StatefulHookConsumerWidget {
  const LockscreenView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LockScreenViewState();
}

class _LockScreenViewState extends ConsumerState<LockscreenView> {
  Future<void> checkPasswordExists() async {
    var credentials = await ref.read(allCredentialsProvider.notifier).getCredentials("App_Lock");
    if (credentials.password == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => MainView()),
          (route) => false,
        );
      });
    }
  }

  @override
  void initState() {
    super.initState();
    checkPasswordExists();
  }

  @override
  Widget build(BuildContext context) {
    var enteredPassword = useState("");
    var locked = useState(true);

    return SafeArea(
        child: Scaffold(
          appBar: CustomAppbar(title: "", bgColor: Theme.of(context).colorScheme.scrim),
          body: Builder(
            builder: (context) {
              return Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                color: Theme.of(context).colorScheme.scrim,
                child: Column(
                  spacing: 10,
                  mainAxisSize: .max,
                  mainAxisAlignment: .center,
                  children: [
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      transitionBuilder: (child, animation) {
                        return FadeTransition(opacity: animation, child: child);
                      },
                      child: Icon(
                        locked.value ? Icons.lock_outline_sharp : Icons.lock_open_sharp,
                        key: ValueKey(locked.value),
                        size: 48,
                        color: Theme.of(context).colorScheme.primaryContainer,
                      ),
                    ),
                    Text("The IRON VAULT", style: Theme.of(context).textTheme.headlineMedium),
                    Text("LOCKED DOWN", style: Theme.of(context).textTheme.displaySmall),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                        mainAxisAlignment: .spaceEvenly,
                        mainAxisSize: .max,
                        crossAxisAlignment: .center,
                        spacing: 20,
                        children: [
                          Expanded(
                            child: Container(
                              height: context.screenHeight * 0.085,
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: enteredPassword.value.isNotEmpty
                                        ? Theme.of(context).colorScheme.primaryContainer
                                        : Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                                color: Theme.of(context).colorScheme.surfaceContainerLow,
                              ),
                              child: enteredPassword.value.isNotEmpty
                                  ? Icon(
                                      Icons.circle,
                                      size: 24,
                                      color: Theme.of(context).colorScheme.primaryContainer,
                                    )
                                  : null,
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: context.screenHeight * 0.085,
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: enteredPassword.value.length > 1
                                        ? Theme.of(context).colorScheme.primaryContainer
                                        : Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                                color: Theme.of(context).colorScheme.surfaceContainerLow,
                              ),
                              child: enteredPassword.value.length > 1
                                  ? Icon(
                                      Icons.circle,
                                      size: 24,
                                      color: Theme.of(context).colorScheme.primaryContainer,
                                    )
                                  : null,
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: context.screenHeight * 0.085,
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: enteredPassword.value.length > 2
                                        ? Theme.of(context).colorScheme.primaryContainer
                                        : Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                                color: Theme.of(context).colorScheme.surfaceContainerLow,
                              ),
                              child: enteredPassword.value.length > 2
                                  ? Icon(
                                      Icons.circle,
                                      size: 24,
                                      color: Theme.of(context).colorScheme.primaryContainer,
                                    )
                                  : null,
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: context.screenHeight * 0.085,
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: enteredPassword.value.length > 3
                                        ? Theme.of(context).colorScheme.primaryContainer
                                        : Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                                color: Theme.of(context).colorScheme.surfaceContainer,
                              ),
                              child: enteredPassword.value.length > 3
                                  ? Icon(
                                      Icons.circle,
                                      size: 24,
                                      color: Theme.of(context).colorScheme.primaryContainer,
                                    )
                                  : null,
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: context.screenHeight * 0.085,
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: enteredPassword.value.length > 4
                                        ? Theme.of(context).colorScheme.primaryContainer
                                        : Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                                color: Theme.of(context).colorScheme.surfaceContainerLow,
                              ),
                              child: enteredPassword.value.length > 4
                                  ? Icon(
                                      Icons.circle,
                                      size: 24,
                                      color: Theme.of(context).colorScheme.primaryContainer,
                                    )
                                  : null,
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: context.screenHeight * 0.085,
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: enteredPassword.value.length > 5
                                        ? Theme.of(context).colorScheme.primaryContainer
                                        : Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                                color: Theme.of(context).colorScheme.surfaceContainerLow,
                              ),
                              child: enteredPassword.value.length > 5
                                  ? Icon(
                                      Icons.circle,
                                      size: 24,
                                      color: Theme.of(context).colorScheme.primaryContainer,
                                    )
                                  : null,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      crossAxisAlignment: .center,
                      mainAxisSize: .max,
                      mainAxisAlignment: .center,
                      spacing: 10,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => enteredPassword.value += "1",
                            child: Container(
                              height: context.screenHeight * 0.08,
                              alignment: .center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: Theme.of(context).colorScheme.surfaceContainer,
                              ),
                              child: Text("1", style: Theme.of(context).textTheme.headlineLarge),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => enteredPassword.value += "2",
                            child: Container(
                              height: context.screenHeight * 0.08,
                              alignment: .center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: Theme.of(context).colorScheme.surfaceContainer,
                              ),
                              child: Text("2", style: Theme.of(context).textTheme.headlineLarge),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => enteredPassword.value += "3",
                            child: Container(
                              height: context.screenHeight * 0.08,
                              alignment: .center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: Theme.of(context).colorScheme.surfaceContainer,
                              ),
                              child: Text("3", style: Theme.of(context).textTheme.headlineLarge),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: .center,
                      mainAxisSize: .max,
                      mainAxisAlignment: .center,
                      spacing: 10,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => enteredPassword.value += "4",
                            child: Container(
                              height: context.screenHeight * 0.08,
                              alignment: .center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: Theme.of(context).colorScheme.surfaceContainer,
                              ),
                              child: Text("4", style: Theme.of(context).textTheme.headlineLarge),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => enteredPassword.value += "5",
                            child: Container(
                              height: context.screenHeight * 0.08,
                              alignment: .center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: Theme.of(context).colorScheme.surfaceContainer,
                              ),
                              child: Text("5", style: Theme.of(context).textTheme.headlineLarge),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => enteredPassword.value += "6",
                            child: Container(
                              height: context.screenHeight * 0.08,
                              alignment: .center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: Theme.of(context).colorScheme.surfaceContainer,
                              ),
                              child: Text("6", style: Theme.of(context).textTheme.headlineLarge),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: .center,
                      mainAxisSize: .max,
                      mainAxisAlignment: .center,
                      spacing: 10,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => enteredPassword.value += "7",
                            child: Container(
                              height: context.screenHeight * 0.08,
                              alignment: .center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: Theme.of(context).colorScheme.surfaceContainer,
                              ),
                              child: Text("7", style: Theme.of(context).textTheme.headlineLarge),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => enteredPassword.value += "8",
                            child: Container(
                              height: context.screenHeight * 0.08,
                              alignment: .center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: Theme.of(context).colorScheme.surfaceContainer,
                              ),
                              child: Text("8", style: Theme.of(context).textTheme.headlineLarge),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => enteredPassword.value += "9",
                            child: Container(
                              height: context.screenHeight * 0.08,
                              alignment: .center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: Theme.of(context).colorScheme.surfaceContainer,
                              ),
                              child: Text("9", style: Theme.of(context).textTheme.headlineLarge),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: .center,
                      mainAxisSize: .max,
                      mainAxisAlignment: .center,
                      spacing: 10,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => enteredPassword.value = enteredPassword.value.substring(
                              0,
                              enteredPassword.value.length - 1,
                            ),
                            child: Container(
                              height: context.screenHeight * 0.08,
                              alignment: .center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: Theme.of(context).colorScheme.scrim,
                              ),
                              child: Icon(
                                Icons.backspace_outlined,
                                color: Theme.of(context).colorScheme.primaryContainer,
                                size: 32,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => enteredPassword.value += "0",
                            child: Container(
                              height: context.screenHeight * 0.08,
                              alignment: .center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: Theme.of(context).colorScheme.surfaceContainer,
                              ),
                              child: Text("0", style: Theme.of(context).textTheme.headlineLarge),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              var holderCredentials = await ref
                                  .read(allCredentialsProvider.notifier)
                                  .getCredentials("App_Lock");
                              if (holderCredentials.password == enteredPassword.value) {
                                locked.value = false;
                                Future.delayed(Duration(milliseconds: 650), () {
                                  if (context.mounted) {
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(builder: (context) => MainView()),
                                      (route) => false,
                                    );
                                  }
                                });
                              } else {
                                if (context.mounted) {
                                  CustomSnackbar.show(context, SnackBarUse.error, "Incorrect Pin!");
                                }
                              }
                            },
                            child: Container(
                              height: context.screenHeight * 0.08,
                              alignment: .center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: Theme.of(context).colorScheme.primaryContainer,
                              ),
                              child: Icon(
                                Icons.arrow_forward_sharp,
                                size: 32,
                                color: Theme.of(context).colorScheme.scrim,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
    );
  }
}
