//
//  WPFCollisionView.m
//
//  Created by wt on 17/9/5.
//  Copyright © 2017年 wt. All rights reserved.
//

#import "WPFCollisionView.h"

@interface WPFCollisionView () <UICollisionBehaviorDelegate>

@end

@implementation WPFCollisionView


- (instancetype)init {
    
    if (self = [super init]) {
        
        self.boxView.center = CGPointMake(190, 0);
        
        // 1. 添加重力行为
        UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems:@[self.boxView,self.boxViewOther,self.boxView3,self.boxView4,self.boxView5]];
        
        [self.animator addBehavior:gravity];
        
        // 2. 边缘检测
        // 如果把红色view 也加边缘检测，则碰撞后红色View 也会被碰掉，因此要手动添加边界
        UICollisionBehavior *collision = [[UICollisionBehavior alloc] initWithItems:@[self.boxView,self.boxViewOther,self.boxView3,self.boxView4,self.boxView5]];
        // 让碰撞的行为生效
        collision.translatesReferenceBoundsIntoBoundary = YES;
        
        collision.collisionDelegate = self;
        
        
//        // 3. 添加一个红色view
//        UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(0, 350, 180, 30)];
//        redView.backgroundColor = [UIColor redColor];
//        [self addSubview:redView];
//        
//        
//        // 4. 手动添加边界
//        UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRect:redView.frame];
//        
//        [collision addBoundaryWithIdentifier:@"redBoundary" forPath:bezierPath];
        
        [self.animator addBehavior:collision];
        
        // 5. 物体的属性行为
        UIDynamicItemBehavior *item = [[UIDynamicItemBehavior alloc] initWithItems:@[self.boxView,self.boxViewOther,self.boxView3,self.boxView4,self.boxView5]];
        
        // 设置物体弹性，振幅
        item.elasticity = 0.5;
        [self.animator addBehavior:item];
        
        
        self.push = [[UIPushBehavior alloc] initWithItems:@[self.boxView,self.boxViewOther,self.boxView3,self.boxView4,self.boxView5] mode:UIPushBehaviorModeInstantaneous];
        [self.animator addBehavior:self.push];

        

    }
    return self;
}


#pragma mark - UICollisionBehaviorDelegate
// 在碰撞的时候调用
- (void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item withBoundaryIdentifier:(id<NSCopying>)identifier atPoint:(CGPoint)p {
    
    NSLog(@"%@", NSStringFromCGPoint(p));
    
    //    UIView *view = (UIView *)item;
    //    view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0];
    
}

@end
