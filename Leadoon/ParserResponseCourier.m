//
//  ParserResponseCourier.m
//  Leadoon
//
//  Created by Кирилл Ковыршин on 13.10.15.
//  Copyright © 2015 Viktor. All rights reserved.
//

#import "ParserResponseCourier.h"
#import "ParserCourier.h"

@implementation ParserResponseCourier

- (NSMutableArray *)parsing:(id)response

{
    NSMutableArray * arrayResponse = [[NSMutableArray alloc] init];
    //Если это обновление удаляем все объекты из массива и грузим заного
    
    //
    ParserCourier *parserCourier = [[ParserCourier alloc] init];
    
    if ([response isKindOfClass:[NSDictionary class]]) {
        
        [parserCourier mts_setValuesForKeysWithDictionary:response];
        
        [arrayResponse addObject:parserCourier];
        return arrayResponse;
    }
    return nil;
}


@end
