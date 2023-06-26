#ifndef FLUTTER_PLUGIN_BRICK_LIB_PLUGIN_H_
#define FLUTTER_PLUGIN_BRICK_LIB_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace brick_lib {

class BrickLibPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  BrickLibPlugin();

  virtual ~BrickLibPlugin();

  // Disallow copy and assign.
  BrickLibPlugin(const BrickLibPlugin&) = delete;
  BrickLibPlugin& operator=(const BrickLibPlugin&) = delete;

 private:
  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace brick_lib

#endif  // FLUTTER_PLUGIN_BRICK_LIB_PLUGIN_H_
