//
//  BHWXBaseViewController.h
//  BHKit
//
//  Created by 姚晨峰 on 2019/2/25.
//  Copyright © 2019 姚晨峰. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface BHWXBaseViewController : UIViewController<UIGestureRecognizerDelegate>
@property (nonatomic, strong, readonly) NSURL *sourceURL;
/**
 * @abstract initializes the viewcontroller with bundle url.
 *
 * @param sourceURL The url of bundle rendered to a weex view.
 *
 * @return a object the class of WXBaseViewController.
 *
 */
- (instancetype)initWithSourceURL:(NSURL *)sourceURL;

/**
 * @abstract refreshes the weex view in controller.
 */
- (void)refreshWeex;
@end

NS_ASSUME_NONNULL_END
