//
//  BHRouterProtocols.h
//  Pods
//
//  Created by 姚晨峰 on 2019/3/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BHRouterRequestProtocol <NSObject>
@property (nonatomic, assign) BOOL isRedirect;
@property (nonatomic, strong, readonly) NSURL *url;
@property (nonatomic, strong, readonly) NSDictionary *params;
-(instancetype)initWithURL:(NSURL *)url userInfo:(nullable NSDictionary *)info;
@end
@protocol BHRouterResponseProtocol <NSObject>
@property (nonatomic, assign, readonly) int responseType;
/** 处理重定向的url */
@property (nonatomic, strong, readonly) NSURL *redirectURL;
@property (nonatomic, strong, readonly) id object;
@property (nonatomic, strong, readonly) UIViewController *viewController;
@end

@protocol BHRouterHandleProtocol <NSObject>
-(BOOL)canHandleURL:(NSURL *)url;
@optional
-(BOOL)canHandleRequest:(id<BHRouterRequestProtocol>) request;
@end

NS_ASSUME_NONNULL_END
