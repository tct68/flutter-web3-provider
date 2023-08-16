library web3_provider;

import 'dart:collection';
import 'dart:io';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'json_util.dart';

enum EIP1193 {
  requestAccounts,

  signTransaction,

  signMessage,

  signPersonalMessage,

  signTypedMessage,

  addEthereumChain,
}

class InAppWebViewEIP1193 extends StatefulWidget {
  const InAppWebViewEIP1193({
    Key? key,
    required this.signCallback,
    this.customPathProvider,
    this.customWalletName = 'posiwallet',
    this.rpcUrl,
    this.chainId,
    this.walletAddress,
    this.isDebug = true,
    this.windowId,
    this.initialUrlRequest,
    this.initialFile,
    this.initialData,
    this.initialOptions,
    this.initialUserScripts,
    this.pullToRefreshController,
    this.implementation = WebViewImplementation.NATIVE,
    this.contextMenu,
    this.onWebViewCreated,
    this.onLoadStart,
    this.onLoadStop,
    this.onLoadError,
    this.onLoadHttpError,
    this.onConsoleMessage,
    this.onProgressChanged,
    this.shouldOverrideUrlLoading,
    this.onLoadResource,
    this.onScrollChanged,
    this.onDownloadStartRequest,
    this.onLoadResourceCustomScheme,
    this.onCreateWindow,
    this.onCloseWindow,
    this.onJsAlert,
    this.onJsConfirm,
    this.onJsPrompt,
    this.onReceivedHttpAuthRequest,
    this.onReceivedServerTrustAuthRequest,
    this.onReceivedClientCertRequest,
    this.onFindResultReceived,
    this.shouldInterceptAjaxRequest,
    this.onAjaxReadyStateChange,
    this.onAjaxProgress,
    this.shouldInterceptFetchRequest,
    this.onUpdateVisitedHistory,
    this.onPrint,
    this.onLongPressHitTestResult,
    this.onEnterFullscreen,
    this.onExitFullscreen,
    this.onPageCommitVisible,
    this.onTitleChanged,
    this.onWindowFocus,
    this.onWindowBlur,
    this.onOverScrolled,
    this.onZoomScaleChanged,
    this.androidOnSafeBrowsingHit,
    this.androidOnPermissionRequest,
    this.androidOnGeolocationPermissionsShowPrompt,
    this.androidOnGeolocationPermissionsHidePrompt,
    this.androidShouldInterceptRequest,
    this.androidOnRenderProcessGone,
    this.androidOnRenderProcessResponsive,
    this.androidOnRenderProcessUnresponsive,
    this.androidOnFormResubmission,
    this.androidOnReceivedIcon,
    this.androidOnReceivedTouchIconUrl,
    this.androidOnJsBeforeUnload,
    this.androidOnReceivedLoginRequest,
    this.iosOnWebContentProcessDidTerminate,
    this.iosOnDidReceiveServerRedirectForProvisionalNavigation,
    this.iosOnNavigationResponse,
    this.iosShouldAllowDeprecatedTLS,
    this.gestureRecognizers,
    this.customConfigFunction,
  }) : super(key: key);

  final String? customPathProvider;

  final String? customWalletName;

  final String? customConfigFunction;

  final String? rpcUrl;

  final int? chainId;

  final String? walletAddress;
  final bool isDebug;

  final Function(Map<dynamic, dynamic> rawData, EIP1193 eip1193,
      InAppWebViewController? controller) signCallback;

  final Set<Factory<OneSequenceGestureRecognizer>>? gestureRecognizers;

  final int? windowId;

  final void Function(InAppWebViewController controller)? onWebViewCreated;

  final void Function(InAppWebViewController controller, Uri? url)? onLoadStart;

  final void Function(InAppWebViewController controller, Uri? url)? onLoadStop;

  final void Function(InAppWebViewController controller, Uri? url, int code,
      String message)? onLoadError;

  final void Function(InAppWebViewController controller, Uri? url,
      int statusCode, String description)? onLoadHttpError;

  final void Function(InAppWebViewController controller, int progress)?
      onProgressChanged;

  final void Function(
          InAppWebViewController controller, ConsoleMessage consoleMessage)?
      onConsoleMessage;

  final Future<NavigationActionPolicy?> Function(
          InAppWebViewController controller, NavigationAction navigationAction)?
      shouldOverrideUrlLoading;

  final void Function(
          InAppWebViewController controller, LoadedResource resource)?
      onLoadResource;

  final void Function(InAppWebViewController controller, int x, int y)?
      onScrollChanged;

  final void Function(InAppWebViewController controller,
      DownloadStartRequest downloadStartRequest)? onDownloadStartRequest;

