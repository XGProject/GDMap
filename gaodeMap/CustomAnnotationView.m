//
//  CustomAnnotationView.m
//  gaodeMap
//
//  Created by 厦航 on 16/4/27.
//  Copyright © 2016年 厦航. All rights reserved.
//

#import "CustomAnnotationView.h"
#import "FoundViewController.h"

#define kCalloutWidth       200.0
#define kCalloutHeight      70.0

@interface CustomAnnotationView ()
@property (nonatomic,strong,readwrite) CustomCalloutView *calloutView;

@property (nonatomic,strong) NSMutableArray *centerArray;
@end


@implementation CustomAnnotationView


#pragma CATransition动画实现
- (void) transitionWithType:(NSString *) type WithSubtype:(NSString *) subtype ForView : (UIView *) view{
    //创建CATransition对象
    CATransition *animation = [CATransition animation];
    
    //设置运动时间
    animation.duration = 0.2f;
    
    //设置运动type
    animation.type = type;
    if (subtype != nil) {
        
        //设置子类
        animation.subtype = subtype;
    }
    //设置运动速度
    animation.timingFunction = UIViewAnimationOptionCurveEaseInOut;
    
    [view.layer addAnimation:animation forKey:@"animation"];
}

#pragma CABasicAnimation动画实现
- (void) basicAnimationWithKeyPath:(NSString *) keypath ForView:(UIView *)view{
    [UIView animateWithDuration:0.4 animations:^{
        CABasicAnimation *anima2 = [CABasicAnimation animation];
        anima2.keyPath = keypath;
        anima2.duration = 0.4;
        anima2.fromValue = @(0);
        anima2.toValue = @(1.0);
        //设置动画执行完毕以后不删除动画。
        anima2.removedOnCompletion = NO;
        //设置保存动画的最新状态
        anima2.fillMode=kCAFillModeForwards;
        
        [view.layer addAnimation:anima2 forKey:@"scale"];
        
        CGPoint point = self.center;
        point.x = point.x-3;
        point.y = point.y - CGRectGetHeight(self.calloutView.bounds)  / 2-40;
        self.calloutView.center = point;
        
    } completion:^(BOOL finished) {
        
    }];
}

#pragma UIView动画
- (void) animationWithView : (UIView *)view WithAnimationTransition : (UIViewAnimationTransition) transition{
    [UIView animateWithDuration:0.2 animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationTransition:transition forView:view cache:YES];
    }];
}

/* 重写选中方法setSelected。选中时新建并添加calloutView*/
- (void) setSelected:(BOOL)selected animated:(BOOL)animated{
    if (self.selected == selected) {
        return;
    }
    if (selected) {
        if (self.calloutView == nil) {
        }
        self.calloutView = [[CustomCalloutView alloc]initWithFrame:CGRectMake(0, 0, 150, 200)];
        self.calloutView.center = self.center;
        [self.superview.superview  addSubview:self.calloutView];
        [self annimateAnnotation1];
    }
    else{
        [UIView animateWithDuration:0.2 animations:^{
            CABasicAnimation *anima2 = [CABasicAnimation animation];
            anima2.keyPath = @"transform.scale";
            anima2.duration = 0.2;
            anima2.fromValue = @(1.0);
            anima2.toValue = @(0.0);
            //设置动画执行完毕以后不删除动画。
            anima2.removedOnCompletion = NO;
            //设置保存动画的最新状态
            anima2.fillMode=kCAFillModeForwards;
           [self.calloutView.layer addAnimation:anima2 forKey:@"scale"];
            
            CGPoint point = self.center;
            point.y = point.y-1;
            self.calloutView.center = point;
            
        } completion:^(BOOL finished) {
            [self.calloutView removeFromSuperview];
        }];
    }
    [super setSelected:selected animated:animated];
 
}

- (void) annimateAnnotation1{
    
    self.calloutView.center = self.center;
    [self basicAnimationWithKeyPath:@"transform.scale" ForView:self.calloutView];
    self.calloutView.customImage = [UIImage imageNamed:@"mm.jpg"];
    self.calloutView.customName = self.annotation.title;
    self.calloutView.customAddress = self.annotation.subtitle;
    //NSLog(@"您所点击的坐标为:____%f____%f  ", ,self.annotation.coordinate.latitude);
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
