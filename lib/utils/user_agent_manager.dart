import 'dart:html' as html;

import 'package:flutter/foundation.dart';

enum AgentType {
  desktop,
  mobile,
}

class UserAgentManager {
  static AgentType getUserAgentType() {
    if (!kIsWeb) return AgentType.mobile;

    String userAgent = html.window.navigator.userAgent.toString().toLowerCase();

    if (userAgent.contains('iphone')) return AgentType.mobile;
    if (userAgent.contains('android')) return AgentType.mobile;

    if (userAgent.contains('ipad')) return AgentType.mobile;
    if (html.window.navigator.platform.toLowerCase().contains('macintel') &&
        html.window.navigator.maxTouchPoints > 0) return AgentType.mobile;

    return AgentType.desktop;
  }
}
