//
//  Couriers+CoreDataProperties.h
//  Leadoon
//
//  Created by Кирилл Ковыршин on 13.10.15.
//  Copyright © 2015 Viktor. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Couriers.h"

NS_ASSUME_NONNULL_BEGIN

@interface Couriers (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *email;
@property (nullable, nonatomic, retain) NSString *password;
@property (nullable, nonatomic, retain) NSNumber *enter;
@property (nullable, nonatomic, retain) NSString *courierId;

@end

NS_ASSUME_NONNULL_END
