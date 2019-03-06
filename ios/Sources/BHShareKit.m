//
//  BHShareKit.m
//  BHKit
//
//  Created by 姚晨峰 on 2019/1/24.
//  Copyright © 2019 姚晨峰. All rights reserved.
//
/* 应用程序常见对象类型
 * object(name class is_singleton) 名称 类名 是否单例
 * service 实现了协议的obj
 * handler 处理url(regex_url exact_url object)#类名
 */
#import "BHShareKit.h"
#import "BHDefine.h"
#import "JYCWeexSDK.h"
@interface BHShareKit()

@end
@implementation BHShareKit
BHSingletonM(Kit)

+ (void)initWeexSDK{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [JYCWeexSDK initWeexSDK];
    });
}
-(void)openUrlString:(NSString *)urlString{
    [self openUrl:[NSURL URLWithString:urlString]];
}
-(BOOL)canHandleUrl:(NSURL *)url{
    return false;
}
-(void)openUrl:(NSURL *)url{
}
-(instancetype)init{
    if(self = [super init]){
    }
    return self;
}
@end
