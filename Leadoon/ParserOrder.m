//
//  ParserOrder.m
//  Leadoon
//
//  Created by Кирилл Ковыршин on 19.10.15.
//  Copyright © 2015 Viktor. All rights reserved.
//

#import "ParserOrder.h"

@implementation ParserOrder

+ (NSDictionary *)mts_mapping {

  return @{
    @"order_id" : mts_key(order_id),
    @"service_id" : mts_key(service_id),
    @"customer_name" : mts_key(customer_name),
    @"address" : mts_key(address),
    @"flat" : mts_key(flat),
    @"porch" : mts_key(porch),
    @"intercom" : mts_key(intercom),
    @"comment" : mts_key(comment),
    @"discount" : mts_key(discount),
    @"shipping" : mts_key(shipping),
    @"orderLong" : mts_key(orderLong),
    @"orderLat" : mts_key(orderLat),
    @"phone1" : mts_key(phone1),
    @"phone2" : mts_key(phone2),
    @"payment_status" : mts_key(payment_status),
    @"getting_type" : mts_key(getting_type),
    @"delivery_date" : mts_key(delivery_date),
    @"delivery_string" : mts_key(delivery_string),
    @"delivery_time_from" : mts_key(delivery_time_from),
    @"delivery_time_to" : mts_key(delivery_time_to),
    @"metro_id" : mts_key(metro_id),
    @"metro_line_id" : mts_key(metro_line_id),
    @"status" : mts_key(status),
    @"w_from" : mts_key(w_from),
    @"w_to" : mts_key(w_to),
    @"items" : mts_key(items),
    @"amount" : mts_key(amount),
    @"telephony" : mts_key(telephony),
    @"order_summ" : mts_key(order_summ),

  };
}

@end
