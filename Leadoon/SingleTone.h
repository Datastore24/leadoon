//
//  SingleTone.h
//  Lesson6
//
//  Created by Кирилл Ковыршин on 01.10.15.
//  Copyright © 2015 datastore24. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@interface SingleTone : NSObject{
    NSString *someProperty;
}

@property (strong,nonatomic) NSMutableArray* parsingArray;

+ (id)sharedManager;

@end
