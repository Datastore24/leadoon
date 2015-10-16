//
//  ParserOrders.h
//  Leadoon
//
//  Created by Кирилл Ковыршин on 16.10.15.
//  Copyright © 2015 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Motis/Motis.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>

@interface ParserOrders : NSObject

@property (strong,nonatomic) NSString * order_id;
@property (strong,nonatomic) NSString * service_id;
@property (strong,nonatomic) NSString * getting_type;
@property (strong,nonatomic) NSString * order_type;
@property (strong,nonatomic) NSString * delivery_date;
@property (strong,nonatomic) NSString * delivery_time_from;
@property (strong,nonatomic) NSString * delivery_time_to;
@property (strong,nonatomic) NSString * delivery_string;
@property (strong,nonatomic) NSString * status;
@property (strong,nonatomic) NSString * metro_line_id;
@property (strong,nonatomic) NSString * metro_id;
@property (strong,nonatomic) NSString * wfrom;
@property (strong,nonatomic) NSString * wto;



@end
