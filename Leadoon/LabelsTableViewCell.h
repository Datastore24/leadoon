//
//  LabelsTableViewCell.h
//  Leadoon
//
//  Created by Viktor on 15.10.15.
//  Copyright © 2015 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LabelsTableViewCell : NSObject

//Метод добавление лейблов в TableViewCell
- (UILabel*) lableTypeOfOrder: (NSString *) typeOrder;

@end
