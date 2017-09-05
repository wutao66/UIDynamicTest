//
//  WPFBaseView.h
//
//  Created by wt on 17/9/5.
//  Copyright © 2017年 wt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WPFBaseView : UIView

/**  方块视图  */
@property (nonatomic, weak) UIImageView *boxView;

@property (nonatomic, weak) UIImageView *boxViewOther;

@property (nonatomic, weak) UIImageView *boxView3;
@property (nonatomic, weak) UIImageView *boxView4;
@property (nonatomic, weak) UIImageView *boxView5;

/**  仿真者  */
@property (nonatomic, strong) UIDynamicAnimator *animator;

@property (nonatomic, strong) UIPushBehavior *push;


@end
