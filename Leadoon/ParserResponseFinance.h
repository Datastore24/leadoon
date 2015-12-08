//
//  ParserResponseFinance.h
//  Leadoon
//
//  Created by Кирилл Ковыршин on 08.12.15.
//  Copyright © 2015 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ParserResponseFinance : NSObject
- (NSMutableArray *)parsing:(id)response;
@end
