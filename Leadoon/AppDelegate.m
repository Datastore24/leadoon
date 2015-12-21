//
//  AppDelegate.m
//  Leadoon
//
//  Created by Viktor on 11.10.15.
//  Copyright © 2015 Viktor. All rights reserved.
//

#import "AppDelegate.h"
#import "CouriersDbClass.h"
#import <MagicalRecord/MagicalRecord.h>
#import "InternetErrorViewController.h"
#import "MainView.h"
#import "Reachability.h"



@interface AppDelegate ()
@property (assign,nonatomic) BOOL isError;


@end

@implementation AppDelegate

@synthesize timer;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self startTimer];
    [MagicalRecord setupCoreDataStackWithStoreNamed:@"Couriers.sqlite"];
    self.isError = NO;
    [self showHideAlert];
    
    return YES;
}

- (void)dealloc {
    if ([timer isValid]) {
        [timer invalidate];
    }
    self.timer = nil;
    
    
    
}

- (void)startTimer {
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:10.0f
                                                  target:self
                                                selector:@selector(showHideAlert)
                                                userInfo:nil
                                                 repeats:YES];
}



- (void)stopTimer {
    if ([timer isValid]) {
        [timer invalidate];
    }
}




- (NSString*)checkForNetwork
{
    // check if we've got network connectivity
    Reachability *myNetwork = [Reachability reachabilityWithHostname:@"google.com"];
    NetworkStatus myStatus = [myNetwork currentReachabilityStatus];
    
    switch (myStatus) {
        case NotReachable:
            return @"0";
            break;
            
        case ReachableViaWWAN:
            return @"1";
            break;
            
        case ReachableViaWiFi:
            return @"1";
            break;
            
        default:
            return @"1";
            break;
    }
    return @"0";
}


-(void) showHideAlert{
    NSString * result =[self checkForNetwork];
    
    if([result isEqualToString:@"0"]){
        
        if(self.isError==NO){
            self.isError = YES;
            self.window.rootViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"internetError"];
            
        }
        
        
        
    }else{
      
        if(self.isError==YES){
            
            self.isError = NO;
            
       self.window.rootViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"MainNavController"];
            
        }
        
    }
    
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [self stopTimer];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [self startTimer];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [self startTimer];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [MagicalRecord cleanUp];
    [self stopTimer];
}

@end
