#import "BHWXBaseViewController.h"
#import <WeexSDK/WeexSDK.h>
@interface BHWXBaseViewController ()

@property (nonatomic, strong) WXSDKInstance *instance;
@property (nonatomic, strong) UIView *weexView;
@property (nonatomic, strong) NSURL *sourceURL;
@property (nonatomic, strong) NSURL *oriURL;
@end

@implementation BHWXBaseViewController

- (void)dealloc
{
    [_instance destroyInstance];
    [self _removeObservers];
}

- (instancetype)initWithSourceURL:(NSURL *)sourceURL
{
    if ((self = [super init])) {
        self.oriURL = sourceURL;
        self.sourceURL = [self testURL:sourceURL];
        
        [self _addObservers];
    }
    return self;
}

/**
 *  After setting the navbar hidden status , this function will be called automatically. In this function, we
 *  set the height of mainView equal to screen height, because there is something wrong with the layout of
 *  page content.
 */

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    //调整weex大小
    UIEdgeInsets safeArea = UIEdgeInsetsZero;
    if (@available(iOS 11.0, *)) {
        safeArea = self.view.safeAreaInsets;
    } else {
        // Fallback on earlier versions
    }
    CGFloat weexHeight = self.view.bounds.size.height - safeArea.top - safeArea.bottom;
    self.weexView.frame = CGRectMake(safeArea.left, safeArea.top, self.view.frame.size.width-safeArea.left-safeArea.right, weexHeight);
}
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.instance.frame = self.weexView.frame;
}

