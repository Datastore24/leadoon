//
//  ParserResponseOrders.h
//  Leadoon
//
//  Created by Кирилл Ковыршин on 16.10.15.
//  Copyright © 2015 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ParserResponseOrders : NSObject
- (void)parsing:(id)response
       andArray:(NSMutableArray *)arrayResponse
       andBlock:(void (^)(void))block;
@end
