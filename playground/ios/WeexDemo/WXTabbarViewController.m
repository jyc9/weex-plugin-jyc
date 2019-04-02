//
//  WXTabbarViewController.m
//  WeexDemo
//
//  Created by yaochenfeng on 2019/3/31.
//  Copyright © 2019 taobao. All rights reserved.
//

#import "WXTabbarViewController.h"

@interface WXTabbarViewController ()

@end

@implementation WXTabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSMutableArray *arrs = [NSMutableArray array];
    for (int i = 0; i<4; i++) {
        UIViewController *vc = [[BHShareKit sharedKit] viewControllerForURL:[NSURL URLWithString:[NSString stringWithFormat:@"app://app/root/tabbar%d",i]]];
        if(vc){
            [arrs addObject:[[UINavigationController alloc] initWithRootViewController:vc]];
        }
    }
    UIViewController *tripvc = [[BHShareKit sharedKit] viewControllerForURL:[NSURL URLWithString:@"https://h5.m.taobao.com/trip/weex-ui/index.html?_wx_tpl=https%3A%2F%2Fh5.m.taobao.com%2Ftrip%2Fweex-ui%2Fdemo%2Findex.native-min.js"]];
    if(tripvc){
        tripvc.title = @"weex";
        tripvc.tabBarItem.title = @"weexui";
        [arrs addObject:[[UINavigationController alloc] initWithRootViewController:tripvc]];
    }
    [self setViewControllers:arrs animated:false];
}

@end
