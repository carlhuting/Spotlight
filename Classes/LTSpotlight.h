//
//  LTSpotlight.h
//  Spotlignt
//
//  Created by lkeg on 16/5/25.
//  Copyright © 2016年 lemontree. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol LTSpotlight
@property(nonatomic, assign) CGRect frame;
@property(nonatomic, assign) CGPoint center;
@property(nonatomic, strong) UIBezierPath *path;
@property(nonatomic, strong) UIBezierPath *infinitesmalPath;
@end

@interface LTSpotlight : NSObject <LTSpotlight>
- (instancetype)init:(CGRect)frame;
@property(nonatomic, assign) CGRect frame;
@property(nonatomic, assign) CGPoint center;
@property(nonatomic, strong) UIBezierPath *path;
@property(nonatomic, strong) UIBezierPath *infinitesmalPath;

+ (instancetype)initOvalSpotlight:(CGPoint)center diameter:(CGFloat)radio;
+ (instancetype)initRectSpotlight:(CGPoint)center size:(CGSize)size;
+ (instancetype)initRoundedRectSpotlight:(CGPoint)center
                                    size:(CGSize)size
                            cornerRadius:(CGFloat)cornerRadius;
@end
