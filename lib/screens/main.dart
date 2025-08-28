import 'package:flutter/material.dart';
import 'package:ollama_dart/ollama_dart.dart';

// import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
// import 'package:flutter_chat_ui/flutter_chat_ui.dart' as chat_ui;
// import 'package:flutter_markdown/flutter_markdown.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:markdown/markdown.dart' as md;
// import 'package:pwa_install/pwa_install.dart' as pwa;
// import 'package:url_launcher/url_launcher.dart';
// import 'package:uuid/uuid.dart';
// import 'package:version/version.dart';
// import 'package:visibility_detector/visibility_detector.dart';

// import '../l10n/gen/app_localizations.dart';
// import '../main.dart';
import '../l10n/gen/app_localizations.dart';
import '../main.dart';
import '../services/chat.dart';
import '../services/error.dart';
import '../services/model.dart';
import '../services/theme.dart';
// import '../services/model.dart';
// import '../services/preferences.dart';
// import '../worker/desktop.dart';
// import '../worker/haptic.dart';
// import '../worker/sender.dart';
// import '../worker/setter.dart';
// import '../worker/theme.dart';
// import '../worker/update.dart';
// import 'settings.dart';
// import 'voice.dart';
// import 'welcome.dart';

// class ScreenMain extends StatefulWidget {
//   const ScreenMain({super.key});

//   @override
//   State<ScreenMain> createState() => _ScreenMainState();
// }

// class _ScreenMainState extends State<ScreenMain> {
//   int tipId = Random().nextInt(5);

