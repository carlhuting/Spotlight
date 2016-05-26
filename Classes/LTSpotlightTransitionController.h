//
//  LTSpotlightTransitionController.h
//  Spotlignt
//
//  Created by lkeg on 16/5/25.
//  Copyright © 2016年 lemontree. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class LTSpotlightTransitionController;

@protocol LTSpotlightTransitionControllerDelegate

- (void)spotlightTransitionWillPresent:(LTSpotlightTransitionController *)controller
             transitionContext:
                 (id<UIViewControllerContextTransitioning>)transitionContext;
- (void)spotlightTransitionWillDismiss:(LTSpotlightTransitionController *)controller
             transitionContext:
                 (id<UIViewControllerContextTransitioning>)transitionContext;

@end

@interface LTSpotlightTransitionController
    : NSObject<UIViewControllerAnimatedTransitioning>
@property(nonatomic, assign) BOOL isPresent;
@property(nonatomic, weak) id<LTSpotlightTransitionControllerDelegate> delegate;
@end
