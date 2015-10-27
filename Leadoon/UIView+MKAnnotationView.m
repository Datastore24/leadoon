//
//  UIView+MKAnnotationView.m
//  mapViewStukorenko
//
//  Created by Viktor on 27.10.15.
//  Copyright © 2015 Viktor. All rights reserved.
//

#import "UIView+MKAnnotationView.h"
#import <MapKit/MapKit.h>

@implementation UIView (MKAnnotationView)


- (MKAnnotationView*) superAnnotationView
{
    if ([self isKindOfClass:[MKAnnotationView class]]) {
        
        return (MKAnnotationView*)self;
        
    }
    
    if (!self.superview) {
        return nil;
    }
    
    return [self.superview superAnnotationView];
}

@end
