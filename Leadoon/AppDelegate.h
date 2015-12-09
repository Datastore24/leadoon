//
//  AppDelegate.h
//  Leadoon
//
//  Created by Viktor on 11.10.15.
//  Copyright © 2015 Viktor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    NSTimer *timer;
}

@property (nonatomic, retain) NSTimer *timer;

@property (strong, nonatomic) UIWindow *window;


@end

