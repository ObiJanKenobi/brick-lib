#include "include/brick_lib/brick_lib_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "brick_lib_plugin.h"

void BrickLibPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  brick_lib::BrickLibPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