//   List<Widget> sidebar(BuildContext context, Function setState) {
//     var padding = EdgeInsets.only(
//       left: desktopLayoutRequired(context) ? 17 : 12,
//       right: desktopLayoutRequired(context) ? 17 : 12,
//     );
//     return List.from([
//       (desktopLayoutNotRequired(context) || kIsWeb)
//           ? const SizedBox(height: 8)
//           : const SizedBox.shrink(),
//       desktopLayoutNotRequired(context)
//           ? const SizedBox.shrink()
//           : (Padding(
//               padding: padding,
//               child: InkWell(
//                 enableFeedback: false,
//                 customBorder: const RoundedRectangleBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(50)),
//                 ),
//                 onTap: () async {
//                   // ester egg? gimmick? not sure if it should be kept
//                   return;
//                   // ignore: dead_code
//                   if (sidebarIconSize != 1) return;
//                   setState(() {
//                     sidebarIconSize = 0.8;
//                   });
//                   await Future.delayed(const Duration(milliseconds: 200));
//                   setState(() {
//                     sidebarIconSize = 1.2;
//                   });
//                   await Future.delayed(const Duration(milliseconds: 200));
//                   setState(() {
//                     sidebarIconSize = 1;
//                   });
//                 },
//                 child: Padding(
//                   padding: const EdgeInsets.only(top: 16, bottom: 16),
//                   child: Row(
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(left: 16, right: 12),
//                         child: AnimatedScale(
//                           scale: sidebarIconSize,
//                           duration: const Duration(milliseconds: 400),
//                           child: const ImageIcon(
//                             AssetImage("assets/logo512.png"),
//                           ),
//                         ),
//                       ),
//                       Expanded(
//                         child: Text(
//                           AppLocalizations.of(context).appTitle,
//                           softWrap: false,
//                           overflow: TextOverflow.fade,
//                           style: const TextStyle(fontWeight: FontWeight.w500),
//                         ),
//                       ),
//                       const SizedBox(width: 16),
//                     ],
//                   ),
//                 ),
//               ),
//             )),
//       (desktopLayoutNotRequired(context) ||
//               (!allowMultipleChats && !allowSettings))
//           ? const SizedBox.shrink()
//           : Divider(
//               color: desktopLayout(context)
//                   ? Theme.of(context).colorScheme.onSurface.withAlpha(20)
//                   : null,
//             ),
//       allowMultipleChats
//           ? (Padding(
//               padding: padding,
//               child: InkWell(
//                 enableFeedback: false,
//                 customBorder: const RoundedRectangleBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(50)),
//                 ),
//                 onTap: () {
//                   selectionHaptic();
//                   if (!desktopLayout(context)) {
//                     Navigator.of(context).pop();
//                   }
//                   ChatManager.instance.currentChatId = null;
//                 },
//                 child: Padding(
//                   padding: const EdgeInsets.only(top: 16, bottom: 16),
//                   child: Row(
//                     children: [
//                       const Padding(
//                         padding: EdgeInsets.only(left: 16, right: 12),
//                         child: Icon(Icons.add_rounded),
//                       ),
//                       Expanded(
//                         child: Text(
//                           AppLocalizations.of(context).optionNewChat,
//                           softWrap: false,
//                           overflow: TextOverflow.fade,
//                           style: const TextStyle(fontWeight: FontWeight.w500),
//                         ),
//                       ),
//                       const SizedBox(width: 16),
//                     ],
//                   ),
//                 ),
//               ),
//             ))
//           : const SizedBox.shrink(),
//       allowSettings
//           ? (Padding(
//               padding: padding,
//               child: InkWell(
//                 enableFeedback: false,
//                 customBorder: const RoundedRectangleBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(50)),
//                 ),
//                 onTap: () {
//                   selectionHaptic();
//                   if (!desktopLayout(context)) {
//                     Navigator.of(context).pop();
//                   }
//                   setState(() {
//                     settingsOpen = true;
//                   });
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => const ScreenSettings(),
//                     ),
//                   );
//                 },
//                 child: Padding(
//                   padding: const EdgeInsets.only(top: 16, bottom: 16),
//                   child: Row(
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(left: 16, right: 12),
//                         child:
//                             (updateStatus == "ok" &&
//                                 updateDetectedOnStart &&
//                                 (Version.parse(latestVersion ?? "1.0.0") >
//                                     Version.parse(currentVersion ?? "2.0.0")))
//                             ? const Badge(child: Icon(Icons.dns_rounded))
//                             : const Icon(Icons.dns_rounded),
//                       ),
//                       Expanded(
//                         child: Text(
//                           AppLocalizations.of(context).optionSettings,
//                           softWrap: false,
//                           overflow: TextOverflow.fade,
//                           style: const TextStyle(fontWeight: FontWeight.w500),
//                         ),
//                       ),
//                       const SizedBox(width: 16),
//                     ],
//                   ),
//                 ),
//               ),
//             ))
//           : const SizedBox.shrink(),
//       (pwa.PWAInstall().installPromptEnabled &&
//               pwa.PWAInstall().launchMode == pwa.LaunchMode.browser)
//           ? (Padding(
//               padding: padding,
//               child: InkWell(
//                 enableFeedback: false,
//                 customBorder: const RoundedRectangleBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(50)),
//                 ),
//                 onTap: () {
//                   selectionHaptic();
//                   if (!desktopLayout(context)) {
//                     Navigator.of(context).pop();
//                   }
//                   pwa.PWAInstall().onAppInstalled = () {
//                     WidgetsBinding.instance.addPostFrameCallback((_) {
//                       pwa.setLaunchModePWA();
//                       setMainAppState!(() {});
//                     });
//                   };
//                   pwa.PWAInstall().promptInstall_();
//                   setState(() {});
//                 },
//                 child: Padding(
//                   padding: const EdgeInsets.only(top: 16, bottom: 16),
//                   child: Row(
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(left: 16, right: 12),
//                         child: desktopLayoutNotRequired(context)
//                             ? const Icon(Icons.install_desktop_rounded)
//                             : const Icon(Icons.install_mobile_rounded),
//                       ),
//                       Expanded(
//                         child: Text(
//                           AppLocalizations.of(context).optionInstallPwa,
//                           softWrap: false,
//                           overflow: TextOverflow.fade,
//                           style: const TextStyle(fontWeight: FontWeight.w500),
//                         ),
//                       ),
//                       const SizedBox(width: 16),
//                     ],
//                   ),
//                 ),
//               ),
//             ))
//           : const SizedBox.shrink(),
//       (desktopLayoutNotRequired(context) &&
//               (!allowMultipleChats && !allowSettings))
//           ? const SizedBox.shrink()
//           : Divider(
//               color: desktopLayout(context)
//                   ? Theme.of(context).colorScheme.onSurface.withAlpha(20)
//                   : null,
//             ),
//       ((prefs?.getStringList("chats") ?? []).isNotEmpty)
//           ? const SizedBox.shrink()
//           : (Padding(
//               padding: padding,
//               child: InkWell(
//                 enableFeedback: false,
//                 customBorder: const RoundedRectangleBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(50)),
//                 ),
//                 onTap: selectionHaptic,
//                 child: Padding(
//                   padding: const EdgeInsets.only(top: 16, bottom: 16),
//                   child: Row(
//                     children: [
//                       const Padding(
//                         padding: EdgeInsets.only(left: 16, right: 12),
//                         child: Icon(
//                           Icons.question_mark_rounded,
//                           color: Colors.grey,
//                         ),
//                       ),
//                       Expanded(
//                         child: Text(
//                           AppLocalizations.of(context).optionNoChatFound,
//                           softWrap: false,
//                           overflow: TextOverflow.fade,
//                           style: const TextStyle(
//                             fontWeight: FontWeight.w500,
//                             color: Colors.grey,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(width: 16),
//                     ],
//                   ),
//                 ),
//               ),
//             )),
//       Builder(
//         builder: (context) {
//           var tip = (tipId == 0)
//               ? AppLocalizations.of(context).tip0
//               : (tipId == 1)
//               ? AppLocalizations.of(context).tip1
//               : (tipId == 2)
//               ? AppLocalizations.of(context).tip2
//               : (tipId == 3)
//               ? AppLocalizations.of(context).tip3
//               : AppLocalizations.of(context).tip4;
//           return (!(prefs?.getBool("tips") ?? true) ||
//                   (prefs?.getStringList("chats") ?? []).isNotEmpty ||
//                   !allowSettings)
//               ? const SizedBox.shrink()
//               : (Padding(
//                   padding: padding,
//                   child: InkWell(
//                     splashFactory: NoSplash.splashFactory,
//                     highlightColor: Colors.transparent,
//                     enableFeedback: false,
//                     hoverColor: Colors.transparent,
//                     onTap: () {
//                       selectionHaptic();
//                       var tmpTip = tipId;
//                       while (tmpTip == tipId) {
//                         tipId = Random().nextInt(5);
//                       }
//                       setState(() {});
//                     },
//                     child: Padding(
//                       padding: const EdgeInsets.only(top: 16, bottom: 16),
//                       child: Row(
//                         children: [
//                           const Padding(
//                             padding: EdgeInsets.only(left: 16, right: 12),
//                             child: Icon(
//                               Icons.tips_and_updates_rounded,
//                               color: Colors.grey,
//                             ),
//                           ),
//                           Expanded(
//                             child: Text(
//                               AppLocalizations.of(context).tipPrefix + tip,
//                               softWrap: true,
//                               maxLines: 3,
//                               overflow: TextOverflow.fade,
//                               style: const TextStyle(
//                                 fontWeight: FontWeight.w500,
//                                 color: Colors.grey,
//                               ),
//                             ),
//                           ),
//                           const SizedBox(width: 16),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ));
//         },
//       ),
//     ])..addAll(
//       (prefs?.getStringList("chats") ?? []).map((item) {
//         var child = Padding(
//           padding: padding,
//           child: InkWell(
//             enableFeedback: false,
//             customBorder: const RoundedRectangleBorder(
//               borderRadius: BorderRadius.all(Radius.circular(50)),
//             ),
//             onTap: () {
//               selectionHaptic();
//               if (!desktopLayoutRequired(context)) {
//                 Navigator.of(context).pop();
//               }
//               if (!chatAllowed) return;
//               if (chatUuid == jsonDecode(item)["uuid"]) return;
//               loadChat(jsonDecode(item)["uuid"], setState);
//               chatUuid = jsonDecode(item)["uuid"];
//             },
//             onHover: (value) {
//               setState(() {
//                 if (value) {
//                   hoveredChat = jsonDecode(item)["uuid"];
//                 } else {
//                   hoveredChat = "";
//                 }
//               });
//             },
//             onLongPress:
//                 (desktopFeature() ||
//                     (kIsWeb && desktopLayoutNotRequired(context)))
//                 ? null
//                 : () async {
//                     selectionHaptic();
//                     if (!chatAllowed && chatUuid == jsonDecode(item)["uuid"]) {
//                       return;
//                     }
//                     if (!allowSettings) return;
//                     String oldTitle = jsonDecode(item)["title"];
//                     var newTitle = await prompt(
//                       context,
//                       title: AppLocalizations.of(context).dialogEnterNewTitle,
//                       value: oldTitle,
//                       uuid: jsonDecode(item)["uuid"],
//                     );
//                     var tmp = prefs!.getStringList("chats") ?? [];
//                     for (var i = 0; i < tmp.length; i++) {
//                       if (jsonDecode(
//                             (prefs!.getStringList("chats") ?? [])[i],
//                           )["uuid"] ==
//                           jsonDecode(item)["uuid"]) {
//                         var tmp2 = jsonDecode(tmp[i]);
//                         tmp2["title"] = newTitle;
//                         tmp[i] = jsonEncode(tmp2);
//                         break;
//                       }
//                     }
//                     prefs!.setStringList("chats", tmp);
//                     setState(() {});
//                   },
//             child: Padding(
//               padding: const EdgeInsets.only(top: 16, bottom: 16),
//               child: Row(
//                 children: [
//                   allowMultipleChats
//                       ? Padding(
//                           padding: const EdgeInsets.only(left: 16, right: 16),
//                           child: Icon(
//                             (chatUuid == jsonDecode(item)["uuid"])
//                                 ? Icons.location_on_rounded
//                                 : Icons.restore_rounded,
//                           ),
//                         )
//                       : const SizedBox(width: 16),
//                   Expanded(
//                     child: Text(
//                       jsonDecode(item)["title"],
//                       softWrap: false,
//                       maxLines: 1,
//                       overflow: TextOverflow.fade,
//                       style: const TextStyle(fontWeight: FontWeight.w500),
//                     ),
//                   ),
//                   AnimatedSwitcher(
//                     duration: const Duration(milliseconds: 100),
//                     child:
//                         (((desktopFeature() ||
//                                     (kIsWeb &&
//                                         desktopLayoutNotRequired(context))) &&
//                                 (hoveredChat == jsonDecode(item)["uuid"])) ||
//                             !allowMultipleChats)
//                         ? Padding(
//                             padding: const EdgeInsets.only(left: 16, right: 16),
//                             child: SizedBox(
//                               height: 24,
//                               width: 24,
//                               child: IconButton(
//                                 tooltip: allowMultipleChats
//                                     ? allowSettings
//                                           ? AppLocalizations.of(
//                                               context,
//                                             ).tooltipOptions
//                                           : AppLocalizations.of(
//                                               context,
//                                             ).deleteChat
//                                     : AppLocalizations.of(context).tooltipReset,
//                                 onPressed: () {
//                                   if (!chatAllowed &&
//                                       chatUuid == jsonDecode(item)["uuid"]) {
//                                     return;
//                                   }
//                                   if (!allowMultipleChats) {
//                                     for (
//                                       var i = 0;
//                                       i <
//                                           (prefs!.getStringList("chats") ?? [])
//                                               .length;
//                                       i++
//                                     ) {
//                                       if (jsonDecode(
//                                             (prefs!.getStringList("chats") ??
//                                                 [])[i],
//                                           )["uuid"] ==
//                                           jsonDecode(item)["uuid"]) {
//                                         var tmp = prefs!.getStringList("chats")!
//                                           ..removeAt(i);
//                                         prefs!.setStringList("chats", tmp);
//                                         break;
//                                       }
//                                     }
//                                     messages = [];
//                                     chatUuid = null;
//                                     if (!desktopLayoutRequired(context)) {
//                                       Navigator.of(context).pop();
//                                     }
//                                     setState(() {});
//                                     return;
//                                   }
//                                   if (!allowSettings) {
//                                     showDeleteChatDialog(
//                                       context,
//                                       uuid: jsonDecode(item)["uuid"],
//                                     );
//                                     return;
//                                   }
//                                   if (!desktopLayoutRequired(context)) {
//                                     Navigator.of(context).pop();
//                                   }
//                                   showModalBottomSheet(
//                                     context: context,
//                                     builder: (context) {
//                                       return Container(
//                                         padding: const EdgeInsets.only(
//                                           left: 16,
//                                           right: 16,
//                                           top: 16,
//                                         ),
//                                         child: Column(
//                                           mainAxisSize: MainAxisSize.min,
//                                           children: [
//                                             SizedBox(
//                                               width: double.infinity,
//                                               child: OutlinedButton.icon(
//                                                 onPressed: () {
//                                                   Navigator.of(context).pop();
//                                                   showDeleteChatDialog(
//                                                     context,
//                                                     uuid: jsonDecode(
//                                                       item,
//                                                     )["uuid"],
//                                                     onDelete: () {
//                                                       if (!desktopLayoutRequired(
//                                                         context,
//                                                       )) {
//                                                         Navigator.of(
//                                                           context,
//                                                         ).pop();
//                                                       }
//                                                     },
//                                                   );
//                                                 },
//                                                 icon: const Icon(
//                                                   Icons.delete_forever_rounded,
//                                                 ),
//                                                 label: Text(
//                                                   AppLocalizations.of(
//                                                     context,
//                                                   ).deleteChat,
//                                                 ),
//                                               ),
//                                             ),
//                                             const SizedBox(height: 8),
//                                             SizedBox(
//                                               width: double.infinity,
//                                               child: OutlinedButton.icon(
//                                                 onPressed: () async {
//                                                   Navigator.of(context).pop();
//                                                   String oldTitle = jsonDecode(
//                                                     item,
//                                                   )["title"];
//                                                   var newTitle = await prompt(
//                                                     context,
//                                                     title: AppLocalizations.of(
//                                                       context,
//                                                     ).dialogEnterNewTitle,
//                                                     value: oldTitle,
//                                                     uuid: jsonDecode(
//                                                       item,
//                                                     )["uuid"],
//                                                   );
//                                                   var tmp =
//                                                       prefs!.getStringList(
//                                                         "chats",
//                                                       ) ??
//                                                       [];
//                                                   for (
//                                                     var i = 0;
//                                                     i < tmp.length;
//                                                     i++
//                                                   ) {
//                                                     if (jsonDecode(
//                                                           (prefs!.getStringList(
//                                                                 "chats",
//                                                               ) ??
//                                                               [])[i],
//                                                         )["uuid"] ==
//                                                         jsonDecode(
//                                                           item,
//                                                         )["uuid"]) {
//                                                       var tmp2 = jsonDecode(
//                                                         tmp[i],
//                                                       );
//                                                       tmp2["title"] = newTitle;
//                                                       tmp[i] = jsonEncode(tmp2);
//                                                       break;
//                                                     }
//                                                   }
//                                                   prefs!.setStringList(
//                                                     "chats",
//                                                     tmp,
//                                                   );
//                                                   setState(() {});
//                                                 },
//                                                 icon: const Icon(
//                                                   Icons.edit_rounded,
//                                                 ),
//                                                 label: Text(
//                                                   AppLocalizations.of(
//                                                     context,
//                                                   ).renameChat,
//                                                 ),
//                                               ),
//                                             ),
//                                             const SizedBox(height: 16),
//                                           ],
//                                         ),
//                                       );
//                                     },
//                                   );
//                                 },
//                                 hoverColor: Colors.transparent,
//                                 highlightColor: Colors.transparent,
//                                 icon: Transform.translate(
//                                   offset: const Offset(-8, -8),
//                                   // ignore const suggestion, because values could be not const
//                                   // ignore: prefer_const_constructors
//                                   child: Icon(
//                                     allowMultipleChats
//                                         ? allowSettings
//                                               ? Icons.more_horiz_rounded
//                                               : Icons.close_rounded
//                                         : Icons.restart_alt_rounded,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           )
//                         : const SizedBox(width: 16),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//         return (desktopFeature() ||
//                     (kIsWeb && desktopLayoutNotRequired(context))) ||
//                 !allowMultipleChats
//             ? child
//             : Dismissible(
//                 key: Key(jsonDecode(item)["uuid"]),
//                 direction: chatAllowed
//                     ? DismissDirection.startToEnd
//                     : DismissDirection.none,
//                 confirmDismiss: (direction) async {
//                   if (!chatAllowed && chatUuid == jsonDecode(item)["uuid"]) {
//                     return false;
//                   }
//                   return showDeleteChatDialog(
//                     context,
//                     uuid: jsonDecode(item)["uuid"],
//                   );
//                 },
//                 onDismissed: (direction) {
//                   selectionHaptic();
//                   for (
//                     var i = 0;
//                     i < (prefs!.getStringList("chats") ?? []).length;
//                     i++
//                   ) {
//                     if (jsonDecode(
//                           (prefs!.getStringList("chats") ?? [])[i],
//                         )["uuid"] ==
//                         jsonDecode(item)["uuid"]) {
//                       var tmp = prefs!.getStringList("chats")!..removeAt(i);
//                       prefs!.setStringList("chats", tmp);
//                       break;
//                     }
//                   }
//                   if (chatUuid == jsonDecode(item)["uuid"]) {
//                     messages = [];
//                     chatUuid = null;
//                     if (!desktopLayoutRequired(context)) {
//                       Navigator.of(context).pop();
//                     }
//                   }
//                   setState(() {});
//                 },
//                 child: child,
//               );
//       }).toList(),
//     );
//   }

