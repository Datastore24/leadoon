//
//  ParserResponseOrders.m
//  Leadoon
//
//  Created by Кирилл Ковыршин on 16.10.15.
//  Copyright © 2015 Viktor. All rights reserved.
//

#import "ParserResponseOrders.h"
#import "ParserOrders.h"


@implementation ParserResponseOrders
//Метод обрабатывающий ответ сервера
- (void)parsing:(id)response
       andArray:(NSMutableArray *)arrayResponse
       andBlock:(void (^)(void))block {

    
    if ([response isKindOfClass:[NSArray class]]) {
        NSArray *resonse = (NSArray *)response;
        
        for (int i = 0; i < resonse.count; i++) {
            
            ParserOrders *parserOrders = [[ParserOrders alloc] init];
            [parserOrders mts_setValuesForKeysWithDictionary:[response objectAtIndex:i]];
            
          
            [arrayResponse addObject:parserOrders];
            
            
            //Отслеживаем конец цикла
            if ([[resonse objectAtIndex:i] isEqual:[resonse lastObject]]) {
                
                block();
                
            }
        }
        
        
        //Конец цикла
        
        
    }else if ([response isKindOfClass:[NSDictionary class]]) {
        
        
    }
}

@end
