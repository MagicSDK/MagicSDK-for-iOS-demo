//
//  AppDelegate.m
//  TUTUMagicSDKDemo
//
//  Created by TuSDK on 29/09/2017.
//  Copyright © 2017 TUTUMagic. All rights reserved.
//

#import "AppDelegate.h"
#import "DemoRootViewController.h"
#import "TUTUMagicSDK.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    /**
     * ！！！！！！！！！！！！！！！！！！！！！！！！！Attention ！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！
     * About File Size（increase the size of ipa about 2M）：
     * 1,If no need of Sticker Module，please delete /app/TuSDK.bundle/stickers，and disable module in EditMultipleComponentSample
     * 2,If no need of Filter Module，please delete /app/TuSDK.bundle/textures，and disable module in CameraComponentSample and EditMultipleComponentSample
     *
     * iOS Framework：
     * TuSDK support arm64,armv7 and armv7s;
     * Every CPU compiling result contains two modes : Debug and Realse；
     *
     * Docs:http://tusdk.com/doc
     */
    
    // Debug Log Output (Optional)
    [TuSDK setLogLevel:lsqLogLevelDEBUG];
    
    /**
     *  Initialization,AppKey BundleID and Resource File Package must match with each other.
     *
     *  @param appkey  (Please go to http://tusdk.com ，request AppKey)
     */
    [TuSDK initSdkWithAppKey:@"77ce3b269d1d84ad-06-313kn1"];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor clearColor];
    
    // 初始化根控制器
    self.window.rootViewController = [[TuSDKICNavigationController alloc]initWithRootViewController:[DemoRootViewController controller]];
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