  final Future<CustomSchemeResponse?> Function(
      InAppWebViewController controller, Uri url)? onLoadResourceCustomScheme;

  final Future<bool?> Function(InAppWebViewController controller,
      CreateWindowAction createWindowAction)? onCreateWindow;

  final void Function(InAppWebViewController controller)? onCloseWindow;

  final void Function(InAppWebViewController controller)? onWindowFocus;

  final void Function(InAppWebViewController controller)? onWindowBlur;

  final Future<JsAlertResponse?> Function(
          InAppWebViewController controller, JsAlertRequest jsAlertRequest)?
      onJsAlert;

  final Future<JsConfirmResponse?> Function(
          InAppWebViewController controller, JsConfirmRequest jsConfirmRequest)?
      onJsConfirm;

  final Future<JsPromptResponse?> Function(
          InAppWebViewController controller, JsPromptRequest jsPromptRequest)?
      onJsPrompt;

  final Future<HttpAuthResponse?> Function(InAppWebViewController controller,
      URLAuthenticationChallenge challenge)? onReceivedHttpAuthRequest;

  final Future<ServerTrustAuthResponse?> Function(
      InAppWebViewController controller,
      URLAuthenticationChallenge challenge)? onReceivedServerTrustAuthRequest;

  final Future<ClientCertResponse?> Function(InAppWebViewController controller,
      URLAuthenticationChallenge challenge)? onReceivedClientCertRequest;

  final void Function(InAppWebViewController controller, int activeMatchOrdinal,
      int numberOfMatches, bool isDoneCounting)? onFindResultReceived;

  final Future<AjaxRequest?> Function(
          InAppWebViewController controller, AjaxRequest ajaxRequest)?
      shouldInterceptAjaxRequest;

  final Future<AjaxRequestAction?> Function(
          InAppWebViewController controller, AjaxRequest ajaxRequest)?
      onAjaxReadyStateChange;

  final Future<AjaxRequestAction> Function(
          InAppWebViewController controller, AjaxRequest ajaxRequest)?
      onAjaxProgress;

  final Future<FetchRequest?> Function(
          InAppWebViewController controller, FetchRequest fetchRequest)?
      shouldInterceptFetchRequest;

  final void Function(
          InAppWebViewController controller, Uri? url, bool? androidIsReload)?
      onUpdateVisitedHistory;

  final void Function(InAppWebViewController controller, Uri? url)? onPrint;

  final void Function(InAppWebViewController controller,
      InAppWebViewHitTestResult hitTestResult)? onLongPressHitTestResult;

  final void Function(InAppWebViewController controller)? onEnterFullscreen;

  final void Function(InAppWebViewController controller)? onExitFullscreen;

  final void Function(InAppWebViewController controller, Uri? url)?
      onPageCommitVisible;

  final void Function(InAppWebViewController controller, String? title)?
      onTitleChanged;

  final void Function(InAppWebViewController controller, int x, int y,
      bool clampedX, bool clampedY)? onOverScrolled;

  final void Function(
          InAppWebViewController controller, double oldScale, double newScale)?
      onZoomScaleChanged;

  final Future<SafeBrowsingResponse?> Function(
      InAppWebViewController controller,
      Uri url,
      SafeBrowsingThreat? threatType)? androidOnSafeBrowsingHit;

  final Future<PermissionRequestResponse?> Function(
      InAppWebViewController controller,
      String origin,
      List<String> resources)? androidOnPermissionRequest;

  final Future<GeolocationPermissionShowPromptResponse?> Function(
          InAppWebViewController controller, String origin)?
      androidOnGeolocationPermissionsShowPrompt;

  final void Function(InAppWebViewController controller)?
      androidOnGeolocationPermissionsHidePrompt;

  final Future<WebResourceResponse?> Function(
          InAppWebViewController controller, WebResourceRequest request)?
      androidShouldInterceptRequest;

  final Future<WebViewRenderProcessAction?> Function(
          InAppWebViewController controller, Uri? url)?
      androidOnRenderProcessUnresponsive;

  final Future<WebViewRenderProcessAction?> Function(
          InAppWebViewController controller, Uri? url)?
      androidOnRenderProcessResponsive;

  final void Function(
          InAppWebViewController controller, RenderProcessGoneDetail detail)?
      androidOnRenderProcessGone;

  final Future<FormResubmissionAction?> Function(
      InAppWebViewController controller, Uri? url)? androidOnFormResubmission;

  final void Function(InAppWebViewController controller, Uint8List icon)?
      androidOnReceivedIcon;

  final void Function(
          InAppWebViewController controller, Uri url, bool precomposed)?
      androidOnReceivedTouchIconUrl;

