//
//  AnnotationView.h
//  gaodeMap
//
//  Created by 厦航 on 16/4/27.
//  Copyright © 2016年 厦航. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>

@interface AnnotationView : MAAnnotationView
@property (nonatomic,strong) UIView *cusView;

@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *subTitle;
@property (nonatomic, strong) UIViewController *delegateVC;



/*视图UI界面*/
@property (nonatomic,strong)UIImageView *annImage;
@property (nonatomic,strong)UILabel *annLevel;

@property (nonatomic,strong) UIView *BottomView;
@property (nonatomic,strong)UILabel *annName;
@property (nonatomic,strong)UILabel *annAddress;


@end
