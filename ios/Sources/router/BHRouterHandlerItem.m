//
//  BHRouterHandlerItem.m
//  Pods
//
//  Created by 姚晨峰 on 2019/3/7.
//

#import "BHRouterHandlerItem.h"

@implementation BHRouterHandlerItem
-(NSString *)hostAndPathWithURL:(NSURL *)url{
    return [NSString stringWithFormat:@"%@%@",url.host,url.path];;
}
- (BOOL)canHandleURL:(nonnull NSURL *)url {
    return false;
}

@end
