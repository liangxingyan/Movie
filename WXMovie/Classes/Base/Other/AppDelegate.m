//
//  AppDelegate.m
//  WXMovie
//
//  Created by mac2 on 16/7/18.
//  Copyright © 2016年 mac2. All rights reserved.
//

#import "AppDelegate.h"
#import "WXLaunchViewController.h"
#import "WXPushGuideViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    [self.window makeKeyAndVisible];
    
    // 之前已经登陆过
    NSString *key = @"CFBundleVersion";
    
    // 上一次版本
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    
    // 当前版本
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    
    if ( [currentVersion isEqualToString:lastVersion] ) {
        // 版本相同
        
        WXLaunchViewController *launchVc = [[WXLaunchViewController alloc] init];
        
        self.window.rootViewController = launchVc;
        
    } else {
        
        // 版本不同
        WXPushGuideViewController *pushGuide = [[WXPushGuideViewController alloc] init];
        
        self.window.rootViewController = pushGuide;
        
        // 将当前版本存进沙盒
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        
        // 马上同步到沙盒
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    return YES;
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

@end
