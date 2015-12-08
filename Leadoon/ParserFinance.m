//
//  ParserFinance.m
//  Leadoon
//
//  Created by Кирилл Ковыршин on 08.12.15.
//  Copyright © 2015 Viktor. All rights reserved.
//

#import "ParserFinance.h"

@implementation ParserFinance

+ (NSDictionary *)mts_mapping {
    
    return @{
             @"get_money" : mts_key(get_money),
             @"plus_money" : mts_key(plus_money),
             @"old_money" : mts_key(old_money),
             @"pay_money" : mts_key(pay_money),
             @"penalty" : mts_key(penalty),
             @"total" : mts_key(total),
             
             
             };
}


@end
