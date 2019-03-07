//
//  BHDefine.h
//  BHKit
//
//  Created by 姚晨峰 on 2019/1/24.
//  Copyright © 2019 姚晨峰. All rights reserved.
//

#ifndef BHDefine_h
#define BHDefine_h
//.h头文件中的单例宏
#define BHSingletonH(name) + (instancetype)shared##name;
#if __has_feature(objc_arc) //ARC
//.m文件中的单例宏
#define BHSingletonM(name) \
static id _instance;\
+ (instancetype)allocWithZone:(struct _NSZone *)zone{\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
_instance = [super allocWithZone:zone];\
});\
return _instance;\
}\
+ (instancetype)shared##name{\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
_instance = [[self alloc] init];\
});\
return _instance;\
}\
- (id)copyWithZone:(NSZone *)zone{\
return _instance;\
}
#else   //MRC
#endif
#endif /* BHDefine_h */
