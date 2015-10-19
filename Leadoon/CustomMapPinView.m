//
//  CustomMapPinView.m
//  RosAvtoDengi
//
//  Created by Viktor on 10.10.15.
//  Copyright © 2015 Viktor. All rights reserved.
//

#import "CustomMapPinView.h"

@implementation CustomMapPinView

- (instancetype)initWithImageBlue
{
    self = [super init];
    if (self) {
        
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -10, 25, 40)];
        
        imageView.image = [UIImage imageNamed:@"bluePin.png"];
        
        [self addSubview:imageView];
        

    }
    return self;
}

- (instancetype)initWithImageBrown
{
    self = [super init];
    if (self) {
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -10, 25, 40)];
        
        imageView.image = [UIImage imageNamed:@"brownPin.png"];
        
        [self addSubview:imageView];
    }
    return self;
}

- (instancetype)initWithImageGreen
{
    self = [super init];
    if (self) {
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -10, 25, 40)];
        
        imageView.image = [UIImage imageNamed:@"greenPin.png"];
        
        [self addSubview:imageView];
    }
    return self;
}

@end
