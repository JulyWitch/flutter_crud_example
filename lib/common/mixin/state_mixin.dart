// 🐦 Flutter imports:
import 'package:flutter/material.dart';

enum ViewStatus { initializing, loading, loaded, error }

typedef StateWidgetBuilder<T> = Widget Function(T? state, String? message);
typedef MessageWidgetBuilder<T> = Widget Function(String? message);

/// A mixin to add state to [ChangeNotifier]
/// ### Usage
/// 1. Find the correct state
/// 2. Pass state type to [ChangeNotifier]
/// 3. In the [ChangeNotifier],
///  update the state using changeState method.
/// 4. In your UI, call controller.buildState to use the state
mixin StateMixin<T> on ChangeNotifier {
  ViewStatus viewStatus = ViewStatus.initializing;

  T? _state;

  T? get state => _state;

  String? _stateMessage;

  void changeState(T? state, {ViewStatus? viewStatus, String? message}) {
    _state = state;
    _stateMessage = message;
    this.viewStatus = viewStatus ?? this.viewStatus;

    notifyListeners();
  }

  Widget buildState({
    required StateWidgetBuilder<T> onLoaded,
    MessageWidgetBuilder? onLoading,
    MessageWidgetBuilder? onInitializing,
    MessageWidgetBuilder? onError,
  }) {
    onLoading ??= (stateMessage) =>
        const Center(child: CircularProgressIndicator.adaptive());

    if (viewStatus == ViewStatus.loaded) {
      return onLoaded(_state, _stateMessage);
    }

    if (viewStatus == ViewStatus.error) {
      return onError?.call(_stateMessage) ??
          const Center(child: Text('خطا در دریافت اطلاعات'));
    }

    if (viewStatus == ViewStatus.initializing) {
      return onInitializing?.call(_stateMessage) ??
          onLoading.call(_stateMessage);
    }

    return onLoading.call(_stateMessage);
  }
}
