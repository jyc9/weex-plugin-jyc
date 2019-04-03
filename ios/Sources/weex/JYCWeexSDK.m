//
//  JYCWeexSDK.m
//  Pods
//
//  Created by 姚晨峰 on 2019/3/6.
//

#import "JYCWeexSDK.h"
#import <WeexSDK/WeexSDK.h>
#import <BeeKit/BeeKit.h>
@implementation JYCWeexSDK
+ (void)initWeexSDK{
    [WXSDKEngine initSDKEnvironment];
    //主程序中的weex自主配置
    NSString *configFile = [[NSBundle mainBundle] pathForResource:@"weexSDK" ofType:@"plist"];
    if(!configFile){
        configFile = [[NSBundle mainBundle] pathForResource:@"jycKit.bundle/weexSDK" ofType:@"plist"];
    }
    if(!configFile){//framework中
        configFile = [[NSBundle bundleForClass:[self class]] pathForResource:@"jycKit.bundle/weexSDK" ofType:@"plist"];
    }
    if (configFile) {
        NSDictionary *weexDict = [NSDictionary dictionaryWithContentsOfFile:configFile];
        NSArray *handlers = [weexDict mutableArrayValueForKey:@"handlers"];
        for (NSDictionary *item in handlers) {
            NSString *proName = item[@"protocol"];
            Protocol *pro =  NSProtocolFromString(proName);
            if(pro){
                id obj = [[BHShareKit sharedKit] objectForSerivce:pro];
                if(obj){
                    [WXSDKEngine registerHandler:obj withProtocol:pro];
                }
            }
        }
        NSArray *components = [weexDict mutableArrayValueForKey:@"components"];
        for (NSDictionary *item in components) {
            NSString *name = item[@"name"];
            NSString *proImplName = item[@"Impl"];
            Class handle =  NSClassFromString(proImplName);
            if(handle&&name){
                [WXSDKEngine registerComponent:name withClass:handle];
            }
        }
        NSArray *modules = [weexDict mutableArrayValueForKey:@"modules"];
        for (NSDictionary *item in modules) {
            NSString *name = item[@"name"];
            NSString *proImplName = item[@"Impl"];
            Class handle =  NSClassFromString(proImplName);
            if(handle&&name){
                [WXSDKEngine registerModule:name withClass:handle];
            }
        }
    }
}
@end
