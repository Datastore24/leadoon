//
//  ParserCourier.h
//  Leadoon
//
//  Created by Кирилл Ковыршин on 13.10.15.
//  Copyright © 2015 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Motis/Motis.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>


@interface ParserCourier : NSObject

@property (strong,nonatomic) NSString * email;
@property (strong,nonatomic) NSString * password;
@property (strong,nonatomic) NSString * phone;
@property (strong,nonatomic) NSString * status;
@property (strong,nonatomic) NSString * has_transport;
@property (strong,nonatomic) NSString * active_count;
@property (strong,nonatomic) NSString * active_amount;
@property (strong,nonatomic) NSString * delivered_count;
@property (strong,nonatomic) NSString * delivered_amount;
@property (strong,nonatomic) NSString * mulct;
@property (strong,nonatomic) NSString * enter;





@end
