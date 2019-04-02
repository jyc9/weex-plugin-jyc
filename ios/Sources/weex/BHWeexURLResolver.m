//
//  BHWeexURLResolver.m
//  Pods
//
//  Created by 姚晨峰 on 2019/4/1.
//

#import "BHWeexURLResolver.h"
#import "BHWXBaseViewController.h"
#import <BeeKit/BeeKit.h>
#import "JYCWeexSDK.h"
@interface BHWeexURLResolver()<BHURLRouterHandlerProtocol>
@end
@implementation BHWeexURLResolver
+(id)handlerForRequest:(BHURLActionRequest *)request{
    [JYCWeexSDK initWeexSDK];
    return [BHWeexURLResolver new];
}
-(id)handlerForRequest:(BHURLActionRequest *)request{
    BHWXBaseViewController *jyc = [[BHWXBaseViewController alloc] initWithSourceURL:request.url];
    return [[BHURLActionResponse alloc] initWithViewController:jyc];
}
@end
