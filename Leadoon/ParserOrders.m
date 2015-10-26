//
//  ParserOrders.m
//  Leadoon
//
//  Created by Кирилл Ковыршин on 16.10.15.
//  Copyright © 2015 Viktor. All rights reserved.
//

#import "ParserOrders.h"

@implementation ParserOrders
//Метод парсинга
+ (NSDictionary *)mts_mapping {
    
    return @{
             @"order_id" : mts_key(order_id),
             @"service_id" : mts_key(service_id),
             @"getting_type" : mts_key(getting_type), 
             @"order_type" : mts_key(order_type),
             @"delivery_date" : mts_key(delivery_date),
             @"delivery_time_from" : mts_key(delivery_time_from),
             @"delivery_time_to" : mts_key(delivery_time_to),
             @"delivery_string" : mts_key(delivery_string),
             @"status" : mts_key(status),
             @"metro_line_id" : mts_key(metro_line_id),
             @"metro_id" : mts_key(metro_id),
             @"long" : mts_key(olong),
             @"lat" : mts_key(olat),
             @"w_from" : mts_key(wfrom),
             @"w_to" : mts_key(wto),
             @"order_count" : mts_key(order_count),
             
             };
    
    
}

@end
