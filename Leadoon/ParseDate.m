//
//  ParseDate.m
//  Weddup
//
//  Created by Кирилл Ковыршин on 08.10.15.
//  Copyright © 2015 datastore24. All rights reserved.
//

#import "ParseDate.h"

@implementation ParseDate

- (NSString *)dateFormatToDay {

  NSDate *currentDate = [NSDate date];
  NSDateFormatter *dateFormatter = [NSDateFormatter new];
  [dateFormatter setDateFormat:@"yyyy-MM-dd"];
  NSString *currentDateFormatter = [dateFormatter stringFromDate:currentDate];

  return currentDateFormatter;
}

- (NSString *)dateFormatTomorow {

  NSDate *currentDate = [NSDate date];
  NSTimeInterval secondsPerDay = 24 * 60 * 60;
  NSDate *yesterday = [currentDate dateByAddingTimeInterval:+secondsPerDay];
  NSDateFormatter *dateFormatter = [NSDateFormatter new];
  [dateFormatter setDateFormat:@"yyyy-MM-dd"];
  NSString *currentDateFormatter = [dateFormatter stringFromDate:yesterday];
  return currentDateFormatter;
}



@end
