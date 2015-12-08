//
//  ParserResponseFinance.m
//  Leadoon
//
//  Created by Кирилл Ковыршин on 08.12.15.
//  Copyright © 2015 Viktor. All rights reserved.
//

#import "ParserResponseFinance.h"
#import "ParserFinance.h"

@implementation ParserResponseFinance
- (NSMutableArray *)parsing:(id)response

{
    NSMutableArray * arrayResponse = [[NSMutableArray alloc] init];
    //Если это обновление удаляем все объекты из массива и грузим заного
    
    //
    ParserFinance *parserFinance = [[ParserFinance alloc] init];
    
    if ([response isKindOfClass:[NSDictionary class]]) {
        
        [parserFinance mts_setValuesForKeysWithDictionary:response];
        
        [arrayResponse addObject:parserFinance];
        return arrayResponse;
    }
    return nil;
}
@end