//   @override
//   void initState() {
//     super.initState();
//     mainContext = context;

//     WidgetsBinding.instance.addPostFrameCallback((_) async {
//       if (prefs == null) {
//         await Future.doWhile(
//           () => Future.delayed(const Duration(milliseconds: 1)).then((_) {
//             return prefs == null;
//           }),
//         );
//       }

//       if (!mounted) return;

//       if (!(allowSettings || useHost)) {
//         showDialog(
//           context: context,
//           builder: (context) {
//             return const PopScope(
//               canPop: false,
//               child: Dialog.fullscreen(
//                 backgroundColor: Colors.black,
//                 child: Padding(
//                   padding: EdgeInsets.all(16),
//                   child: Text(
//                     "*Build Error:*\n\nuseHost: $useHost\nallowSettings: $allowSettings\n\nYou created this build? One of them must be set to true or the app is not functional!\n\nYou received this build by someone else? Please contact them and report the issue.",
//                     style: TextStyle(
//                       color: Colors.red,
//                       fontFamily: "monospace",
//                     ),
//                   ),
//                 ),
//               ),
//             );
//           },
//         );
//       }

//       // prefs!.remove("welcomeFinished");
//       if (!Preferences.welcomeFinished && allowSettings) {
//         Navigator.of(context).pushReplacement(
//           MaterialPageRoute(builder: (context) => const ScreenWelcome()),
//         );
//         return;
//       }