/**
 *  We assume that the initial state of viewController's navigtionBar is hidden.  By setting the attribute of
 *  'dataRole' equal to 'navbar', the navigationBar hidden will be NO.
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self _renderWithURL:_sourceURL];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self _updateInstanceState:WeexInstanceAppear];
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self _updateInstanceState:WeexInstanceDisappear];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    [self _updateInstanceState:WeexInstanceMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)refreshWeex
{
    [self _renderWithURL:_sourceURL];
}


- (void)addEdgePop
{
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

- (void)_renderWithURL:(NSURL *)sourceURL
{
    if (!sourceURL) {
        return;
    }
    
    [_instance destroyInstance];
    _instance = [[WXSDKInstance alloc] init];
    if([WXPrerenderManager isTaskReady:[self.sourceURL absoluteString]]){
        _instance = [WXPrerenderManager instanceFromUrl:self.sourceURL.absoluteString];
    }
    _instance.frame = self.view.frame;
    _instance.pageObject = self;
    _instance.pageName = sourceURL.absoluteString;
    _instance.viewController = self;
    
    NSString *newURL = nil;
    
    if ([sourceURL.absoluteString rangeOfString:@"?"].location != NSNotFound) {
        newURL = [NSString stringWithFormat:@"%@&random=%d", sourceURL.absoluteString, arc4random()];
    } else {
        newURL = [NSString stringWithFormat:@"%@?random=%d", sourceURL.absoluteString, arc4random()];
    }
    
    __weak typeof(self) weakSelf = self;
    _instance.onCreate = ^(UIView *view) {
        [weakSelf.weexView removeFromSuperview];
        weakSelf.weexView = view;
        [weakSelf.view addSubview:weakSelf.weexView];
    };
    
    _instance.onFailed = ^(NSError *error) {
        if ([[error domain] isEqualToString:@"1"]) {
#if DEBUG
            dispatch_async(dispatch_get_main_queue(), ^{
                NSMutableString *errMsg=[NSMutableString new];
                [errMsg appendFormat:@"ErrorType:%@\n",[error domain]];
                [errMsg appendFormat:@"ErrorCode:%ld\n",(long)[error code]];
                [errMsg appendFormat:@"ErrorInfo:%@\n", [error userInfo]];
                
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"render failed" message:errMsg delegate:weakSelf cancelButtonTitle:nil otherButtonTitles:@"ok", nil];
                [alertView show];
            });
#endif
        }
    };
    
    _instance.renderFinish = ^(UIView *view) {
        [weakSelf _updateInstanceState:WeexInstanceAppear];
    };
    
    [_instance renderWithURL:[NSURL URLWithString:newURL] options:@{@"bundleUrl":sourceURL.absoluteString} data:nil];
    
    if([WXPrerenderManager isTaskReady:[self.sourceURL absoluteString]]){
        WX_MONITOR_INSTANCE_PERF_START(WXPTJSDownload, _instance);
        WX_MONITOR_INSTANCE_PERF_END(WXPTJSDownload, _instance);
        WX_MONITOR_INSTANCE_PERF_START(WXPTFirstScreenRender, _instance);
        WX_MONITOR_INSTANCE_PERF_START(WXPTAllRender, _instance);
        [WXPrerenderManager renderFromCache:[self.sourceURL absoluteString]];
        return;
    }
}
- (NSURL*)testURL:(NSURL*)url
{
    NSString *wx_tpl = url.absoluteString;
    NSRange range = [url.absoluteString rangeOfString:@"_wx_tpl"];
    if (range.location != NSNotFound) {
        NSCharacterSet* delimiterSet = [NSCharacterSet characterSetWithCharactersInString:@"&"];
        NSMutableDictionary* pairs = [NSMutableDictionary dictionary];
        NSScanner* scanner = [[NSScanner alloc] initWithString:url.query ?: @""];
        while (![scanner isAtEnd]) {
            NSString* pairString = nil;
            [scanner scanUpToCharactersFromSet:delimiterSet intoString:&pairString];
            [scanner scanCharactersFromSet:delimiterSet intoString:NULL];
            NSArray* kvPair = [pairString componentsSeparatedByString:@"="];
            if (kvPair.count == 2) {
                NSString* key = [kvPair objectAtIndex:0];
                NSString* value = [kvPair objectAtIndex:1];
                if([key isEqualToString:@"_wx_tpl"]){
                    wx_tpl = [value stringByRemovingPercentEncoding];
                }else{
                    [pairs setObject:value forKey:key];
                }
            }
        }
        NSArray<NSString *> *keys = pairs.allKeys;
        for (int i = 0; i<keys.count; i++) {
            if (i == 0) {
                wx_tpl = [wx_tpl stringByAppendingString:[NSString stringWithFormat:@"?%@=%@",keys[i],pairs[keys[i]]]];
            }else{
                wx_tpl = [wx_tpl stringByAppendingString:[NSString stringWithFormat:@"&%@=%@",keys[i],pairs[keys[i]]]];
            }
        }
        
    }
    return [NSURL URLWithString:wx_tpl];
}

- (void)_updateInstanceState:(WXState)state
{
    if (_instance && _instance.state != state) {
        _instance.state = state;
        
        if (state == WeexInstanceAppear) {
            [[WXSDKManager bridgeMgr] fireEvent:_instance.instanceId ref:WX_SDK_ROOT_REF type:@"viewappear" params:nil domChanges:nil];
        } else if (state == WeexInstanceDisappear) {
            [[WXSDKManager bridgeMgr] fireEvent:_instance.instanceId ref:WX_SDK_ROOT_REF type:@"viewdisappear" params:nil domChanges:nil];
        }
    }
}

- (void)_appStateDidChange:(NSNotification *)notify
{
    if ([notify.name isEqualToString:@"UIApplicationDidBecomeActiveNotification"]) {
        [self _updateInstanceState:WeexInstanceForeground];
    } else if([notify.name isEqualToString:@"UIApplicationDidEnterBackgroundNotification"]) {
        [self _updateInstanceState:WeexInstanceBackground]; ;
    }
}

- (void)_addObservers
{
    for (NSString *name in @[UIApplicationDidBecomeActiveNotification,
                             UIApplicationDidEnterBackgroundNotification]) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(_appStateDidChange:)
                                                     name:name
                                                   object:nil];
    }
}

- (void)_removeObservers
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
