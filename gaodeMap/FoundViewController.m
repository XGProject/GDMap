//
//  FoundViewController.m
//  gaodeMap
//
//  Created by 厦航 on 16/4/26.
//  Copyright © 2016年 厦航. All rights reserved.
//

#import "FoundViewController.h"
#import "CustomAnnotationView.h"
/*添加自定义绝对气泡*/
#import "AnnotationView.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
@interface FoundViewController ()<MAMapViewDelegate,AMapSearchDelegate>{
    MAMapView *_mapView;
    AMapSearchAPI *_search;
    
    NSMutableArray *_AnnotationArray;//储存上次搜索添加的大头针

    NSArray *_longlatArray; //储存
    
    UITextField *_SousuoText;
    NSMutableArray *_pointArray;
}

@end

@implementation FoundViewController

- (void) initMapView{
    _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds))];
    _mapView.delegate = self;
    [self.view addSubview:_mapView];
    //打开定位
    _mapView.showsUserLocation = YES;
    _mapView.userTrackingMode = MAUserTrackingModeFollow;
    [_mapView setZoomLevel:16.1 animated:YES];
    
    //后台定位配置
    _mapView.pausesLocationUpdatesAutomatically = NO;
    _mapView.allowsBackgroundLocationUpdates = YES;
}

- (void) initUI{
    UIView *navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width*0.6, self.navigationController.navigationBar.frame.size.height)];
    navView.backgroundColor = [UIColor lightGrayColor];
    self.navigationItem.titleView = navView;
    
    _SousuoText = [[UITextField alloc]init];
    _SousuoText.frame = CGRectMake(1, 1, navView.frame.size.width-2, navView.frame.size.height-2);
    _SousuoText.clearButtonMode = UITextFieldViewModeWhileEditing;
    _SousuoText.clearsOnBeginEditing = YES;//再次编辑就清空
    _SousuoText.placeholder = @"搜索";
    _SousuoText.backgroundColor = [UIColor colorWithRed:252/255.0 green:240/255.0 blue:11/255.0 alpha:1.0];
    [navView addSubview:_SousuoText];
    
     UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, navView.frame.size.height-2)];
    [leftButton setTitle:@"搜索" forState:UIControlStateNormal];
    leftButton.backgroundColor = [UIColor lightGrayColor];
    [leftButton addTarget:self action:@selector(sousuoClick:) forControlEvents:UIControlEventTouchUpInside];
    
    _SousuoText.rightView = leftButton;
    _SousuoText.rightViewMode = UITextFieldViewModeAlways;

}

- (void) sousuoClick:(id) sender{
    [_SousuoText resignFirstResponder];
    [_mapView removeAnnotations:_AnnotationArray];
   
    _search = [[AMapSearchAPI alloc]init];
    _search.delegate = self;
    
    /*周边搜索*/
//    AMapPOIAroundSearchRequest *POIAround = [[AMapPOIAroundSearchRequest alloc]init];
//    POIAround.keywords = _SousuoText.text;
//    POIAround.location = [AMapGeoPoint locationWithLatitude:[[_longlatArray objectAtIndex:0] floatValue] longitude:[[_longlatArray objectAtIndex:1] floatValue]];
//    POIAround.radius = 50000;
//    [_search AMapPOIAroundSearch:POIAround];

    /*POI关键字搜索*/
    AMapPOIKeywordsSearchRequest *POIKeywords = [[AMapPOIKeywordsSearchRequest alloc]init];
    POIKeywords.cityLimit = NO;
    POIKeywords.city = @"上海";
    POIKeywords.keywords = @"东方明珠";
    if (![_SousuoText.text isEqualToString:@""]) {
        POIKeywords.keywords = _SousuoText.text;
    }
    [_search AMapPOIKeywordsSearch:POIKeywords];
    
    _pointArray = [[NSMutableArray alloc]init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initMapView];
    [self initUI];

    
}

/*Delegate 获取搜索到的数组数据*/
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
    if(response.pois.count == 0)
    {
        SHOWCONTROLLER(@"没有找到您想要的搜索数据！")
        return;
    }
     _AnnotationArray = [[NSMutableArray alloc]init];
    for (AMapPOI *p in response.pois) {
        NSLog(@" %@  <%@> ",p.name,p.location);
        /*添加大头针*/
        MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc]init];
        pointAnnotation.coordinate = CLLocationCoordinate2DMake(p.location.latitude, p.location.longitude);
        pointAnnotation.title = p.name;
        pointAnnotation.subtitle = p.address;
        [_mapView addAnnotation:pointAnnotation];
        
        [_AnnotationArray addObject:pointAnnotation];
        
        [_pointArray addObject:p.name];
    }

}

#pragma CATransition动画实现
- (void) transitionsWithType:(NSString *) type WithSubtype:(NSString *) subtype ForView : (UIView *) view
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

/*MAMapViewDelegate  大头针*/
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *reuseIndetifier = @"annotationReuseIndetifier";
        CustomAnnotationView *annotationView = (CustomAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[CustomAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseIndetifier];
        }
        annotationView.image = [UIImage imageNamed:@"callout.jpg"];
        annotationView.centerOffset = CGPointMake(0, -18);
        
        //annotationView.delegateVC = self;
        return annotationView;
    } 
    return nil;
}


/*突出显示自己当前位置*/
- (void)mapView:(MAMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    MAAnnotationView *view = views[0];
    // 放到该方法中用以保证自己的位置信息的annotationView已经添加到地图上了。
    if ([view.annotation isKindOfClass:[MAUserLocation class]])
    {
        MAUserLocationRepresentation *pre = [[MAUserLocationRepresentation alloc] init];
        pre.fillColor = [UIColor colorWithRed:0.9 green:0.1 blue:0.1 alpha:0.3];
        pre.strokeColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.9 alpha:1.0];
        pre.image = [UIImage imageNamed:@"location.png"];
        pre.lineWidth = 3;
        pre.lineDashPattern = @[@6, @3];
        
        [_mapView updateUserLocationRepresentation:pre];
        view.calloutOffset = CGPointMake(0, 0);
    }
}

/*获取到自己位置的坐标 实时更新*/
- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation{
    if(updatingLocation){
        NSLog(@"您当前的位置坐标为: %f  %f ",userLocation.coordinate.latitude,userLocation.coordinate.longitude);
        _longlatArray = @[@(userLocation.coordinate.latitude),@(userLocation.coordinate.longitude)];
    }
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
