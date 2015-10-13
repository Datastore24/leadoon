//
//  ParserCourier.m
//  Leadoon
//
//  Created by Кирилл Ковыршин on 13.10.15.
//  Copyright © 2015 Viktor. All rights reserved.
//

#import "ParserCourier.h"

@implementation ParserCourier

//Метод парсинга
+ (NSDictionary *)mts_mapping {
    
          return @{
                 @"email" : mts_key(email),
                 @"password" : mts_key(password),
                 @"phone" : mts_key(phone),
                 @"status" : mts_key(status),
                 @"has_transport" : mts_key(has_transport),
                 @"active_count" : mts_key(active_count),
                 @"active_amount" : mts_key(active_amount),
                 @"delivered_count" : mts_key(delivered_count),
                 @"delivered_amount" : mts_key(delivered_amount),
                 @"mulct" : mts_key(mulct),
                 @"enter" : mts_key(enter),
                 
                 
                 
                 };
    
    
}
@end
