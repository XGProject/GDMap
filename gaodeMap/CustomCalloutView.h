//
//  CustomCalloutView.h
//  gaodeMap
//
//  Created by 厦航 on 16/4/26.
//  Copyright © 2016年 厦航. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCalloutView : UIView
@property (nonatomic,strong) UIImage *customImage;
@property (nonatomic,strong) NSString *customName;
@property (nonatomic,strong) NSString *customAddress;

/*UI*/
@property (nonatomic, strong) UIImageView *portraitView;
@property (nonatomic, strong) UILabel *levelLable;

@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UILabel *subtitleLabel;
@property (nonatomic, strong) UILabel *titleLabel;


@end
