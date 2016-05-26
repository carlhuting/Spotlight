//
//  LTSpotlightView.h
//  Spotlignt
//
//  Created by lkeg on 16/5/25.
//  Copyright © 2016年 lemontree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LTSpotlight.h"

typedef NS_ENUM(NSUInteger, LTSpotlightMoveType) {
    LTSpotlightMoveDirect,
    LTSpotlightDisappear,
};

@interface LTSpotlightView : UIView
@property(nonatomic, strong) id<LTSpotlightType> spotlight;
- (void)appear:(id<LTSpotlightType>)spotlight
      duration:(NSTimeInterval)duration;
- (void)disappear:(NSTimeInterval)duration;
- (void)move:(id<LTSpotlightType>)toSpotlight
    duration:(NSTimeInterval)duration
    moveType:(LTSpotlightMoveType)moveType;
@end