//       if (!allowMultipleChats &&
//           (prefs!.getStringList("chats") ?? []).isNotEmpty) {
//         chatUuid = jsonDecode((prefs!.getStringList("chats") ?? [])[0])["uuid"];
//         loadChat(chatUuid!, setState);
//       }

//       setState(() {
//         model = useModel ? fixedModel : prefs!.getString("model");
//         chatAllowed = !(model == null);
//         multimodal = prefs?.getBool("multimodal") ?? false;
//         host = useHost ? fixedHost : prefs?.getString("host");
//       });

//       if (host == null) {
//         // ignore: use_build_context_synchronously
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             // ignore: use_build_context_synchronously
//             content: Text(AppLocalizations.of(context).noHostSelected),
//             showCloseIcon: true,
//           ),
//         );
//       }

//       setState(() {});
//       if (prefs!.getBool("checkUpdateOnSettingsOpen") ?? true) {
//         updateDetectedOnStart = await checkUpdate(setState);
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     Widget selector = InkWell(
//       onTap: !useModel
//           ? () {
//               if (host == null) {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(
//                     content: Text(AppLocalizations.of(context).noHostSelected),
//                     showCloseIcon: true,
//                   ),
//                 );
//                 return;
//               }
//               setModel(context, setState);
//             }
//           : null,
//       splashFactory: NoSplash.splashFactory,
//       highlightColor: Colors.transparent,
//       enableFeedback: false,
//       hoverColor: Colors.transparent,
//       child: SizedBox(
//         height: 200,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Flexible(
//               child: Text(
//                 (model ?? AppLocalizations.of(context).noSelectedModel).split(
//                   ":",
//                 )[0],
//                 overflow: TextOverflow.fade,
//                 style: const TextStyle(fontFamily: "monospace", fontSize: 16),
//               ),
//             ),
//             useModel
//                 ? const SizedBox.shrink()
//                 : const Icon(Icons.expand_more_rounded),
//           ],
//         ),
//       ),
//     );

//     return WindowBorder(
//       color: Theme.of(context).colorScheme.surface,
//       child: Scaffold(
//         appBar: AppBar(
//           titleSpacing: 0,
//           title: Row(
//             children: desktopFeature()
//                 ? desktopLayoutRequired(context)
//                       ? [
//                           SizedBox(
//                             width: 304,
//                             height: 200,
//                             child: MoveWindow(),
//                           ),
//                           SizedBox(
//                             height: 200,
//                             child: AnimatedOpacity(
//                               opacity: menuVisible ? 1.0 : 0.0,
//                               duration: const Duration(milliseconds: 300),
//                               child: VerticalDivider(
//                                 width: 2,
//                                 color: Theme.of(
//                                   context,
//                                 ).colorScheme.onSurface.withAlpha(20),
//                               ),
//                             ),
//                           ),
//                           AnimatedOpacity(
//                             opacity: desktopTitleVisible ? 1.0 : 0.0,
//                             duration: desktopTitleVisible
//                                 ? const Duration(milliseconds: 300)
//                                 : Duration.zero,
//                             child: Padding(
//                               padding: const EdgeInsets.all(16),
//                               child: selector,
//                             ),
//                           ),
//                           Expanded(
//                             child: SizedBox(height: 200, child: MoveWindow()),
//                           ),
//                         ]
//                       : [
//                           SizedBox(width: 90, height: 200, child: MoveWindow()),
//                           Expanded(
//                             child: SizedBox(height: 200, child: MoveWindow()),
//                           ),
//                           selector,
//                           Expanded(
//                             child: SizedBox(height: 200, child: MoveWindow()),
//                           ),
//                         ]
//                 : desktopLayoutRequired(context)
//                 ? [
//                     // bottom left tile
//                     const SizedBox(width: 304, height: 200),
//                     SizedBox(
//                       height: 200,
//                       child: AnimatedOpacity(
//                         opacity: menuVisible ? 1.0 : 0.0,
//                         duration: const Duration(milliseconds: 300),
//                         child: VerticalDivider(
//                           width: 2,
//                           color: Theme.of(
//                             context,
//                           ).colorScheme.onSurface.withAlpha(20),
//                         ),
//                       ),
//                     ),
//                     AnimatedOpacity(
//                       opacity: desktopTitleVisible ? 1.0 : 0.0,
//                       duration: desktopTitleVisible
//                           ? const Duration(milliseconds: 300)
//                           : Duration.zero,
//                       child: Padding(
//                         padding: const EdgeInsets.all(16),
//                         child: selector,
//                       ),
//                     ),
//                     const Expanded(child: SizedBox(height: 200)),
//                   ]
//                 : [Expanded(child: selector)],
//           ),
//           actions: desktopControlsActions(context, [
//             const SizedBox(width: 4),
//             allowMultipleChats
//                 ? IconButton(
//                     enableFeedback: false,
//                     onPressed: () {
//                       selectionHaptic();
//                       if (!chatAllowed) return;
//                       if (messages.isNotEmpty) showDeleteChatDialog(context);
//                     },
//                     icon: const Icon(Icons.restart_alt_rounded),
//                   )
//                 : const SizedBox.shrink(),
//           ]),
//           bottom: PreferredSize(
//             preferredSize: const Size.fromHeight(1),
//             child: (!chatAllowed && model != null)
//                 ? const LinearProgressIndicator()
//                 : desktopLayout(context)
//                 ? AnimatedOpacity(
//                     opacity: menuVisible ? 1.0 : 0.0,
//                     duration: const Duration(milliseconds: 300),
//                     child: Divider(
//                       height: 2,
//                       color: Theme.of(
//                         context,
//                       ).colorScheme.onSurface.withAlpha(20),
//                     ),
//                   )
//                 : const SizedBox.shrink(),
//           ),
//           automaticallyImplyLeading: !desktopLayoutRequired(context),
//         ),
//         body: Row(
//           children: [
//             desktopLayoutRequired(context)
//                 ? SizedBox(
//                     width: 304,
//                     height: double.infinity,
//                     child: VisibilityDetector(
//                       key: const Key("menuVisible"),
//                       onVisibilityChanged: (VisibilityInfo info) {
//                         if (settingsOpen) return;
//                         menuVisible = info.visibleFraction > 0;
//                         try {
//                           setState(() {});
//                         } catch (_) {}
//                       },
//                       child: AnimatedOpacity(
//                         opacity: menuVisible ? 1.0 : 0.0,
//                         duration: const Duration(milliseconds: 300),
//                         child: ListView(children: sidebar(context, setState)),
//                       ),
//                     ),
//                   )
//                 : const SizedBox.shrink(),
//             desktopLayout(context)
//                 ? AnimatedOpacity(
//                     opacity: menuVisible ? 1.0 : 0.0,
//                     duration: const Duration(milliseconds: 300),
//                     child: VerticalDivider(
//                       width: 2,
//                       color: Theme.of(
//                         context,
//                       ).colorScheme.onSurface.withAlpha(20),
//                     ),
//                   )
//                 : const SizedBox.shrink(),
//             Expanded(
//               child: Center(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisSize: MainAxisSize.max,
//                   children: [
//                     Flexible(
//                       child: Container(
//                         constraints: const BoxConstraints(maxWidth: 1000),
//                         child: chat_ui.Chat(
//                           messages: messages,
//                           key: chatKey,
//                           textMessageBuilder:
//                               (p0, {required messageWidth, required showName}) {
//                                 var white = const TextStyle(
//                                   color: Colors.white,
//                                 );
//                                 var greyed = false;
//                                 var text = p0.text;
//                                 if (text.trim() == "") {
//                                   text =
//                                       "_Empty AI response, try restarting conversation_";
//                                   greyed = true;
//                                 }
//                                 return Padding(
//                                   padding: const EdgeInsets.only(
//                                     left: 20,
//                                     right: 23,
//                                     top: 17,
//                                     bottom: 17,
//                                   ),
//                                   child: Theme(
//                                     data: Theme.of(context).copyWith(
//                                       scrollbarTheme: const ScrollbarThemeData(
//                                         thumbColor: WidgetStatePropertyAll(
//                                           Colors.grey,
//                                         ),
//                                       ),
//                                     ),
//                                     child: MarkdownBody(
//                                       data: text,
//                                       onTapLink: (text, href, title) async {
//                                         selectionHaptic();
//                                         try {
//                                           var url = Uri.parse(href!);
//                                           if (await canLaunchUrl(url)) {
//                                             launchUrl(
//                                               mode: LaunchMode.inAppBrowserView,
//                                               url,
//                                             );
//                                           } else {
//                                             throw Exception();
//                                           }
//                                         } catch (_) {
//                                           // ignore: use_build_context_synchronously
//                                           ScaffoldMessenger.of(
//                                             context,
//                                           ).showSnackBar(
//                                             SnackBar(
//                                               content: Text(
//                                                 AppLocalizations.of(
//                                                   // ignore: use_build_context_synchronously
//                                                   context,
//                                                 ).settingsHostInvalid("url"),
//                                               ),
//                                               showCloseIcon: true,
//                                             ),
//                                           );
//                                         }
//                                       },
//                                       extensionSet: md.ExtensionSet(
//                                         md
//                                             .ExtensionSet
//                                             .gitHubFlavored
//                                             .blockSyntaxes,
//                                         <md.InlineSyntax>[
//                                           md.EmojiSyntax(),
//                                           ...md
//                                               .ExtensionSet
//                                               .gitHubFlavored
//                                               .inlineSyntaxes,
//                                         ],
//                                       ),
//                                       imageBuilder: (uri, title, alt) {
//                                         Widget errorImage = InkWell(
//                                           onTap: () {
//                                             selectionHaptic();
//                                             ScaffoldMessenger.of(
//                                               context,
//                                             ).showSnackBar(
//                                               SnackBar(
//                                                 content: Text(
//                                                   AppLocalizations.of(
//                                                     context,
//                                                   ).notAValidImage,
//                                                 ),
//                                                 showCloseIcon: true,
//                                               ),
//                                             );
//                                           },
//                                           child: Container(
//                                             decoration: BoxDecoration(
//                                               borderRadius:
//                                                   BorderRadius.circular(8),
//                                               color:
//                                                   Theme.of(
//                                                         context,
//                                                       ).brightness ==
//                                                       Brightness.light
//                                                   ? Colors.white
//                                                   : Colors.black,
//                                             ),
//                                             padding: const EdgeInsets.only(
//                                               left: 100,
//                                               right: 100,
//                                               top: 32,
//                                             ),
//                                             child: const Image(
//                                               image: AssetImage(
//                                                 "assets/logo512error.png",
//                                               ),
//                                             ),
//                                           ),
//                                         );
//                                         if (uri.isAbsolute) {
//                                           return Image.network(
//                                             uri.toString(),
//                                             errorBuilder:
//                                                 (context, error, stackTrace) {
//                                                   return errorImage;
//                                                 },
//                                           );
//                                         } else {
//                                           return errorImage;
//                                         }
//                                       },
//                                       styleSheet: (p0.author == user)
//                                           ? MarkdownStyleSheet(
//                                               p: const TextStyle(
//                                                 color: Colors.white,
//                                                 fontSize: 16,
//                                                 fontWeight: FontWeight.w500,
//                                               ),
//                                               blockquoteDecoration:
//                                                   BoxDecoration(
//                                                     color: Colors.grey[800],
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                           8,
//                                                         ),
//                                                   ),
//                                               code: const TextStyle(
//                                                 color: Colors.black,
//                                                 backgroundColor: Colors.white,
//                                               ),
//                                               codeblockDecoration:
//                                                   BoxDecoration(
//                                                     color: Colors.white,
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                           8,
//                                                         ),
//                                                   ),
//                                               h1: white,
//                                               h2: white,
//                                               h3: white,
//                                               h4: white,
//                                               h5: white,
//                                               h6: white,
//                                               listBullet: white,
//                                               horizontalRuleDecoration:
//                                                   BoxDecoration(
//                                                     border: Border(
//                                                       top: BorderSide(
//                                                         color:
//                                                             Colors.grey[800]!,
//                                                         width: 1,
//                                                       ),
//                                                     ),
//                                                   ),
//                                               tableBorder: TableBorder.all(
//                                                 color: Colors.white,
//                                               ),
//                                               tableBody: white,
//                                             )
//                                           : (Theme.of(context).brightness ==
//                                                 Brightness.light)
//                                           ? MarkdownStyleSheet(
//                                               p: TextStyle(
//                                                 color: greyed
//                                                     ? Colors.grey
//                                                     : Colors.black,
//                                                 fontSize: 16,
//                                                 fontWeight: FontWeight.w500,
//                                               ),
//                                               blockquoteDecoration:
//                                                   BoxDecoration(
//                                                     color: Colors.grey[200],
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                           8,
//                                                         ),
//                                                   ),
//                                               code: const TextStyle(
//                                                 color: Colors.white,
//                                                 backgroundColor: Colors.black,
//                                               ),
//                                               codeblockDecoration:
//                                                   BoxDecoration(
//                                                     color: Colors.black,
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                           8,
//                                                         ),
//                                                   ),
//                                               horizontalRuleDecoration:
//                                                   BoxDecoration(
//                                                     border: Border(
//                                                       top: BorderSide(
//                                                         color:
//                                                             Colors.grey[200]!,
//                                                         width: 1,
//                                                       ),
//                                                     ),
//                                                   ),
//                                             )
//                                           : MarkdownStyleSheet(
//                                               p: const TextStyle(
//                                                 color: Colors.white,
//                                                 fontSize: 16,
//                                                 fontWeight: FontWeight.w500,
//                                               ),
//                                               blockquoteDecoration:
//                                                   BoxDecoration(
//                                                     color: Colors.grey[800]!,
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                           8,
//                                                         ),
//                                                   ),
//                                               code: const TextStyle(
//                                                 color: Colors.black,
//                                                 backgroundColor: Colors.white,
//                                               ),
//                                               codeblockDecoration:
//                                                   BoxDecoration(
//                                                     color: Colors.white,
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                           8,
//                                                         ),
//                                                   ),
//                                               horizontalRuleDecoration:
//                                                   BoxDecoration(
//                                                     border: Border(
//                                                       top: BorderSide(
//                                                         color:
//                                                             Colors.grey[200]!,
//                                                         width: 1,
//                                                       ),
//                                                     ),
//                                                   ),
//                                             ),
//                                     ),
//                                   ),
//                                 );
//                               },
//                           imageMessageBuilder: (p0, {required messageWidth}) {
//                             return SizedBox(
//                               width: desktopLayout(context) ? 360.0 : 160.0,
//                               child: MarkdownBody(
//                                 data: "![${p0.name}](${p0.uri})",
//                               ),
//                             );
//                           },
//                           disableImageGallery: true,
//                           emptyState: Center(
//                             child: VisibilityDetector(
//                               key: const Key("logoVisible"),
//                               onVisibilityChanged: (VisibilityInfo info) {
//                                 if (settingsOpen) return;
//                                 logoVisible = info.visibleFraction > 0;
//                                 try {
//                                   setState(() {});
//                                 } catch (_) {}
//                               },
//                               child: AnimatedOpacity(
//                                 opacity: logoVisible ? 1.0 : 0.0,
//                                 duration: const Duration(milliseconds: 500),
//                                 child: const ImageIcon(
//                                   AssetImage("assets/logo512.png"),
//                                   size: 44,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           onSendPressed: (p0) {
//                             send(p0.text, context, setState);
//                           },
//                           onMessageDoubleTap: (context, p1) {
//                             selectionHaptic();
//                             if (!chatAllowed) return;
//                             if (p1.author == assistant) return;
//                             for (var i = 0; i < messages.length; i++) {
//                               if (messages[i].id == p1.id) {
//                                 var messageList =
//                                     (jsonDecode(jsonEncode(messages)) as List)
//                                         .reversed
//                                         .toList();
//                                 var found = false;
//                                 var index = [];
//                                 for (var j = 0; j < messageList.length; j++) {
//                                   if (messageList[j]["id"] == p1.id) {
//                                     found = true;
//                                   }
//                                   if (found) {
//                                     index.add(messageList[j]["id"]);
//                                   }
//                                 }
//                                 for (var j = 0; j < index.length; j++) {
//                                   for (var k = 0; k < messages.length; k++) {
//                                     if (messages[k].id == index[j]) {
//                                       messages.removeAt(k);
//                                     }
//                                   }
//                                 }
//                                 break;
//                               }
//                             }
//                             saveChat(chatUuid!, setState);
//                             setState(() {});
//                           },
//                           onMessageLongPress: (context, p1) async {
//                             selectionHaptic();

//                             if (!(prefs!.getBool("enableEditing") ?? true)) {
//                               return;
//                             }

//                             var index = -1;
//                             if (!chatAllowed) return;
//                             for (var i = 0; i < messages.length; i++) {
//                               if (messages[i].id == p1.id) {
//                                 index = i;
//                                 break;
//                               }
//                             }

//                             var text =
//                                 (messages[index] as types.TextMessage).text;
//                             var input = await prompt(
//                               context,
//                               title: AppLocalizations.of(
//                                 context,
//                               ).dialogEditMessageTitle,
//                               value: text,
//                               keyboard: TextInputType.multiline,
//                               maxLines: (text.length >= 100)
//                                   ? 10
//                                   : ((text.length >= 50) ? 5 : 3),
//                             );
//                             if (input == "") return;

//                             messages[index] = types.TextMessage(
//                               author: p1.author,
//                               createdAt: p1.createdAt,
//                               id: p1.id,
//                               text: input,
//                             );
//                             setState(() {});
//                           },
//                           onAttachmentPressed: (!multimodal)
//                               ? (prefs?.getBool("voiceModeEnabled") ?? false)
//                                     ? (model != null)
//                                           ? () {
//                                               selectionHaptic();
//                                               setGlobalState = setState;
//                                               settingsOpen = true;
//                                               logoVisible = false;
//                                               Navigator.of(context).push(
//                                                 MaterialPageRoute(
//                                                   builder: (context) =>
//                                                       const ScreenVoice(),
//                                                 ),
//                                               );
//                                             }
//                                           : null
//                                     : null
//                               : () {
//                                   selectionHaptic();
//                                   if (!chatAllowed || model == null) {
//                                     return;
//                                   }
//                                   if (desktopFeature()) {
//                                     FilePicker.platform
//                                         .pickFiles(type: FileType.image)
//                                         .then((value) async {
//                                           if (value == null) return;
//                                           if (!multimodal) return;

//                                           var encoded = base64.encode(
//                                             await File(
//                                               value.files.first.path!,
//                                             ).readAsBytes(),
//                                           );
//                                           messages.insert(
//                                             0,
//                                             types.ImageMessage(
//                                               author: user,
//                                               id: const Uuid().v4(),
//                                               name: value.files.first.name,
//                                               size: value.files.first.size,
//                                               uri:
//                                                   "data:image/png;base64,$encoded",
//                                             ),
//                                           );

//                                           setState(() {});
//                                         });

//                                     return;
//                                   }
//                                   showModalBottomSheet(
//                                     context: context,
//                                     builder: (context) {
//                                       return Container(
//                                         width: double.infinity,
//                                         padding: const EdgeInsets.only(
//                                           left: 16,
//                                           right: 16,
//                                           top: 16,
//                                         ),
//                                         child: Column(
//                                           mainAxisSize: MainAxisSize.min,
//                                           children: [
//                                             (prefs?.getBool(
//                                                       "voiceModeEnabled",
//                                                     ) ??
//                                                     false)
//                                                 ? SizedBox(
//                                                     width: double.infinity,
//                                                     child: OutlinedButton.icon(
//                                                       onPressed: () async {
//                                                         selectionHaptic();
//                                                         Navigator.of(
//                                                           context,
//                                                         ).pop();
//                                                         setGlobalState =
//                                                             setState;
//                                                         settingsOpen = true;
//                                                         logoVisible = false;
//                                                         Navigator.of(
//                                                           context,
//                                                         ).push(
//                                                           MaterialPageRoute(
//                                                             builder: (context) =>
//                                                                 const ScreenVoice(),
//                                                           ),
//                                                         );
//                                                       },
//                                                       icon: const Icon(
//                                                         Icons
//                                                             .headphones_rounded,
//                                                       ),
//                                                       label: Text(
//                                                         AppLocalizations.of(
//                                                           context,
//                                                         ).settingsTitleVoice,
//                                                       ),
//                                                     ),
//                                                   )
//                                                 : const SizedBox.shrink(),
//                                             (prefs?.getBool(
//                                                       "voiceModeEnabled",
//                                                     ) ??
//                                                     false)
//                                                 ? const SizedBox(height: 8)
//                                                 : const SizedBox.shrink(),
//                                             SizedBox(
//                                               width: double.infinity,
//                                               child: OutlinedButton.icon(
//                                                 onPressed: () async {
//                                                   selectionHaptic();

//                                                   Navigator.of(context).pop();
//                                                   var result =
//                                                       await ImagePicker()
//                                                           .pickImage(
//                                                             source: ImageSource
//                                                                 .camera,
//                                                           );
//                                                   if (result == null) {
//                                                     return;
//                                                   }

//                                                   var bytes = await result
//                                                       .readAsBytes();
//                                                   var image =
//                                                       await decodeImageFromList(
//                                                         bytes,
//                                                       );

//                                                   var message = types.ImageMessage(
//                                                     author: user,
//                                                     createdAt: DateTime.now()
//                                                         .millisecondsSinceEpoch,
//                                                     height: image.height
//                                                         .toDouble(),
//                                                     id: const Uuid().v4(),
//                                                     name: result.name,
//                                                     size: bytes.length,
//                                                     uri: result.path,
//                                                     width: image.width
//                                                         .toDouble(),
//                                                   );

//                                                   messages.insert(0, message);
//                                                   setState(() {});
//                                                   selectionHaptic();
//                                                 },
//                                                 icon: const Icon(
//                                                   Icons.photo_camera_rounded,
//                                                 ),
//                                                 label: Text(
//                                                   AppLocalizations.of(
//                                                     context,
//                                                   ).takeImage,
//                                                 ),
//                                               ),
//                                             ),
//                                             const SizedBox(height: 8),
//                                             SizedBox(
//                                               width: double.infinity,
//                                               child: OutlinedButton.icon(
//                                                 onPressed: () async {
//                                                   selectionHaptic();

//                                                   Navigator.of(context).pop();
//                                                   var result =
//                                                       await ImagePicker()
//                                                           .pickImage(
//                                                             source: ImageSource
//                                                                 .gallery,
//                                                           );
//                                                   if (result == null) {
//                                                     return;
//                                                   }

//                                                   var bytes = await result
//                                                       .readAsBytes();
//                                                   var image =
//                                                       await decodeImageFromList(
//                                                         bytes,
//                                                       );

//                                                   var message = types.ImageMessage(
//                                                     author: user,
//                                                     createdAt: DateTime.now()
//                                                         .millisecondsSinceEpoch,
//                                                     height: image.height
//                                                         .toDouble(),
//                                                     id: const Uuid().v4(),
//                                                     name: result.name,
//                                                     size: bytes.length,
//                                                     uri: result.path,
//                                                     width: image.width
//                                                         .toDouble(),
//                                                   );

//                                                   messages.insert(0, message);
//                                                   setState(() {});
//                                                   selectionHaptic();
//                                                 },
//                                                 icon: const Icon(
//                                                   Icons.image_rounded,
//                                                 ),
//                                                 label: Text(
//                                                   AppLocalizations.of(
//                                                     context,
//                                                   ).uploadImage,
//                                                 ),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       );
//                                     },
//                                   );
//                                 },
//                           l10n: chat_ui.ChatL10nEn(
//                             inputPlaceholder: AppLocalizations.of(
//                               context,
//                             ).messageInputPlaceholder,
//                             attachmentButtonAccessibilityLabel:
//                                 AppLocalizations.of(context).tooltipAttachment,
//                             sendButtonAccessibilityLabel: AppLocalizations.of(
//                               context,
//                             ).tooltipSend,
//                           ),
//                           inputOptions: chat_ui.InputOptions(
//                             keyboardType: TextInputType.multiline,
//                             onTextChanged: (p0) {
//                               setState(() {
//                                 sendable = p0.trim().isNotEmpty;
//                               });
//                             },
//                             sendButtonVisibilityMode: desktopFeature()
//                                 ? chat_ui.SendButtonVisibilityMode.always
//                                 : sendable
//                                 ? chat_ui.SendButtonVisibilityMode.always
//                                 : chat_ui.SendButtonVisibilityMode.hidden,
//                           ),
//                           user: user,
//                           hideBackgroundOnEmojiMessages: false,
//                           theme:
//                               (Theme.of(context).brightness == Brightness.light)
//                               ? chat_ui.DefaultChatTheme(
//                                   backgroundColor:
//                                       themeLight().colorScheme.surface,
//                                   primaryColor:
//                                       themeLight().colorScheme.primary,
//                                   attachmentButtonIcon: !multimodal
//                                       ? (prefs?.getBool("voiceModeEnabled") ??
//                                                 false)
//                                             ? Icon(
//                                                 Icons.headphones_rounded,
//                                                 color: Theme.of(
//                                                   context,
//                                                 ).iconTheme.color,
//                                               )
//                                             : null
//                                       : Icon(
//                                           Icons.add_a_photo_rounded,
//                                           color: Theme.of(
//                                             context,
//                                           ).iconTheme.color,
//                                         ),
//                                   sendButtonIcon: SizedBox(
//                                     height: 24,
//                                     child: CircleAvatar(
//                                       backgroundColor: Theme.of(
//                                         context,
//                                       ).iconTheme.color,
//                                       radius: 12,
//                                       child: Icon(
//                                         Icons.arrow_upward_rounded,
//                                         color:
//                                             (prefs?.getBool("useDeviceTheme") ??
//                                                 false)
//                                             ? Theme.of(
//                                                 context,
//                                               ).colorScheme.surface
//                                             : null,
//                                       ),
//                                     ),
//                                   ),
//                                   sendButtonMargin: EdgeInsets.zero,
//                                   attachmentButtonMargin: EdgeInsets.zero,
//                                   inputBackgroundColor: themeLight()
//                                       .colorScheme
//                                       .onSurface
//                                       .withAlpha(10),
//                                   inputTextColor:
//                                       themeLight().colorScheme.onSurface,
//                                   inputBorderRadius: BorderRadius.circular(32),
//                                   inputPadding: const EdgeInsets.all(16),
//                                   inputMargin: EdgeInsets.only(
//                                     left: !desktopFeature(web: true) ? 8 : 6,
//                                     right: !desktopFeature(web: true) ? 8 : 6,
//                                     bottom:
//                                         (MediaQuery.of(
//                                                   context,
//                                                 ).viewInsets.bottom ==
//                                                 0.0 &&
//                                             !desktopFeature(web: true))
//                                         ? 0
//                                         : 8,
//                                   ),
//                                   messageMaxWidth:
//                                       (MediaQuery.of(context).size.width >=
//                                           1000)
//                                       ? (MediaQuery.of(context).size.width >=
//                                                 1600)
//                                             ? (MediaQuery.of(
//                                                         context,
//                                                       ).size.width >=
//                                                       2200)
//                                                   ? 1900
//                                                   : 1300
//                                             : 700
//                                       : 440,
//                                 )
//                               : chat_ui.DarkChatTheme(
//                                   backgroundColor:
//                                       themeDark().colorScheme.surface,
//                                   primaryColor: themeDark().colorScheme.primary
//                                       .withAlpha(40),
//                                   secondaryColor: themeDark()
//                                       .colorScheme
//                                       .primary
//                                       .withAlpha(20),
//                                   attachmentButtonIcon: !multimodal
//                                       ? (prefs?.getBool("voiceModeEnabled") ??
//                                                 false)
//                                             ? Icon(
//                                                 Icons.headphones_rounded,
//                                                 color: Theme.of(
//                                                   context,
//                                                 ).iconTheme.color,
//                                               )
//                                             : null
//                                       : Icon(
//                                           Icons.add_a_photo_rounded,
//                                           color: Theme.of(
//                                             context,
//                                           ).iconTheme.color,
//                                         ),
//                                   sendButtonIcon: SizedBox(
//                                     height: 24,
//                                     child: CircleAvatar(
//                                       backgroundColor: Theme.of(
//                                         context,
//                                       ).iconTheme.color,
//                                       radius: 12,
//                                       child: Icon(
//                                         Icons.arrow_upward_rounded,
//                                         color:
//                                             (prefs?.getBool("useDeviceTheme") ??
//                                                 false)
//                                             ? Theme.of(
//                                                 context,
//                                               ).colorScheme.surface
//                                             : null,
//                                       ),
//                                     ),
//                                   ),
//                                   sendButtonMargin: EdgeInsets.zero,
//                                   attachmentButtonMargin: EdgeInsets.zero,
//                                   inputBackgroundColor: themeDark()
//                                       .colorScheme
//                                       .onSurface
//                                       .withAlpha(40),
//                                   inputTextColor:
//                                       themeDark().colorScheme.onSurface,
//                                   inputBorderRadius: BorderRadius.circular(32),
//                                   inputPadding: const EdgeInsets.all(16),
//                                   inputMargin: EdgeInsets.only(
//                                     left: !desktopFeature(web: true) ? 8 : 6,
//                                     right: !desktopFeature(web: true) ? 8 : 6,
//                                     bottom:
//                                         (MediaQuery.of(
//                                                   context,
//                                                 ).viewInsets.bottom ==
//                                                 0.0 &&
//                                             !desktopFeature(web: true))
//                                         ? 0
//                                         : 8,
//                                   ),
//                                   messageMaxWidth:
//                                       (MediaQuery.of(context).size.width >=
//                                           1000)
//                                       ? (MediaQuery.of(context).size.width >=
//                                                 1600)
//                                             ? (MediaQuery.of(
//                                                         context,
//                                                       ).size.width >=
//                                                       2200)
//                                                   ? 1900
//                                                   : 1300
//                                             : 700
//                                       : 440,
//                                 ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//         drawer: Builder(
//           builder: (context) {
//             if (desktopLayoutRequired(context) && !settingsOpen) {
//               WidgetsBinding.instance.addPostFrameCallback((_) {
//                 if (Navigator.of(context).canPop()) {
//                   Navigator.of(context).pop();
//                 }
//               });
//             }
//             return NavigationDrawer(
//               onDestinationSelected: (value) {
//                 if (value == 1) {
//                 } else if (value == 2) {}
//               },
//               selectedIndex: 1,
//               children: sidebar(context, setState),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

class ScreenMain extends StatefulWidget {
  const ScreenMain({super.key});

  @override
  State<ScreenMain> createState() => _ScreenMainState();
}

class _ScreenMainState extends State<ScreenMain> {
  @override
  void initState() {
    super.initState();

    host = "https://raspimainollama.tunler.net";
    ChatManager.instance.addListener(onUpdate);
    ModelManager.instance.addListener(onUpdate);

    prefsReady.future.then((_) async {
      if (!mounted) return;
      errorGuard(
        context,
        "Q3L4Z1X6",
        () async {
          await ModelManager.instance.loadModels();

          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Models: ${ModelManager.instance.models.length}"),
            ),
          );
        },
        errorMessage: errorGuardErrorMessageWithFallbackSingle(
          OllamaClientException,
          "Unable to load models",
        ),
        enableReporting: false,
      );

      await ChatManager.instance.loadChats();
      if (!mounted) return;
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text("Chats: ${ChatManager.instance.chats.length}")),
      // );
    });
  }

  @override
  void dispose() {
    ChatManager.instance.removeListener(onUpdate);
    ModelManager.instance.removeListener(onUpdate);
    super.dispose();
  }

  void onUpdate() {
    if (mounted) setState(() {});
  }

  bool test = false;
  double testSlider = 0.5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const ListTile(title: ThemeModeSwitch()),
          const ListTile(title: ThemeSwitch()),
          ...ChatManager.instance.chats.map(
            (chat) => ScreenMainChatTile(chat: chat),
          ),
          ListTile(
            title: const Text("Add chat"),
            onTap: () async {
              if (ModelManager.instance.models.isEmpty) return;
              var chat = ChatManager.instance.createChat(
                context: context,
                model: ModelManager.instance.models.first,
              );

              await errorGuard(
                context,
                "M49WC9CW",
                () async {
                  var msg = TextMessage(
                    "Hi!", // "Hello! Please explain what you can do.",
                    sender: MessageSender.user,
                  );
                  return chat.send(msg);
                },
                errorMessage: errorGuardErrorMessageWithFallbackSingle(
                  OllamaClientException,
                  "Unable to send message",
                ),
                enableReporting: false,
              );

              if (!context.mounted || !chat.alive) return;
              await errorGuard(
                context,
                "W97BM0DJ",
                () async => chat.generateTitle(context: context),
                errorMessage: errorGuardErrorMessageWithFallbackSingle(
                  OllamaClientException,
                  "Unable to generate chat title",
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class ScreenMainChatTile extends StatefulWidget {
  final Chat chat;

  const ScreenMainChatTile({super.key, required this.chat});

  @override
  State<ScreenMainChatTile> createState() => _ScreenMainChatTileState();
}

class _ScreenMainChatTileState extends State<ScreenMainChatTile> {
  @override
  void initState() {
    super.initState();
    widget.chat.addListener(onChange);
  }

  @override
  void dispose() {
    widget.chat.removeListener(onChange);
    super.dispose();
  }

  void onChange() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: ChatText(
        widget.chat.title.emptyOn(AppLocalizations.of(context).newChatTitle),
        placeholder: Text(AppLocalizations.of(context).newChatTitle),
      ),
      subtitle: (widget.chat.messages.isEmpty)
          ? const SizedBox.shrink()
          : ChatText(
              (widget.chat.messages.last as TextMessage).content,
              placeholder: const Text("<incoming>"),
            ),
      onTap: () => ChatManager.instance.deleteChat(widget.chat),
    );
  }
}

extension on String {
  String emptyOn(String other) => (this == other) ? "" : this;
}
