//
//  ParserOrder.h
//  Leadoon
//
//  Created by Кирилл Ковыршин on 19.10.15.
//  Copyright © 2015 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Motis/Motis.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>


@interface ParserOrder : NSObject


@property (strong,nonatomic) NSString * order_id;
@property (strong,nonatomic) NSString * service_id;
@property (strong,nonatomic) NSString * customer_name;
@property (strong,nonatomic) NSString * address;
@property (strong,nonatomic) NSString * flat;
@property (strong,nonatomic) NSString * porch;
@property (strong,nonatomic) NSString * intercom;
@property (strong,nonatomic) NSString * comment;
@property (strong,nonatomic) NSString * discount;
@property (strong,nonatomic) NSString * shipping;
@property (strong,nonatomic) NSString * orderLong;
@property (strong,nonatomic) NSString * orderLat;
@property (strong,nonatomic) NSString * phone1;
@property (strong,nonatomic) NSString * phone2;
@property (strong,nonatomic) NSString * payment_status;
@property (strong,nonatomic) NSString * getting_type;
@property (strong,nonatomic) NSString * order_type;
@property (strong,nonatomic) NSString * delivery_date;
@property (strong,nonatomic) NSString * delivery_string;
@property (strong,nonatomic) NSString * delivery_time_from;
@property (strong,nonatomic) NSString * delivery_time_to;
@property (strong,nonatomic) NSString * metro_id;
@property (strong,nonatomic) NSString * metro_line_id;
@property (strong,nonatomic) NSString * status;
@property (strong,nonatomic) NSString * w_from;
@property (strong,nonatomic) NSString * w_to;
@property (strong,nonatomic) NSArray * items;
@property (strong,nonatomic) NSString * order_summ;
@property (strong,nonatomic) NSString * amount;


@end
