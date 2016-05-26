//
//  LTAnnotationViewController.m
//  Spotlignt
//
//  Created by lkeg on 16/5/25.
//  Copyright © 2016年 lemontree. All rights reserved.
//

#import "LTAnnotationViewController.h"
#import "LTSpotlightViewController.h"
#import "LTSpotlightView.h"
#import "LTSpotlight.h"

@interface LTAnnotationViewController ()<LTSpotlightViewControllerDelegate>
@property (nonatomic, strong) IBOutletCollection(UIView) NSArray *annotationViews;
@property (nonatomic, assign) NSInteger stepIndex;
@end

@implementation LTAnnotationViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.deleage = self;
}

- (void)next:(BOOL)labelAnimated {
    [self updateAnnotationView:labelAnimated];
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    switch (self.stepIndex) {
        case 0:
            [self.spotlightView appear:[LTSpotlight initOvalSpotlight:CGPointMake(screenSize.width - 26.0, 42.0) diameter:50] duration: 0.25];
            break;
            case 1:
            [self.spotlightView move:[LTSpotlight initOvalSpotlight:CGPointMake(screenSize.width - 75.0, 42.0) diameter:50] duration: 0.25 moveType:LTSpotlightMoveDirect];
            break;
            case 2:
             [self.spotlightView move:[LTSpotlight initRoundedRectSpotlight:CGPointMake(screenSize.width / 2, 42) size:CGSizeMake(120, 40) cornerRadius:6] duration:0.25 moveType:LTSpotlightDisappear];
            break;
            case 3:
            [self.spotlightView move:[LTSpotlight initOvalSpotlight:CGPointMake(screenSize.width / 2, 200) diameter:220] duration:0.25 moveType:LTSpotlightDisappear];
            break;
          case 4:
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
            break;
        default:
            break;
    }
    self.stepIndex += 1;
}

- (void)updateAnnotationView:(BOOL)animated {
    [self.annotationViews enumerateObjectsUsingBlock:^(UIView  *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [UIView animateWithDuration:animated ? 0.25 : 0 animations:^{
            obj.alpha = idx == self.stepIndex ? 1 : 0;
        }];
    }];
}

#pragma mark - LTSpotlightViewControllerDelegate

- (void)spotlightViewControllerWillPresent:
(LTSpotlightViewController *)viewController
                                  animated:(BOOL)animation {
    [self next:NO];
}
- (void)spotlightViewControllerWillDismiss:
(LTSpotlightViewController *)viewController
                                  animated:(BOOL)animation {
    [self.spotlightView disappear:0.25];
}
- (void)spotlightViewControllerTapped:
(LTSpotlightViewController *)viewController
                             isInsideSpotlight:(BOOL)isInside {
    [self next:YES];
}

@end
