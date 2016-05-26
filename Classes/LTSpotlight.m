//
//  LTSpotlight.m
//  Spotlignt
//
//  Created by lkeg on 16/5/25.
//  Copyright © 2016年 lemontree. All rights reserved.
//

#import "LTSpotlight.h"

@class LTOvalSpotlight;
@class LTSpotlight;

@interface LTOvalSpotlight : LTSpotlight

@end



@implementation LTOvalSpotlight

- (instancetype)init:(CGPoint)center diameter:(CGFloat)diameter {
  CGRect frame = CGRectMake(center.x - diameter / 2, center.y - diameter / 2,
                            diameter, diameter);
  self = [[LTOvalSpotlight alloc] init:frame];
  return self;
}

- (UIBezierPath *)path {
  return
      [UIBezierPath bezierPathWithRoundedRect:self.frame
                                 cornerRadius:CGRectGetWidth(self.frame) / 2];
}

@end

@interface LTRectSpotlight : LTSpotlight
- (instancetype)init:(CGPoint)center size:(CGSize)size;
@end

@implementation LTRectSpotlight

- (instancetype)init:(CGPoint)center size:(CGSize)size {
  CGRect frame =
      CGRectMake(center.x - size.width / 2, center.y - size.height / 2,
                 size.width, size.height);
    self = [super init:frame];
  if (self) {
  }
  return self;
}

- (UIBezierPath *)path {
  return [UIBezierPath bezierPathWithRoundedRect:self.frame cornerRadius:0];
}

@end

@interface LTRoundedRectSpotlight : LTSpotlight
@property(nonatomic, assign) CGFloat cornerRadius;
- (instancetype)init:(CGPoint)center
                size:(CGSize)size
        cornerRadius:(CGFloat)cornerRadius;
@end

@implementation LTRoundedRectSpotlight

- (instancetype)init:(CGPoint)center
                size:(CGSize)size
        cornerRadius:(CGFloat)cornerRadius {
  CGRect frame =
      CGRectMake(center.x - size.width / 2, center.y - size.height / 2,
                 size.width, size.height);
    self = [super init:frame];
  if (self) {
    _cornerRadius = cornerRadius;
  }
  return self;
}


- (UIBezierPath *)path {
  return [UIBezierPath bezierPathWithRoundedRect:self.frame
                                    cornerRadius:self.cornerRadius];
}

@end



@implementation LTSpotlight

- (instancetype)init:(CGRect)frame {
    self = [super init];
    if (self) {
        _frame = frame;
    }
    return self;
}

- (CGPoint)center {
  return CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
}

- (UIBezierPath *)infinitesmalPath {
  return [UIBezierPath
      bezierPathWithRoundedRect:CGRectMake(self.center.x, self.center.y, 0, 0)
                   cornerRadius:0];
}

- (NSString *)debugDescription {
    return [NSString stringWithFormat:@"<%@ : %p> {frame : %@ } ", NSStringFromClass([self class]), self, NSStringFromCGRect(self.frame)];
}

+ (instancetype)initOvalSpotlight:(CGPoint)center diameter:(CGFloat)radio {
  return [[LTOvalSpotlight alloc] init:center diameter:radio];
}

+ (instancetype)initRectSpotlight:(CGPoint)center size:(CGSize)size {
  return [[LTRectSpotlight alloc] init:center size:size];
}

+ (instancetype)initRoundedRectSpotlight:(CGPoint)center
                                    size:(CGSize)size
                            cornerRadius:(CGFloat)cornerRadius {
  return [[LTRoundedRectSpotlight alloc] init:center
                                         size:size
                                 cornerRadius:cornerRadius];
}

@end
