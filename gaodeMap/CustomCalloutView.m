//
//  CustomCalloutView.m
//  gaodeMap
//
//  Created by 厦航 on 16/4/26.
//  Copyright © 2016年 厦航. All rights reserved.
//

#import "CustomCalloutView.h"
#define kPortraitMargin     5
#define kPortraitWidth      70
#define kPortraitHeight     50

#define kTitleWidth         120
#define kTitleHeight        20


@implementation CustomCalloutView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
/*重写drawRect方法*/
- (void)drawRect:(CGRect)rect {
    [self drawInContext:UIGraphicsGetCurrentContext()];
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOpacity = 1.0;
    self.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
}

- (void) drawInContext:(CGContextRef) context{
    CGContextSetLineWidth(context, 2.0);
    CGContextSetFillColorWithColor(context, [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:0.8].CGColor);
    [self getDrawPath:context];
    CGContextFillPath(context);
}

- (void) getDrawPath:(CGContextRef) context{
    CGRect rrect = self.bounds;
    CGFloat radius = 6.0;
    CGFloat minx = CGRectGetMinX(rrect),
    midx = CGRectGetMidX(rrect),
    maxx = CGRectGetMaxY(rrect);
    
    CGFloat miny = CGRectGetMinY(rrect),
    maxy = CGRectGetMaxY(rrect)-10;
    
    CGContextMoveToPoint(context, midx+10, maxy);
    CGContextAddLineToPoint(context,midx, maxy+10);
    CGContextAddLineToPoint(context,midx-10, maxy);
    
    CGContextAddArcToPoint(context, minx, maxy, minx, miny, radius);
    CGContextAddArcToPoint(context, minx, minx, maxx, miny, radius);
    CGContextAddArcToPoint(context, maxx, miny, maxx, maxx, radius);
    CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius);
    CGContextClosePath(context);
}



/*定义显示气泡控件，并添加到SubView中*/
- (id) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [UIView animateWithDuration:0.2 animations:^{
             [self initSubViews];
        }];
       
    }
    return self;
}

- (void) initSubViews{
    /*添加图片*/
    self.portraitView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 60, 60)];
    self.portraitView.backgroundColor = [UIColor whiteColor];
    self.portraitView.layer.cornerRadius = 30;
    self.portraitView.layer.masksToBounds = YES;
    self.portraitView.image = [UIImage imageNamed:@"mm.jpg"];
    [self addSubview:self.portraitView];
    
    self.levelLable = [[UILabel alloc]initWithFrame:CGRectMake(5, 65, 60, 30)];
    self.levelLable.textColor = [UIColor whiteColor];
    self.levelLable.text = @"国王等级";
    self.levelLable.font = [UIFont boldSystemFontOfSize:15];
    [self addSubview:self.levelLable];
    
    
    self.bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, 200*0.6, 150, 200*0.4)];
    self.bottomView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.bottomView];
    
    
    /*添加标题*/
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, self.bottomView.frame.size.width-5, 40)];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    self.titleLabel.textColor = [UIColor grayColor];
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.text = @"旅程定制";
    [self.bottomView addSubview:self.titleLabel];
    
    /*添加副标题*/
    self.subtitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 20, self.bottomView.frame.size.width-5, self.bottomView.frame.size.height-30)];
    self.subtitleLabel.font = [UIFont systemFontOfSize:12];
    self.subtitleLabel.numberOfLines = 0;
    self.subtitleLabel.textColor = [UIColor lightGrayColor];
    self.subtitleLabel.text = @"如何在上海玩的又文艺又自在";
    [self.bottomView addSubview:self.subtitleLabel];
    
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.bottomView.bounds)-1, CGRectGetWidth(self.bounds), 20)];
    [self.bottomView addSubview:image];
    image.image = [UIImage imageNamed:@"jtsmall"];
    self.bottomView.clipsToBounds = NO;    
}


- (void)setCustomImage:(UIImage *)customImage{
    self.portraitView.image = customImage;
}

- (void)setCustomName:(NSString *)customName{
    self.titleLabel.text = customName;
}

- (void)setCustomAddress:(NSString *)customAddress{
    self.subtitleLabel.text = customAddress;
}




@end
