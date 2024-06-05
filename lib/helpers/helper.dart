

class Helper {
  const Helper();

  futureAwait(void Function() T, { int duration = 1000 }) async {
    await Future.delayed(Duration(milliseconds: duration), T);
  }

}
