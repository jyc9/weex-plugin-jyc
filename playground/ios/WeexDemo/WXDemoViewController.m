//
//  WXDemoViewController.m
//  WeexDemo
//
//  Created by 姚晨峰 on 2019/4/3.
//  Copyright © 2019 taobao. All rights reserved.
//

#import "WXDemoViewController.h"
#import "DemoDefine.h"
#import <WeexPluginJyc/BHWXBaseViewController.h>
#import "UIViewController+WXDemoNaviBar.h"
@interface WXDemoViewController ()<BHURLRouterHandlerProtocol>

@end

@implementation WXDemoViewController
+(id)handlerForRequest:(BHURLActionRequest *)request{
    NSURL *url = nil;
#if DEBUG
    //If you are debugging in device , please change the host to current IP of your computer.
    url = [NSURL URLWithString:HOME_URL];
#else
    url = [NSURL URLWithString:BUNDLE_URL];
#endif
    BHWXBaseViewController *demo = [[BHWXBaseViewController alloc] initWithSourceURL:url];
    demo.title = @"demo";
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [demo setupNaviBar];
    });
    return demo;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
