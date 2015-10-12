//
//  Animation.h
//  ToDo List
//
//  Created by Viktor on 07.09.15.
//  Copyright (c) 2015 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface Animation : NSObject

+ (void) move_Label_Text_View_Right: (UIView*)label Points: (int) point
                              alpha: (CGFloat) alpha;

@end
