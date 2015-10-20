//
//  ParserResponseOrder.m
//  Leadoon
//
//  Created by Кирилл Ковыршин on 19.10.15.
//  Copyright © 2015 Viktor. All rights reserved.
//

#import "ParserResponseOrder.h"
#import "ParserOrder.h"

@implementation ParserResponseOrder
- (NSMutableArray *)parsing:(id)response

{
    NSMutableArray * arrayResponse = [[NSMutableArray alloc] init];
    //Если это обновление удаляем все объекты из массива и грузим заного
    
    //
    ParserOrder *parserOrder = [[ParserOrder alloc] init];
   
    if ([response isKindOfClass:[NSDictionary class]]) {
        
        [parserOrder mts_setValuesForKeysWithDictionary:response];
        
        [arrayResponse addObject:parserOrder];
        return arrayResponse;
    }
    return nil;
}
@end
