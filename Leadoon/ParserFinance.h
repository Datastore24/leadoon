//
//  ParserFinance.h
//  Leadoon
//
//  Created by Кирилл Ковыршин on 08.12.15.
//  Copyright © 2015 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Motis/Motis.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>

@interface ParserFinance : NSObject

@property (strong,nonatomic) NSString * get_money;
@property (strong,nonatomic) NSString * plus_money;
@property (strong,nonatomic) NSString * old_money;
@property (strong,nonatomic) NSString * pay_money;
@property (strong,nonatomic) NSString * penalty;
@property (strong,nonatomic) NSString * total;

@end
