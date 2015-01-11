//
//  AppDelegate.m
//  NHSlideShow
//
//  Created by Shahan on 04/01/2015.
//  Copyright (c) 2015 Shahan. All rights reserved.
//

#import "AppDelegate.h"
#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
#define IS_IPHONE_4 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )480 ) < DBL_EPSILON )
#define IS_IPAD     ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )1024 ) < DBL_EPSILON )

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
     /*
     //
     //Uncomment this code if you want to use Non-Storyboard mode. i.e., ViewController
     // First change the setting from project properties to not use
     //
     self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
     ViewController *vc= [[ViewController alloc] initWithNibName:[@"ViewController" stringByAppendingFormat:@"%@", [self appendDeviceSuffix]] bundle:nil];
    
     self.navController = [[UINavigationController alloc] initWithRootViewController:vc];
     self.window.rootViewController = self.navController;
    [self.navController setNavigationBarHidden:YES];
    
    [self.window makeKeyAndVisible]; */
    
    // Override point for customization after application launch.
    return YES;
}

-(NSString *)appendDeviceSuffix
{
    if(IS_IPHONE_5)
        return @"~iPhone5";
    
    if(IS_IPAD)
        return @"~iPad";

    return @"";
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
