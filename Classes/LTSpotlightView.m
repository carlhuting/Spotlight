//
//  LTSpotlightView.m
//  Spotlignt
//
//  Created by lkeg on 16/5/25.
//  Copyright © 2016年 lemontree. All rights reserved.
//

#import "LTSpotlight.h"
#import "LTSpotlightView.h"

//static NSTimeInterval const defaultAnimateDuration = 0.25;

@interface LTSpotlightView ()
@property(nonatomic, strong) CAShapeLayer *maskLayer;
@end

@implementation LTSpotlightView

- (CAShapeLayer *)maskLayer {
  if (!_maskLayer) {
    _maskLayer = [CAShapeLayer layer];
    _maskLayer.fillRule = kCAFillRuleEvenOdd;
    _maskLayer.fillColor = [UIColor blackColor].CGColor;
  }
  return _maskLayer;
}

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
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
    self.layer.mask = self.maskLayer;
}

- (void)layoutSubviews {
  [super layoutSubviews];
  self.maskLayer.frame = self.frame;
}

- (void)appear:(id<LTSpotlight>)spotlight duration:(NSTimeInterval)duration {
  CABasicAnimation *animation = [self appearAnimation:duration spotlight:spotlight];
  [self.maskLayer addAnimation:animation forKey:nil];
  self.spotlight = spotlight;
}

- (void)disappear:(NSTimeInterval)duration {
  CABasicAnimation *animation = [self disappearAnimation:duration];
  [self.maskLayer addAnimation:animation forKey:nil];
}

- (void)move:(id<LTSpotlight>)toSpotlight
    duration:(NSTimeInterval)duration
    moveType:(LTSpotlightMoveType)moveType {
  switch (moveType) {
  case LTSpotlightMoveDirect: {
    [self moveDirect:toSpotlight duration:duration];
    break;
  }
  case LTSpotlightDisappear: {
    [self moveDisappear:toSpotlight duration:duration];
    break;
  }
  }
}

- (void)moveDirect:(id<LTSpotlight>)toSpotlight
          duration:(NSTimeInterval)duration {
  CABasicAnimation *animation = [self moveAnimation:duration toSpotlight:toSpotlight];
  [self.maskLayer addAnimation:animation forKey:nil];
  self.spotlight = toSpotlight;
}

- (void)moveDisappear:(id<LTSpotlight>)toSpotlight
             duration:(NSTimeInterval)duration {
  [CATransaction begin];
  [CATransaction setCompletionBlock:^{
    [self appear:toSpotlight duration:duration];
    self.spotlight = toSpotlight;
  }];
  [self disappear:duration];
  [CATransaction commit];
}

- (UIBezierPath *)maskPath:(UIBezierPath *)path {
  UIBezierPath *viewpath = [UIBezierPath bezierPathWithRect:self.frame];
  [viewpath appendPath:path];
  return viewpath;
}

- (CABasicAnimation *)appearAnimation:(NSTimeInterval)duration spotlight:(id<LTSpotlight>)spotlight {
  UIBezierPath *beginPath = [self maskPath:spotlight.infinitesmalPath];
  UIBezierPath *endPath = [self maskPath:spotlight.path];
  return [self pathAnimation:duration beginPath:beginPath endPath:endPath];
}

- (CABasicAnimation *)disappearAnimation:(NSTimeInterval)duration {
  UIBezierPath *endPath = [self maskPath:self.spotlight.infinitesmalPath];
  return [self pathAnimation:duration beginPath:nil endPath:endPath];
}

- (CABasicAnimation *)moveAnimation:(NSTimeInterval)duration toSpotlight:(id<LTSpotlight>)spotlight {
  UIBezierPath *endPath = [self maskPath:spotlight.path];
  return [self pathAnimation:duration beginPath:nil endPath:endPath];
}

- (CABasicAnimation *)pathAnimation:(NSTimeInterval)duration
                          beginPath:(UIBezierPath *)beginPath
                            endPath:(UIBezierPath *)endPath {
  CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
  animation.duration = duration;
  animation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.66:0:0.33:1];
  if (beginPath) {
    animation.fromValue = (__bridge id _Nullable)(beginPath.CGPath);
  }
  animation.toValue = (__bridge id _Nullable)(endPath.CGPath);
  animation.removedOnCompletion = NO;
  animation.fillMode = kCAFillModeForwards;
  return animation;
}

@end