  final Future<JsBeforeUnloadResponse?> Function(
      InAppWebViewController controller,
      JsBeforeUnloadRequest jsBeforeUnloadRequest)? androidOnJsBeforeUnload;

  final void Function(
          InAppWebViewController controller, LoginRequest loginRequest)?
      androidOnReceivedLoginRequest;

  final void Function(InAppWebViewController controller)?
      iosOnWebContentProcessDidTerminate;

  final void Function(InAppWebViewController controller)?
      iosOnDidReceiveServerRedirectForProvisionalNavigation;

  final Future<IOSNavigationResponseAction?> Function(
      InAppWebViewController controller,
      IOSWKNavigationResponse navigationResponse)? iosOnNavigationResponse;

  final Future<IOSShouldAllowDeprecatedTLSAction?> Function(
      InAppWebViewController controller,
      URLAuthenticationChallenge challenge)? iosShouldAllowDeprecatedTLS;

  final URLRequest? initialUrlRequest;

  final String? initialFile;

  final InAppWebViewInitialData? initialData;

  final InAppWebViewGroupOptions? initialOptions;

  final ContextMenu? contextMenu;

  final UnmodifiableListView<UserScript>? initialUserScripts;

  final PullToRefreshController? pullToRefreshController;

  final WebViewImplementation implementation;

  @override
  State<InAppWebViewEIP1193> createState() => _InAppWebViewEIP1193State();
}

class _InAppWebViewEIP1193State extends State<InAppWebViewEIP1193> {
  String? jsProviderScript;

  bool isLoadJs = false;
  InAppWebViewController? _webViewController;

  @override
  void initState() {
    super.initState();
    _loadWeb3();
  }

  Future<void> _loadWeb3() async {
    String? web3;
    String path = widget.customPathProvider ??
        'packages/web3_provider/assets/posi.min.js';
    web3 = await DefaultAssetBundle.of(context).loadString(path);
    if (mounted) {
      setState(() {
        jsProviderScript = web3;
        isLoadJs = true;
      });
    }
  }

  String _getFunctionInject() {
    var paramConfig = widget.customConfigFunction ??
        """{
              ethereum: {
                chainId: ${widget.chainId},
                rpcUrl: "${widget.rpcUrl}",
                address: "${widget.walletAddress}",
                isDebug: ${widget.isDebug}  
              }
            }""";

    var config = """
         (function() {
           var config = $paramConfig;
            window.ethereum = new ${widget.customWalletName}.Provider(config);
            ${widget.customWalletName}.postMessage = (jsonString) => {
               if (window.flutter_inappwebview.callHandler) {
                  window.flutter_inappwebview.callHandler('handleRequestEIP1193', JSON.stringify(jsonString));
               }
            };
        })();
        """;
    return config;
  }

