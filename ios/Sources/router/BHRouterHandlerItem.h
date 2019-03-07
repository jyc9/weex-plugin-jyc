//
//  BHRouterHandlerItem.h
//  Pods
//
//  Created by 姚晨峰 on 2019/3/7.
//

#import <Foundation/Foundation.h>
#import "BHRouterProtocol.h"
NS_ASSUME_NONNULL_BEGIN

@interface BHRouterHandlerItem : NSObject<BHRouterHandleProtocol>
/** 处理url的类 */
@property (nonatomic, copy, readonly) NSString *handlerString;
@property (nonatomic, copy, readonly) NSString *url;
/** 是否是单例 */
@property (nonatomic, assign, readonly) BOOL isSingleton;
-(NSString *)hostAndPathWithURL:(NSURL *)url;
@end

NS_ASSUME_NONNULL_END
