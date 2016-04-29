//
//  CustomAnnotationView.h
//  gaodeMap
//
//  Created by 厦航 on 16/4/27.
//  Copyright © 2016年 厦航. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>
#import "CustomCalloutView.h"

@interface CustomAnnotationView : MAAnnotationView
/*调用视图显示 */
@property (nonatomic,strong,readonly) CustomCalloutView *calloutView;

/*直接显示的  视图UI界面*/
@property (nonatomic,strong) UIView *customView;

@property (nonatomic,strong)UIImageView *annImage;
@property (nonatomic,strong)UILabel *annLevel;

@property (nonatomic,strong) UIView *BottomView;
@property (nonatomic,strong)UILabel *annName;
@property (nonatomic,strong)UILabel *annAddress;

@property (nonatomic, strong) UIViewController *delegateVC;


//

@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *subTitle;



@end
