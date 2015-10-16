//
//  LabelsTableViewCall.m
//  Leadoon
//
//  Created by Viktor on 15.10.15.
//  Copyright © 2015 Viktor. All rights reserved.
//

#import "LabelsTableViewCall.h"
#import "UIColor+HexColor.h"

@interface LabelsTableViewCall ()

@property (strong, nonatomic) UILabel* typeLabel;

@end

@implementation LabelsTableViewCall

//Тип заказа----------------------------------------------------
- (UILabel*)labelTypeTableViewCell:(NSString*)latebType
{

    self.typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.f, 10.f, 100.f, 20.f)];
    self.typeLabel.text = latebType;
    self.typeLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:20];

    NSString* blueString = @"Заказ";
    NSString* greenString = @"Забор";
    NSString* brownString = @"Закупка";

    if (self.typeLabel.text == blueString) {

        self.typeLabel.textColor = [UIColor colorWithHexString:@"0e59db"];
    }

    else if (self.typeLabel.text == greenString) {

        self.typeLabel.textColor = [UIColor colorWithHexString:@"2c6530"];
    }

    else if (self.typeLabel.text == brownString) {

        self.typeLabel.textColor = [UIColor colorWithHexString:@"cc8023"];
    }

    else {
        self.typeLabel.textColor = [UIColor blackColor];
    }

    return self.typeLabel;
}

//Картинка типа lableTableViewCell-------------------------------------------

- (UIImageView*)imageViewTypeTableView: (NSString *) order_type
{
   

    NSString* nameImage;

    if ([order_type isEqual:@"2"]) {

        nameImage = @"imageMetro1.png";
    }

    else {
        nameImage = @"imageMetro2.png";
    }

    UIImage* image = [UIImage imageNamed:nameImage];

    UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 55, 20, 20)];
    imageView.image = image;

    return imageView;
}

//Станция метро-------------------------------------------------
- (UILabel*)labelMetroStationName:(NSString*)stationName
{

    UILabel* labelMetro = [[UILabel alloc] initWithFrame:CGRectMake(35, 55, 100, 20)];

    labelMetro.text = stationName;
    labelMetro.font = [UIFont fontWithName:@"HelveticaNeue" size:12];

    return labelMetro;
}

//Изображение тележки---------------------------------------------
- (UIImageView*)imageViewBasketTableView
{

    NSString* imageName = @"basket.png";
    UIImage* imageBusket = [UIImage imageNamed:imageName];

    UIImageView* imageViewBusket = [[UIImageView alloc] initWithFrame:CGRectMake(120, 55, 20, 20)];
    imageViewBusket.image = imageBusket;

    return imageViewBusket;
}

//Вес, кол-во заказов---------------------------------------------
- (UILabel*)weightAndNumberOfOrders:(NSString*)stringOrders
{
    UILabel* labelWeightAndNumbers = [[UILabel alloc] initWithFrame:CGRectMake(150, 55, 80, 20)];
    labelWeightAndNumbers.text = stringOrders;
    labelWeightAndNumbers.font = [UIFont fontWithName:@"HelveticaNeue" size:12];

    return labelWeightAndNumbers;
}

//Дней осталось---------------------------------------------------
- (UILabel*)labelDaysLeft:(NSString*)stringDays
{
    UILabel* labelDays = [[UILabel alloc] initWithFrame:CGRectMake(130, 5, 78, 15)];
    labelDays.text = stringDays;
    labelDays.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    labelDays.textColor = [UIColor colorWithHexString:@"5b038d"];

    return labelDays;
}

//Временной интервал-----------------------------------------------
- (UILabel*)labelTimeInterval:(NSString*)strigInterval
{
    UILabel* labelTimeInterval = [[UILabel alloc] initWithFrame:CGRectMake(208, 5, 100, 15)];
    labelTimeInterval.text = strigInterval;
    labelTimeInterval.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    labelTimeInterval.textColor = [UIColor colorWithHexString:@"5b038d"];

    return labelTimeInterval;
}

//Осталось не изменяемый label-------------------------------------
- (UILabel*)labelLineLeft
{
    UILabel* labelLine = [[UILabel alloc] initWithFrame:CGRectMake(130, 30, 60, 12)];
    labelLine.text = @"Осталось:";
    labelLine.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
    labelLine.alpha = 0.5f;

    return labelLine;
}

//Оставшееся время выполнения заказа--------------------------------
- (UILabel*)labelTimeRemaining:(NSString*)remainingString
{
    UILabel* labelTime = [[UILabel alloc] initWithFrame:CGRectMake(190, 30, 100, 12)];
    labelTime.text = remainingString;
    labelTime.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
    labelTime.alpha = 0.5f;

    return labelTime;
}

//Формирование заказа----------------------------------------------
- (UILabel*)labelFormation:(NSString*)stringFormation
{
    
    UILabel* labelWithFormation = [[UILabel alloc] initWithFrame:CGRectMake(10, 35, 120, 14)];
    labelWithFormation.text = stringFormation;
    labelWithFormation.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
    labelWithFormation.textColor = [UIColor colorWithHexString:@"2c6530"];

    return labelWithFormation;
}

@end
