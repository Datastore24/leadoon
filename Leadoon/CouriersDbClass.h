//
//  CouriersDbClass.h
//  Leadoon
//
//  Created by Кирилл Ковыршин on 13.10.15.
//  Copyright © 2015 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CouriersDbClass : NSObject
-(void) authFist: (NSString *) email andPassword: (NSString *) password andEnter: (NSNumber *) enter;
-(NSArray *) showAllUsers;
- (void)deleteCourier;
- (BOOL)checkUsers:(NSString*) email andPassword:(NSString*) password;
@end
