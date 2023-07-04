import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_all_apis_riverpod/Model_class/getallproducts.dart';
import 'package:get_all_apis_riverpod/River_pod/state_provider.dart';

import '../River_pod/provider_get_all_products.dart';

class MyHomePage extends ConsumerWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
final postState = ref.watch(getApiNotifierProvider);
return Scaffold(appBar: AppBar(title: const Text('AppBar'),),
  body: Builder(
    builder: (context) {
      if (postState is PostInitialState) {
        return const InitialStateWidget();
      } else if (postState is PostLoadingState) {
        return const LoadingStateWidget();
      } else if (postState is PostLoadedState) {
        return LoadedStateWidget(listOfPost: postState.list);
      } else {
        return ErrorStateWidget(
            errorMessage: (postState as PostErrorState).message);
      }
    },
  ),
);
  }
}


class InitialStateWidget extends ConsumerWidget {
  const InitialStateWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton(
              onPressed: () {
                ref.read(getApiNotifierProvider.notifier).fetchDataS();
              },
              child: const Text('Load to data'))

        ],
      ),
    );
  }
}

class LoadingStateWidget extends ConsumerWidget {
  const LoadingStateWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Center(
      child: CircularProgressIndicator(
        color: Colors.amber,
      ),
    );
  }
}

class LoadedStateWidget extends ConsumerWidget {
  const LoadedStateWidget({super.key, required this.listOfPost});

  final List<GetProduct> listOfPost;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return ListView.builder(
      itemCount: listOfPost.length,
      itemBuilder: (context, index) {
        return
           Row(

              children: [Text(listOfPost[index].id.toString()),
               const Spacer(),
                Text(listOfPost[index].title.toString()),
               // const Spacer(),
                Text(listOfPost[index].userId.toString()),
               // const Spacer(),
                Text(listOfPost[index].id.toString()),
               // const Spacer(),
                Text(listOfPost[index].title.toString()),

              ],


        );
      },
    );
  }
}

class ErrorStateWidget extends ConsumerWidget {
  const ErrorStateWidget({super.key, required this.errorMessage});

  final String errorMessage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Container(
        color: Colors.red,
        child: Text(errorMessage),
      ),
    );
  }
}
