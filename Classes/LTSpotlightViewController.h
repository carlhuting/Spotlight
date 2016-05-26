//
//  LTSpotlightViewController.h
//  Spotlignt
//
//  Created by lkeg on 16/5/25.
//  Copyright © 2016年 lemontree. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LTSpotlightViewController;
@class LTSpotlightView;

@protocol LTSpotlightViewControllerDelegate
- (void)spotlightViewControllerWillPresent:
(LTSpotlightViewController *)viewController
                                  animated:(BOOL)animation;
- (void)spotlightViewControllerWillDismiss:
            (LTSpotlightViewController *)viewController
                                  animated:(BOOL)animation;
- (void)spotlightViewControllerTapped:
            (LTSpotlightViewController *)viewController
                             isInsideSpotlight:(BOOL)isInside;
@end

@interface LTSpotlightViewController : UIViewController
@property(nonatomic, weak) id<LTSpotlightViewControllerDelegate> deleage;
@property(nonatomic, strong) LTSpotlightView *spotlightView;
@end
