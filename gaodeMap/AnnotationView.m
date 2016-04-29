//
//  AnnotationView.m
//  gaodeMap
//
//  Created by 厦航 on 16/4/27.
//  Copyright © 2016年 厦航. All rights reserved.
//

#import "AnnotationView.h"
#import "FoundViewController.h"


@implementation AnnotationView
- (void) initUI{
    self.cusView = [[UIView alloc]initWithFrame:CGRectMake(0, self.delegateVC.view.frame.size.height/4, self.delegateVC.view.frame.size.width*0.4, self.delegateVC.view.frame.size.height/3)];
    self.cusView.backgroundColor = [UIColor blackColor];
//    self.cusView.backgroundColor = [UIColor colorWithRed:(arc4random()%255)/255.0 green:(arc4random()%255)/255.0 blue:(arc4random()%255)/255.0 alpha:1.0];
    
    self.annImage = [UIImageView new];
    self.annImage.frame = CGRectMake(5, 5, 60, 60);
    self.annImage.backgroundColor = [UIColor whiteColor];
    self.annImage.layer.cornerRadius = 30;
    self.annImage.layer.masksToBounds = YES;
    self.annImage.image = [UIImage imageNamed:@"callout.jpg"];
    [self.cusView addSubview:self.annImage];
    
    self.annLevel = [UILabel new];
    self.annLevel.frame = CGRectMake(5, 60, 80, 30);
    self.annLevel.text = @"国王等级";
    self.annLevel.textColor = [UIColor whiteColor];
    self.annLevel.font = [UIFont boldSystemFontOfSize:15];
    [self.cusView addSubview:_annLevel];
    
    self.BottomView = [[UIView alloc]initWithFrame: CGRectMake(0, self.cusView.frame.size.height*0.6, self.cusView.frame.size.width, self.cusView.frame.size.height*0.4)];
    self.BottomView.backgroundColor = [UIColor whiteColor];
    [self.cusView addSubview:self.BottomView];
    
    self.annName = [UILabel new];
    self.annName.frame = CGRectMake(5, 5, self.cusView.frame.size.width-5, 40);
    self.annName.textColor = [[UIColor blackColor]colorWithAlphaComponent:0.5];
    self.annName.text = @"旅程定制";
    self.annName.numberOfLines = 0;
    self.annName.font = [UIFont boldSystemFontOfSize:14];
    [self.BottomView addSubview:self.annName];
    
    self.annAddress = [UILabel new];
    self.annAddress.frame = CGRectMake(5, 30, self.cusView.frame.size.width-5, self.BottomView.frame.size.height-30);
    self.annAddress.numberOfLines = 0;
    self.annAddress.textColor = [UIColor lightGrayColor];
    self.annAddress.font = [UIFont systemFontOfSize:13];
    self.annAddress.text = @"如何在上海玩的又文艺又自在。";
    [self.BottomView addSubview:self.annAddress];
    
  
}
#pragma CATransition动画实现
- (void) transitionWithType:(NSString *) type WithSubtype:(NSString *) subtype ForView : (UIView *) view
{
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

/* 重写选中方法setSelected。选中时新建并添加calloutView*/
- (void) setSelected:(BOOL)selected animated:(BOOL)animated{
    if (self.selected == selected) {
        return;
    }
    if (selected) {
        [UIView animateWithDuration:0.9 animations:^{
            [self initUI];
            [self transitionWithType:@"pageCurl" WithSubtype:kCATransitionFromLeft ForView:self.cusView];
        }];
        if (self.cusView == nil) {
            self.annAddress.text = self.annotation.subtitle;
            self.annName.text = self.annotation.title;
            
            NSLog(@"您所点击的坐标为:____%f____%f  ",self.annotation.coordinate.longitude,self.annotation.coordinate.latitude);
        }
        [self.delegateVC.view insertSubview:self.cusView atIndex:MAXFLOAT];
    }
    else{
        [self.cusView removeFromSuperview];
    }
    [super setSelected:selected animated:animated];
}







/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
