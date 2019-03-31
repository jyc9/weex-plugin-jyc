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
    [self setViewControllers:arrs animated:false];
}

@end
