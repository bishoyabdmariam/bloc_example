import 'package:bloctest/cubit/counter_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            MultiBlocListener(
              listeners: [
                BlocListener<CounterCubit, CounterState>(
                  listener: (context, state) {
                    if (state is CounterIncrement) {
                      showCupertinoDialog(
                        context: (context),
                        builder: (context) => CupertinoAlertDialog(
                          title: const Text("Counter Incremented"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text("OK"),
                            ),
                          ],
                        ),
                      );
                    }
                    if (state is CounterDecrement) {
                      showCupertinoDialog(
                        context: (context),
                        builder: (context) => CupertinoAlertDialog(
                          title: const Text("Counter Decremented"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text("OK"),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  /*child: BlocBuilder<CounterCubit, CounterState>(
                    builder: (context, state) {
                      return Text(
                        counter.toString(),
                        style: Theme.of(context).textTheme.headlineMedium,
                      );
                    },
                  ),*/
                ),
              ],
              child: BlocBuilder<CounterCubit, CounterState>(
                builder: (context, state) {
                  return Text(
                    context.read<CounterCubit>().counter.toString(),
                    style: Theme.of(context).textTheme.headlineMedium,
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () {
                BlocProvider.of<CounterCubit>(context).decrementCounter();
              },
              tooltip: 'Decrement',
              child: const Icon(Icons.remove),
            ),
            const Padding(padding: EdgeInsets.all(20)),
            FloatingActionButton(
              onPressed: () {
                BlocProvider.of<CounterCubit>(context).incrementCounter();
              },
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}
