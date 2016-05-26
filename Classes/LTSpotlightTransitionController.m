//
//  LTSpotlightTransitionController.m
//  Spotlignt
//
//  Created by lkeg on 16/5/25.
//  Copyright © 2016年 lemontree. All rights reserved.
//

#import "LTSpotlightTransitionController.h"

@implementation LTSpotlightTransitionController

- (NSTimeInterval)transitionDuration:
    (id<UIViewControllerContextTransitioning>)transitionContext {
  return 0.25;
}

- (void)animateTransition:
    (id<UIViewControllerContextTransitioning>)transitionContext {
  if (self.isPresent) {
      [self animateTransitionForPresent:transitionContext];
  } else {
      [self animateTransitionForDismiss:transitionContext];
  }
}

- (void)animateTransitionForPresent:
    (id<UIViewControllerContextTransitioning>)transitionContext {
  UIViewController *source = [transitionContext
      viewControllerForKey:UITransitionContextFromViewControllerKey];
  UIViewController *destination = [transitionContext
      viewControllerForKey:UITransitionContextToViewControllerKey];
  [[transitionContext containerView] insertSubview:destination.view
                                      aboveSubview:source.view];
  destination.view.alpha = 0;

  [source viewWillDisappear:YES];
  [destination viewWillAppear:YES];

  NSTimeInterval duration = [self transitionDuration:transitionContext];
  [CATransaction begin];
  [CATransaction setCompletionBlock:^{
    [transitionContext completeTransition:YES];
  }];
  { // In transation
    [UIView animateWithDuration:duration
        delay:0
        options:UIViewAnimationOptionCurveEaseInOut
        animations:^{
          destination.view.alpha = 1.0;
        }
        completion:^(BOOL finished) {
          [destination viewDidAppear:YES];
          [source viewDidDisappear:YES];
        }];
    [self.delegate spotlightTransitionWillPresent:self
                                transitionContext:transitionContext];
  }
  [CATransaction commit];
}

- (void)animateTransitionForDismiss:
    (id<UIViewControllerContextTransitioning>)transitionContext {
  UIViewController *source = [transitionContext
      viewControllerForKey:UITransitionContextFromViewControllerKey];
  UIViewController *destination = [transitionContext
      viewControllerForKey:UITransitionContextToViewControllerKey];

  [source viewWillDisappear:YES];
  [destination viewWillAppear:YES];

  NSTimeInterval duration = [self transitionDuration:transitionContext];
  [CATransaction begin];
  [CATransaction setCompletionBlock:^{
    [transitionContext completeTransition:YES];
  }];
  { // In transation
    [UIView animateWithDuration:duration
        delay:0
        options:UIViewAnimationOptionCurveEaseInOut
        animations:^{
          source.view.alpha = 0;
        }
        completion:^(BOOL finished) {
          [destination viewDidAppear:YES];
          [source viewDidDisappear:YES];
        }];
    [self.delegate spotlightTransitionWillDismiss:self
                                transitionContext:transitionContext];
  }
  [CATransaction commit];
}

- (void)animationEnded:(BOOL)transitionCompleted {
}

@end
