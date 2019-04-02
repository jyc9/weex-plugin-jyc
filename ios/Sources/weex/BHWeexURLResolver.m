//
//  BHWeexURLResolver.m
//  Pods
//
//  Created by 姚晨峰 on 2019/4/1.
//

#import "BHWeexURLResolver.h"
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
    return nil;
}
@end
