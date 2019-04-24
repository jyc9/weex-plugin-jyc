//
//  BHWeexURLActionRequestMiddleware.m
//  Pods
//
//  Created by 姚晨峰 on 2019/4/15.
//

#import "BHWeexURLActionRequestMiddleware.h"
#import <BeeKit/BeeKit.h>
#import "BHWXBaseViewController.h"
#import "JYCWeexSDK.h"
@interface BHWeexURLActionRequestMiddleware()<BHURLActionRequestMiddleware>
@end
@implementation BHWeexURLActionRequestMiddleware
+(void)initialize{
     [JYCWeexSDK initWeexSDK];
}
-(BHURLActionResponse *)processURLActionRequest:(BHURLActionRequest *)request{
    if(request.query[@"_wx_tpl"] || [request.query[@"_wh_weex"] isEqualToString:@"true"]){
        BHWXBaseViewController *jyc = [[BHWXBaseViewController alloc] initWithSourceURL:request.url];
        return [[BHURLActionResponse alloc] initWithViewController:jyc];
    }
    return nil;
}
@end
