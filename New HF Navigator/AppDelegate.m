//
//  AppDelegate.m
//  HF Navigator
//
//  Created by Ethan on 10/29/14.
//  Copyright (c) 2014 Ethan Thomas. All rights reserved.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>

@interface AppDelegate ()

@end

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [Parse enableLocalDatastore];

    [Parse setApplicationId:@"C9vun7KPxdDKBsVcuzwxlyRDEC83hekR9O6yeX3e"
                  clientKey:@"OoIEedGp2uIu0yWImnlqDTNunEPLaf0O6jTe4IgR"];
        
    
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        UIUserNotificationSettings* notificationSettings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound categories:nil];
        [application registerUserNotificationSettings:notificationSettings];
        [application registerForRemoteNotifications];
    } else {
        [application registerForRemoteNotificationTypes: (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
        PFInstallation *currentInstallation = [PFInstallation currentInstallation];
        PFACL *defaultACL = [PFACL ACL];
        [defaultACL setPublicReadAccess:YES];
        [defaultACL setPublicWriteAccess:YES];
        [currentInstallation setACL:defaultACL];
        [currentInstallation addUniqueObject:@"Broadcast" forKey:@"channels"];
        [PFACL setDefaultACL:defaultACL withAccessForCurrentUser:YES];
        [currentInstallation saveInBackground];
    }
    
    [[UINavigationBar appearance] setBarTintColor:UIColorFromRGB(0x222222)];
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0];
    shadow.shadowOffset = CGSizeMake(0, 1);
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0], NSForegroundColorAttributeName,
                                                           shadow, NSShadowAttributeName,
                                                           [UIFont fontWithName:@"HelveticaNeue-Light" size:20.0], NSFontAttributeName, nil]];[[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

    return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)newDeviceToken
{
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:newDeviceToken];
    [currentInstallation setACL:[currentInstallation ACL]];
    PFACL *defaultACL = [PFACL ACL];
    [defaultACL setPublicReadAccess:YES];
    [defaultACL setPublicWriteAccess:YES];
    [currentInstallation setACL:defaultACL];
    [currentInstallation addUniqueObject:@"TestiOS" forKey:@"channels"];
    [currentInstallation addUniqueObject:@"Broadcast" forKey:@"channels"];
    [PFACL setDefaultACL:defaultACL withAccessForCurrentUser:YES];
    [currentInstallation saveInBackground];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotifications:(NSDictionary *)userInfo {
    [PFPush handlePush:userInfo];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"ERROR IS %@", error);
}

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    [application registerForRemoteNotifications];
}

@end
