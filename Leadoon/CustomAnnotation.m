//
//  CustomAnnotation.m
//  RosAvtoDengi
//
//  Created by Viktor on 10.10.15.
//  Copyright © 2015 Viktor. All rights reserved.
//

#import "CustomAnnotation.h"

@implementation CustomAnnotation


- (instancetype)initWithLatitude: (double) latitude Longitude: (double) longitude
{
    self = [super init];
    if (self) {
        _coordinate.latitude = latitude;
        _coordinate.longitude = longitude;
    }
    return self;
}

@end
