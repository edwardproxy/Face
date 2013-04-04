//
//  AppDelegate.m
//  Left & Right Faces
//
//  Created by Edward Sun on 11-12-26.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"

#import "ViewController.h"

#import "Arrownock.h"

static NSString *urlString = @"";

@implementation AppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.viewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    
    NSString *appKey = @"mAfWPBnTl8oeJ6jpHBfmHth95V1SjWka"; // App Store
//    NSString *appKey = @"4kdDg4nJRIN2EpDwrqLUaV9n2DB7k4ZE"; // Test
    [Arrownock setup:appKey delegate:self.viewController];

    NSDictionary *apsDict = [[launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey] objectForKey:@"aps"];
    if (apsDict) {
        [self handlePush:apsDict];
    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
    [application setApplicationIconBadgeNumber:0];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [Arrownock setDeviceToken:deviceToken];
    NSArray *channels = [NSArray arrayWithObjects:@"Face", nil];
    [Arrownock register:channels overwrite:YES];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    NSDictionary *apsDict = [userInfo objectForKey:@"aps"];
    [self handlePush:apsDict];
}

- (void)handlePush:(NSDictionary *)apsDict
{    
    NSString *alertString = [apsDict objectForKey:@"alert"];
//    NSInteger badgeNumber = [[apsDict objectForKey:@"badge"] integerValue];
    NSArray *alertArray = [alertString componentsSeparatedByString:@"=>"];
    
    NSString *messageString = [NSString stringWithFormat:@"%@", [alertArray objectAtIndex:0]];
    urlString = [alertArray objectAtIndex:1];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"亲~"
                                                        message:messageString
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                              otherButtonTitles:@"去看看", nil];
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
}

@end