  Future<void> _jsBridgeCallBack(String message) async {
    Map<dynamic, dynamic> rawData = JsonUtil.getObj(message);
    final name = rawData["name"];
    if (name == 'requestAccounts' || name == 'eth_requestAccounts') {
      widget.signCallback(rawData, EIP1193.requestAccounts, _webViewController);
    } else if (name == 'signTransaction' ||
        name == 'signMessage' ||
        name == 'signPersonalMessage' ||
        name == 'signTypedMessage') {
      if (name == 'signTransaction') {
        widget.signCallback(
            rawData, EIP1193.signTransaction, _webViewController);
      } else if (name == 'signMessage') {
        widget.signCallback(rawData, EIP1193.signMessage, _webViewController);
      } else if (name == 'signPersonalMessage') {
        widget.signCallback(
            rawData, EIP1193.signPersonalMessage, _webViewController);
      } else if (name == 'signTypedMessage') {
        widget.signCallback(
            rawData, EIP1193.signTypedMessage, _webViewController);
      }
    } else {
      widget.signCallback(
          rawData, EIP1193.addEthereumChain, _webViewController);
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoadJs == false
        ? Container()
        : InAppWebView(
            windowId: widget.windowId,
            initialUrlRequest: widget.initialUrlRequest,
            initialFile: widget.initialFile,
            initialData: widget.initialData,
            initialOptions: widget.initialOptions,
            initialUserScripts: widget.initialUserScripts ??
                (isLoadJs == true
                    ? UnmodifiableListView([
                        UserScript(
                          source: jsProviderScript ?? '',
                          injectionTime:
                              UserScriptInjectionTime.AT_DOCUMENT_START,
                        ),
                        UserScript(
                          source: _getFunctionInject(),
                          injectionTime:
                              UserScriptInjectionTime.AT_DOCUMENT_START,
                        ),
                      ])
                    : null),
            pullToRefreshController: widget.pullToRefreshController,
            implementation: widget.implementation,
            contextMenu: widget.contextMenu,
            onWebViewCreated: (controller) async {
              _webViewController = controller;
              controller.addJavaScriptHandler(
                handlerName: 'handleRequestEIP1193',
                callback: (args) {
                  _jsBridgeCallBack(args[0]);
                },
              );
              widget.onWebViewCreated?.call(controller);
            },
            onLoadStart: (controller, url) async {
              widget.onLoadStart?.call(controller, url);
              if (Platform.isAndroid) {
                await _webViewController?.evaluateJavascript(
                  source: jsProviderScript ?? '',
                );
                await _webViewController?.evaluateJavascript(
                  source: _getFunctionInject(),
                );
              }
            },
            onLoadStop: widget.onLoadStop,
            onLoadError: widget.onLoadError,
            onLoadHttpError: widget.onLoadHttpError,
            onConsoleMessage: widget.onConsoleMessage,
            onProgressChanged: widget.onProgressChanged,
            shouldOverrideUrlLoading: widget.shouldOverrideUrlLoading,
            onLoadResource: widget.onLoadResource,
            onScrollChanged: widget.onScrollChanged,
            onDownloadStartRequest: widget.onDownloadStartRequest,
            onLoadResourceCustomScheme: widget.onLoadResourceCustomScheme,
            onCreateWindow: widget.onCreateWindow,
            onCloseWindow: widget.onCloseWindow,
            onJsAlert: widget.onJsAlert,
            onJsConfirm: widget.onJsConfirm,
            onJsPrompt: widget.onJsPrompt,
            onReceivedHttpAuthRequest: widget.onReceivedHttpAuthRequest,
            onReceivedServerTrustAuthRequest:
                widget.onReceivedServerTrustAuthRequest,
            onReceivedClientCertRequest: widget.onReceivedClientCertRequest,
            onFindResultReceived: widget.onFindResultReceived,
            shouldInterceptAjaxRequest: widget.shouldInterceptAjaxRequest,
            onAjaxReadyStateChange: widget.onAjaxReadyStateChange,
            onAjaxProgress: widget.onAjaxProgress,
            shouldInterceptFetchRequest: widget.shouldInterceptFetchRequest,
            onUpdateVisitedHistory: widget.onUpdateVisitedHistory,
            onPrint: widget.onPrint,
            onLongPressHitTestResult: widget.onLongPressHitTestResult,
            onEnterFullscreen: widget.onEnterFullscreen,
            onExitFullscreen: widget.onExitFullscreen,
            onPageCommitVisible: widget.onPageCommitVisible,
            onTitleChanged: widget.onTitleChanged,
            onWindowFocus: widget.onWindowFocus,
            onWindowBlur: widget.onWindowBlur,
            onOverScrolled: widget.onOverScrolled,
            onZoomScaleChanged: widget.onZoomScaleChanged,
            androidOnSafeBrowsingHit: widget.androidOnSafeBrowsingHit,
            androidOnPermissionRequest: widget.androidOnPermissionRequest ??
                (controller, origin, resources) async {
                  return PermissionRequestResponse(
                    resources: resources,
                    action: PermissionRequestResponseAction.GRANT,
                  );
                },
            androidOnGeolocationPermissionsShowPrompt:
                widget.androidOnGeolocationPermissionsShowPrompt,
            androidOnGeolocationPermissionsHidePrompt:
                widget.androidOnGeolocationPermissionsHidePrompt,
            androidShouldInterceptRequest: widget.androidShouldInterceptRequest,
            androidOnRenderProcessGone: widget.androidOnRenderProcessGone,
            androidOnRenderProcessResponsive:
                widget.androidOnRenderProcessResponsive,
            androidOnRenderProcessUnresponsive:
                widget.androidOnRenderProcessUnresponsive,
            androidOnFormResubmission: widget.androidOnFormResubmission,
            androidOnReceivedIcon: widget.androidOnReceivedIcon,
            androidOnReceivedTouchIconUrl: widget.androidOnReceivedTouchIconUrl,
            androidOnJsBeforeUnload: widget.androidOnJsBeforeUnload,
            androidOnReceivedLoginRequest: widget.androidOnReceivedLoginRequest,
            iosOnWebContentProcessDidTerminate:
                widget.iosOnWebContentProcessDidTerminate,
            iosOnDidReceiveServerRedirectForProvisionalNavigation:
                widget.iosOnDidReceiveServerRedirectForProvisionalNavigation,
            iosOnNavigationResponse: widget.iosOnNavigationResponse,
            iosShouldAllowDeprecatedTLS: widget.iosShouldAllowDeprecatedTLS,
            gestureRecognizers: widget.gestureRecognizers,
          );
  }
}
