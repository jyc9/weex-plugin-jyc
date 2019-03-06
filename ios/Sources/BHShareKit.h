//
//  BHShareKit.h
//  BHKit
//
//  Created by 姚晨峰 on 2019/1/24.
//  Copyright © 2019 姚晨峰. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

@interface BHShareKit : NSObject
+(instancetype) sharedKit;
-(BOOL)canHandleUrl:(NSURL *)url;
-(void)openUrl:(NSURL *)url;
-(void)openUrlString:(NSString *)urlString;

/** 初始化weexSDK */
+ (void)initWeexSDK;
@end

NS_ASSUME_NONNULL_END
