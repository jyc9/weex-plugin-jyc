//
//  BHNavigationController.m
//  Pods
//
//  Created by 姚晨峰 on 2019/4/2.
//

#import "BHNavigationController.h"

@interface BHNavigationController ()

@end

@implementation BHNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if(self.viewControllers.count>0){
        viewController.hidesBottomBarWhenPushed = true;
    }
    [super pushViewController:viewController animated:animated];
}
@end
