//
//  LTSpotlightViewController.m
//  Spotlignt
//
//  Created by lkeg on 16/5/25.
//  Copyright © 2016年 lemontree. All rights reserved.
//

#import "LTSpotlightTransitionController.h"
#import "LTSpotlightView.h"
#import "LTSpotlightViewController.h"

@interface LTSpotlightViewController () <LTSpotlightTransitionControllerDelegate, UIViewControllerTransitioningDelegate>
@property(nonatomic, strong) LTSpotlightTransitionController *transitionController;
@property(nonatomic, assign) CGFloat alpha;
@end

@implementation LTSpotlightViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil
                         bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    [self commonInit];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    [self commonInit];
  }
  return self;
}

- (void)commonInit {
  self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
  self.transitioningDelegate = self;
  self.alpha = 0.5;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [self setupSpotlightView:self.alpha];
  [self setupTapGesture];
  self.view.backgroundColor = [UIColor clearColor];
}

- (void)setupSpotlightView:(CGFloat)alpha {
  self.spotlightView = [LTSpotlightView new];
    self.spotlightView.frame = [UIScreen mainScreen].bounds;
    self.spotlightView.translatesAutoresizingMaskIntoConstraints = NO;
    
  self.spotlightView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:alpha];
    self.spotlightView.userInteractionEnabled = NO;
  [self.view insertSubview:self.spotlightView atIndex:0];
  NSLayoutConstraint *topConstraint =
      [NSLayoutConstraint constraintWithItem:self.view
                                   attribute:NSLayoutAttributeTop
                                   relatedBy:NSLayoutRelationEqual
                                      toItem:self.spotlightView
                                   attribute:NSLayoutAttributeTop
                                  multiplier:1
                                    constant:0];
  NSLayoutConstraint *trainingConstraint =
      [NSLayoutConstraint constraintWithItem:self.view
                                   attribute:NSLayoutAttributeTrailing
                                   relatedBy:NSLayoutRelationEqual
                                      toItem:self.spotlightView
                                   attribute:NSLayoutAttributeTrailing
                                  multiplier:1
                                    constant:0];
  NSLayoutConstraint *bottomConstraint =
      [NSLayoutConstraint constraintWithItem:self.view
                                   attribute:NSLayoutAttributeBottom
                                   relatedBy:NSLayoutRelationEqual
                                      toItem:self.spotlightView
                                   attribute:NSLayoutAttributeBottom
                                  multiplier:1
                                    constant:0];
  NSLayoutConstraint *leadingConstraint =
      [NSLayoutConstraint constraintWithItem:self.view
                                   attribute:NSLayoutAttributeLeading
                                   relatedBy:NSLayoutRelationEqual
                                      toItem:self.spotlightView
                                   attribute:NSLayoutAttributeLeading
                                  multiplier:1
                                    constant:0];
  [self.view addConstraints:@[
    topConstraint,
    trainingConstraint,
    bottomConstraint,
    leadingConstraint
  ]];
}

- (void)setupTapGesture {
  UITapGestureRecognizer *tapGesture =
      [[UITapGestureRecognizer alloc] initWithTarget:self
                                              action:@selector(viewTapped:)];
  [self.view addGestureRecognizer:tapGesture];
}

- (void)viewTapped:(UITapGestureRecognizer *)gesture {
  CGPoint touchPoint = [gesture locationInView:self.spotlightView];
   BOOL isInside = CGRectContainsPoint([self.spotlightView.spotlight frame], touchPoint);
  [self.deleage spotlightViewControllerTapped:self isInsideSpotlight:isInside];
}


# pragma mark - LTSpotlightTransitionControllerDelegate

- (void)spotlightTransitionWillPresent:(LTSpotlightTransitionController *)controller
             transitionContext:
                 (id<UIViewControllerContextTransitioning>)transitionContext {
  [self.deleage spotlightViewControllerWillPresent:self
                                animated:[transitionContext isAnimated]];
}

- (void)spotlightTransitionWillDismiss:(LTSpotlightTransitionController *)controller
             transitionContext:
                 (id<UIViewControllerContextTransitioning>)transitionContext {
  [self.deleage spotlightViewControllerWillDismiss:self
                                animated:[transitionContext isAnimated]];
}

#pragma mark - UIViewControllerTransitioningDelegate

- (LTSpotlightTransitionController *)transitionController {
    if (!_transitionController) {
        _transitionController = [LTSpotlightTransitionController new];
        _transitionController.delegate = self;
    }
    return _transitionController;
}

- (id<UIViewControllerAnimatedTransitioning>)
animationControllerForPresentedController:(UIViewController *)presented
                     presentingController:(UIViewController *)presenting
                         sourceController:(UIViewController *)source {
  self.transitionController.isPresent = YES;
  return self.transitionController;
}

- (id<UIViewControllerAnimatedTransitioning>)
animationControllerForDismissedController:(UIViewController *)dismissed {
  self.transitionController.isPresent = NO;
  return self.transitionController;
}

@end
