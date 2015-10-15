//
//  APIPostClass.h
//  Leadoon
//
//  Created by Кирилл Ковыршин on 15.10.15.
//  Copyright © 2015 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

@interface APIPostClass : NSObject
-(void) postDataToServerWithParams: (NSDictionary *) params method:(NSString*) method complitionBlock: (void (^) (id response)) compitionBack;
@end
