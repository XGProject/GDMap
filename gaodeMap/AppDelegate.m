//
//  AppDelegate.m
//  gaodeMap
//
//  Created by 厦航 on 16/4/26.
//  Copyright © 2016年 厦航. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "FoundViewController.h"

#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchKit.h>


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    /*初始化Window*/
    [self initWindow];
    
    [MAMapServices sharedServices].apiKey = @"3bd8022b4a8b489d32f44386575956be";
    [AMapSearchServices sharedServices].apiKey = @"3bd8022b4a8b489d32f44386575956be";

    return YES;
}

- (void) initWindow{
    ViewController *viewCtl = [[ViewController alloc]init];
    FoundViewController *foundCtl = [[FoundViewController alloc]init];
    //FoundTaskViewController *foundTaskCtl = [[FoundTaskViewController alloc]init];
    
    UINavigationController *nav_viewCtl = [[UINavigationController alloc]initWithRootViewController:viewCtl];
    UINavigationController *nav_foundCtl = [[UINavigationController alloc]initWithRootViewController:foundCtl];

    UITabBarController *tabBarCtl = [[UITabBarController alloc]init];
    tabBarCtl.viewControllers = @[nav_viewCtl,nav_foundCtl];
    nav_viewCtl.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"首页" image:nil selectedImage:nil];
    nav_foundCtl.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"发现" image:nil selectedImage:nil];

    
    
    UINavigationBar *navBar = [UINavigationBar appearance];
    navBar.barTintColor = [UIColor colorWithRed:252/255.0 green:240/255.0 blue:11/255.0 alpha:1.0];
    navBar.tintColor = [UIColor blackColor];
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    self.window.rootViewController = tabBarCtl;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application{
    /*清空程序内存*/
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}
@end
