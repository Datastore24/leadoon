//
//  LabelsTableViewCell.m
//  Leadoon
//
//  Created by Viktor on 15.10.15.
//  Copyright © 2015 Viktor. All rights reserved.
//

#import "LabelsTableViewCell.h"

@implementation LabelsTableViewCell

- (UILabel*) lableTypeOfOrder: (NSString *) typeOrder {
    
    UILabel * typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 30)];
    typeLabel.text = typeOrder;
    typeLabel.backgroundColor = [UIColor clearColor];
    
    return typeLabel;
    
}

@end
