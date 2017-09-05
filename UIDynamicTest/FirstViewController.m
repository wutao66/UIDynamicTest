//
//  FirstViewController.m
//  cs
//
//  Created by Macx on 2017/9/5.
//  Copyright © 2017年 wt. All rights reserved.
//

#import "FirstViewController.h"
#import "WPFCollisionView.h"
#import "WPFBaseView.h"
#import <CoreMotion/CoreMotion.h>

@interface FirstViewController (){
    NSTimeInterval updateInterval;
}

@property (nonatomic,strong) CMMotionManager *mManager;
@property (assign) double scale;
@property (nonatomic,strong) WPFBaseView * baseView;

@end

@implementation FirstViewController

- (CMMotionManager *)mManager
{
    if (!_mManager) {
        updateInterval = 1.0/10.0;
        _mManager = [[CMMotionManager alloc] init];
    }
    return _mManager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.scale = 1.0;
    
    self.baseView = [[WPFCollisionView alloc] init];
    self.baseView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 49);
    
    [self.view addSubview:self.baseView];
    
    
    if ([self.mManager isAccelerometerAvailable] == YES) {
        //回调会一直调用,建议获取到就调用下面的停止方法，需要再重新开始，当然如果需求是实时不间断的话可以等离开页面之后再stop
        [self.mManager setAccelerometerUpdateInterval:updateInterval];
        [self.mManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMAccelerometerData *accelerometerData, NSError *error)
         {
             double x = accelerometerData.acceleration.x;
             double y = accelerometerData.acceleration.y;
             if (fabs(y) >= fabs(x))
             {
                 if (y >= 0){
                     
                     NSLog(@"Down");
                     //Down
                 }
                 else{
                     NSLog(@"Portrait");
                     
                     //Portrait
                 }
             }
             else
             {
                 if (x >= 0){
                     NSLog(@"Right");
                     
                     //Right
                 }
                 else{
                     NSLog(@"Left");
                     
                     //Left
                 }
                 
             }
             
             
             // 1. 计算偏移量
             CGPoint offset = CGPointMake(accelerometerData.acceleration.x,-accelerometerData.acceleration.y);
             // 2. 计算角度
             CGFloat angle = atan2(offset.y, offset.x);
             // 3. 计算距离
             CGFloat distance = hypot(offset.y, offset.x);
             // 4. 设置推动的大小、角度
             self.baseView.push.magnitude = distance;
             self.baseView.push.angle = angle;
             // 5. 使单次推行为有效
             self.baseView.push.active = YES;
             
             
             
         }];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
