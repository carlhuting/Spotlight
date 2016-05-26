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
@property(nonatomic, strong) id<LTSpotlight> spotlight;
- (void)appear:(id<LTSpotlight>)spotlight duration:(NSTimeInterval)duration;
- (void)disappear:(NSTimeInterval)duration;
- (void)move:(id<LTSpotlight>)toSpotlight duration:(NSTimeInterval)duration moveType:(LTSpotlightMoveType)moveType;
@end
