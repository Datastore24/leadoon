//
//  LabelsTableViewCall.h
//  Leadoon
//
//  Created by Viktor on 15.10.15.
//  Copyright © 2015 Viktor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LabelsTableViewCall : NSObject

//Тип заказа----------------------------------------------------
- (UILabel*) labelTypeTableViewCell: (NSString*) latebType;

//Картинка типа заказа------------------------------------------
- (UIImageView*)imageViewTypeTableView: (NSString *) order_type;

//Станция метро-------------------------------------------------
- (UIView*) roundMetroView:(NSString *) lineID;
- (UILabel*)labelMetroStationName:(NSString*)stationID;

//Изображение тележки---------------------------------------------
- (UIImageView *) imageViewBasketTableView;

//Вес, кол-во заказов---------------------------------------------
- (UILabel*)weightAndNumberOfOrders:(NSString*)stringOrders;

//Дней осталось---------------------------------------------------
- (UILabel*) labelDaysLeft: (NSString*) stringDays;

//Временной интервал-----------------------------------------------
- (UILabel*)labelTimeInterval:(NSString*)strigInterval;

//Осталось не изменяемый label-------------------------------------
- (UILabel *) labelLineLeft;

//Оставшееся время выполнения заказа--------------------------------
- (UILabel*) labelTimeRemaining: (NSString *) remainingString;

//Формирование заказа----------------------------------------------
- (UILabel*)labelFormation:(NSString*)stringFormation;


//Дата выполнения заказа----------------------------------------------
- (UILabel*)labelDataFinish:(NSString*)stringFinish;

//Тип оплаты----------------------------------------------------------
- (UILabel*)labelPaymentType:(NSString*)stringPaymentType;

//Сумма---------------------------------------------------------------
- (UILabel*)labelSum:(NSString*)strigSum;

//Заработок не изменяемый label-------------------------------------
- (UILabel*)labelEarnings;

//Сумма заработка--------------------------------------------------
- (UILabel*)labelEarningsSum:(NSString*)earningsSumString;

@end
