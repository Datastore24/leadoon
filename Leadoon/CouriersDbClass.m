//
//  CouriersDbClass.m
//  Leadoon
//
//  Created by Кирилл Ковыршин on 13.10.15.
//  Copyright © 2015 Viktor. All rights reserved.
//

#import "CouriersDbClass.h"
#import "Couriers.h"
#import <MagicalRecord/MagicalRecord.h>

@implementation CouriersDbClass

-(void) authFist: (NSString *) email andPassword: (NSString *) password andEnter: (NSNumber *) enter{
    [MagicalRecord setupCoreDataStackWithStoreNamed:@"Couriers.sqlite"];
    NSManagedObjectContext *localContext    = [NSManagedObjectContext MR_context];
    Couriers *couriers = [Couriers MR_createEntityInContext:localContext];
    couriers.email = email;
    couriers.password = password;
    couriers.enter = enter;
    couriers.courierId=@"1";
     [localContext MR_saveToPersistentStoreAndWait];
}

- (void)deleteCourier
{
    // Get the local context
    NSManagedObjectContext *localContext    = [NSManagedObjectContext MR_context];
    
    // Retrieve the first person who have the given firstname
    NSPredicate *predicate                  = [NSPredicate predicateWithFormat:@"courierId ==[c] 1"];
    Couriers *couriersFounded                   = [Couriers MR_findFirstWithPredicate:predicate inContext:localContext];
    
    if (couriersFounded)
    {
        // Delete the person found
        [couriersFounded MR_deleteEntityInContext:localContext];
        
        // Save the modification in the local context
        // With MagicalRecords 2.0.8 or newer you should use the MR_saveNestedContexts
        [localContext MR_saveToPersistentStoreAndWait];
    }
}

- (void)updateCourier:(NSString *)email andPassword:(NSString *)password andEnter:(NSNumber *) enter
{
    // Get the local context
    NSManagedObjectContext *localContext    = [NSManagedObjectContext MR_context];
    
    // Retrieve the first person who have the given firstname
    NSPredicate *predicate                  = [NSPredicate predicateWithFormat:@"email ==[c] %@ AND login ==[c] %@ AND enter ==[c] %@", email, password, enter];
    Couriers *couriersFounded                   = [Couriers MR_findFirstWithPredicate:predicate inContext:localContext];
    
    if (couriersFounded)
    {
        
        couriersFounded.email = email;
        couriersFounded.password = password;
        couriersFounded.enter = enter;
        
        // Save the modification in the local context
        // With MagicalRecords 2.0.8 or newer you should use the MR_saveNestedContexts
        [localContext MR_saveToPersistentStoreAndWait];
    }
}

- (BOOL)checkUsers{
    
    NSManagedObjectContext *localContext    = [NSManagedObjectContext MR_context];
    
    
    NSPredicate *predicate                  = [NSPredicate predicateWithFormat:@"courierId ==[c] 1"];
    Couriers *courierFounded                   = [Couriers MR_findFirstWithPredicate:predicate inContext:localContext];
    
    // If a person was founded
    if (courierFounded)
    {
        return YES;
    }else{
        return NO;
    }
}

-(NSArray *) showAllUsers{
    NSArray *users            = [Couriers MR_findAll];
    return users;
}


@end
