//
//  DetailsScoreboardOrderView.m
//  Leadoon
//
//  Created by Viktor on 16.10.15.
//  Copyright © 2015 Viktor. All rights reserved.
//

#import "DetailsScoreboardOrderView.h"
#import "UIColor+HexColor.h"
#import "Animation.h"
#import "MapViewOrder.h"
#import "SettingsView.h"

#import "SingleTone.h"
#import <SCLAlertView-Objective-C/SCLAlertView.h>

#import "APIClass.h"
#import "APIPostClass.h"
#import "ParserOrder.h"
#import "ParserCourier.h"
#import "ParserResponseOrder.h"
#import "ParseDate.h"
#import "HeightForText.h"

#import "MyOrdersView.h"

@interface DetailsScoreboardOrderView ()

@property (strong, nonatomic) UIButton* buttonAssigned;
@property (strong, nonatomic) UIButton* buttonOnMap;

@property (weak, nonatomic) IBOutlet UIView* topBarDetailScoreboardOrderView; //Терхний бар DetailScoreboardOrderView
@property (weak, nonatomic) IBOutlet UIButton* buttonBackDetailScoreboardOrderView; //Кнопка возврата
@property (weak, nonatomic) IBOutlet UILabel* labelTopBarView; //Текст заголовка
@property (weak, nonatomic) IBOutlet UIScrollView* mainScrollViewOrder; //основной scrollView
@property (weak, nonatomic) IBOutlet UIButton* buttonSettingDetailOrderView; //Кнопка настроек
@property (strong, nonatomic) NSArray* arrayResponse; //Тестовый массив списка товаров

@property (assign, nonatomic) CGFloat heightAllItems; //Высота всех товаров

@property (assign, nonatomic) CGFloat textFieldCommentsHeight; //Высота комментариев
@property (assign, nonatomic) CGFloat labelNameItemsHeight; //ВЫсота наименования товара

@property (strong, nonatomic) NSArray * parseItems; //Колличетсво товаров

@end

@implementation DetailsScoreboardOrderView

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.arrayResponse = [NSArray array];
    
    self.mainScrollViewOrder.backgroundColor = [UIColor groupTableViewBackgroundColor];

    //Параметры основного view---------------------------------------------------------------
    self.view.backgroundColor = [UIColor whiteColor];

    //Параметра верхнего Бара DetailScoreboardOrderView--------------------------------------
    self.topBarDetailScoreboardOrderView.backgroundColor = [UIColor whiteColor];
    self.topBarDetailScoreboardOrderView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.topBarDetailScoreboardOrderView.layer.borderWidth = 1.f;

//    self.mainScrollViewOrder.bounces = NO; //Отключения оттягивани

#pragma marc - constructorScrollView
    //Зарос к API
    [self getApiOrder:^{
        ParserOrder* parser = [self.arrayResponse objectAtIndex:0];
        self.parseItems = parser.items;

        self.labelTopBarView.text = [NSString stringWithFormat:@"№ 000%@", parser.order_id];
        //Формирование заказа----------------------------------------------
        UILabel* labelWithFormation = [[UILabel alloc] initWithFrame:CGRectMake(210, 10, 120, 12)];
        //Статус заказа
        if ([parser.status integerValue] == 40) {
            labelWithFormation.text = @"Формируется...";
        }
        else {
            labelWithFormation.text = @"Сформирован";
        }

        labelWithFormation.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
        labelWithFormation.textColor = [UIColor colorWithHexString:@"2c6530"];
        [self.mainScrollViewOrder addSubview:labelWithFormation];

        //Дней осталось---------------------------------------------------
        UILabel* labelDays = [[UILabel alloc] initWithFrame:CGRectMake(40, 20, 78, 13)];
        ParseDate* parseDate = [[ParseDate alloc] init];
        //Изменения даты
        if ([parser.delivery_date isEqual:[parseDate dateFormatToDay]]) {
            labelDays.text = @"Cегодня";
        }
        else if ([parser.delivery_date isEqual:[parseDate dateFormatTomorow]]) {

            labelDays.text = @"Завтра";
        }
        else {
            labelDays.text = parser.delivery_date;
        }
        labelDays.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
        labelDays.textColor = [UIColor blackColor];
        [self.mainScrollViewOrder addSubview:labelDays];
        

        //Временной интервал-----------------------------------------------
        UILabel* labelTimeInterval = [[UILabel alloc] initWithFrame:CGRectMake(95, 20, 100, 12)];
        //Обрезаем последние :00
        parser.delivery_time_from = [parser.delivery_time_from substringToIndex:[parser.delivery_time_from length] - 3];
        parser.delivery_time_to = [parser.delivery_time_to substringToIndex:[parser.delivery_time_to length] - 3];
        //

        //Вывод диапазона времени доставки
        NSString* resultDeliveryTime;
        if (!parser.delivery_time_to) {
            resultDeliveryTime = [NSString stringWithFormat:@"%@", parser.delivery_time_from];
        }
        else {
            resultDeliveryTime = [NSString stringWithFormat:@"%@ - %@", parser.delivery_time_from, parser.delivery_time_to];
        }

        labelTimeInterval.text = resultDeliveryTime;
        labelTimeInterval.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
        labelTimeInterval.textColor = [UIColor blackColor];
        [self.mainScrollViewOrder addSubview:labelTimeInterval];

        //Осталось не изменяемый label-------------------------------------
        UILabel* labelLine = [[UILabel alloc] initWithFrame:CGRectMake(40, 40, 60, 12)];
        labelLine.text = @"Осталось:";
        labelLine.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
        labelLine.alpha = 0.5f;
        [self.mainScrollViewOrder addSubview:labelLine];

        //Оставшееся время выполнения заказа--------------------------------
        UILabel* labelTime = [[UILabel alloc] initWithFrame:CGRectMake(100, 40, 100, 12)];
        labelTime.text = parser.delivery_string;
        labelTime.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
        labelTime.alpha = 0.5f;
        [self.mainScrollViewOrder addSubview:labelTime];

        //Название метро----------------------------------------------------
        UILabel* labelMetro = [[UILabel alloc] initWithFrame:CGRectMake(40, 75, 100, 20)];
        labelMetro.text = [self metroStationNameByID:parser.metro_id];
        labelMetro.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
        [self.mainScrollViewOrder addSubview:labelMetro];

        //Цвет ветки--------------------------------------------------------
        UIView* colorLine = [[UIView alloc] initWithFrame:CGRectMake(140, 78, 14, 14)];
        colorLine.backgroundColor = [UIColor colorWithHexString:[self roundMetroColor:parser.metro_line_id]];
        colorLine.layer.borderColor = [UIColor blackColor].CGColor;
        colorLine.layer.borderWidth = 1.5f;
        colorLine.layer.cornerRadius = 7;
        [self.mainScrollViewOrder addSubview:colorLine];

        //Улица заказщика---------------------------------------------------
        UILabel* labelStreetСustomer = [[UILabel alloc] initWithFrame:CGRectMake(40, 110, 240, 40)];
        labelStreetСustomer.text = parser.address;
        labelStreetСustomer.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
        labelStreetСustomer.numberOfLines = 0;
        labelStreetСustomer.lineBreakMode = NSLineBreakByWordWrapping;
        [self.mainScrollViewOrder addSubview:labelStreetСustomer];

        //Квартира, подъезд, домофон----------------------------------------
        UILabel* labelApartmentAndIntercom = [[UILabel alloc] initWithFrame:CGRectMake(40, 140, 250, 20)];
        if([parser.getting_type integerValue] !=2 && [parser.getting_type integerValue] !=1){
            NSString* resultAdress = [NSString stringWithFormat:@"кв. %@, подъезд %@, домофон %@", parser.flat, parser.porch, parser.intercom];
            labelApartmentAndIntercom.text = resultAdress;
            labelApartmentAndIntercom.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
            labelApartmentAndIntercom.alpha = 0.5f;
            [self.mainScrollViewOrder addSubview:labelApartmentAndIntercom];
        }
        

        //Имя заказщика---------------------------------------------------
        UILabel* labelNameСustomer = [[UILabel alloc] initWithFrame:CGRectMake(40, 165, 200, 20)];
        labelNameСustomer.text = parser.customer_name;
        labelNameСustomer.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
        [self.mainScrollViewOrder addSubview:labelNameСustomer];

        //Комментарии заказчика-------------------------------------------
        HeightForText* heightForText = [HeightForText new];
        
        self.textFieldCommentsHeight = [heightForText getHeightForText:parser.comment textWith:self.view.frame.size.width withFont:[UIFont systemFontOfSize:14.f]];
        
        UILabel* LabelFieldComments = [[UILabel alloc] initWithFrame:CGRectMake(35, 183, 250, self.textFieldCommentsHeight)];
        LabelFieldComments.text = parser.comment;
        LabelFieldComments.numberOfLines = 0;
        LabelFieldComments.lineBreakMode = NSLineBreakByWordWrapping;
        LabelFieldComments.font = [UIFont fontWithName:@"HelveticaNeue-Italic" size:12];
        LabelFieldComments.backgroundColor = [UIColor clearColor];
        [self.mainScrollViewOrder addSubview:LabelFieldComments];

        //Заголовок списка товаров----------------------------------------
        
        

        
        //Требование для забора
        if([self.getting_type integerValue] == 1){
            
            
            
            UILabel* labelHeaderDemand = [[UILabel alloc] initWithFrame:CGRectMake(100, 190 + self.textFieldCommentsHeight, 160, 20)];
            labelHeaderDemand.text = @"Требования";
            labelHeaderDemand.textColor = [UIColor colorWithHexString:@"175e07"];
            labelHeaderDemand.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
            [self.mainScrollViewOrder addSubview:labelHeaderDemand];
            
            UILabel* labelOrderNum = [[UILabel alloc] initWithFrame:CGRectMake(40, 240 + self.textFieldCommentsHeight, 160, 20)];
            labelOrderNum.text = @"Заказ:";
            labelOrderNum.font = [UIFont fontWithName:@"HelveticaNeue-Italic" size:12];
            [self.mainScrollViewOrder addSubview:labelOrderNum];
            
            //Номер заказа
            UILabel* labelOrderAPINum = [[UILabel alloc] initWithFrame:CGRectMake(120, 240 + self.textFieldCommentsHeight, 160, 20)];
            labelOrderAPINum.text = [NSString stringWithFormat:@"№ %@",parser.supplier_getting_id];
            labelOrderAPINum.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
            
            [self.mainScrollViewOrder addSubview:labelOrderAPINum];
            
            //
            
            
            UILabel* labelPayment= [[UILabel alloc] initWithFrame:CGRectMake(40, 260 + self.textFieldCommentsHeight, 160, 20)];
            labelPayment.text = @"Оплата:";
            labelPayment.font = [UIFont fontWithName:@"HelveticaNeue-Italic" size:12];
            [self.mainScrollViewOrder addSubview:labelPayment];
            
            //Оплата заказа
            UILabel* labelOrderAPIPayment = [[UILabel alloc] initWithFrame:CGRectMake(120, 260 + self.textFieldCommentsHeight, 160, 20)];

            if([parser.getting_payment_type integerValue] == 1){
                labelOrderAPIPayment.text = @"Оплачено";

            }else{
                labelOrderAPIPayment.text = [NSString stringWithFormat:@"%@ руб.",parser.getting_payment];

            }
            
            labelOrderAPIPayment.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
            
            [self.mainScrollViewOrder addSubview:labelOrderAPIPayment];
            
            //
            
            UILabel* labelLetter= [[UILabel alloc] initWithFrame:CGRectMake(40, 280 + self.textFieldCommentsHeight, 160, 20)];
            labelLetter.text = @"Доверенность:";
            labelLetter.font = [UIFont fontWithName:@"HelveticaNeue-Italic" size:12];
            [self.mainScrollViewOrder addSubview:labelLetter];

            //Доверенность
            UILabel* labelOrderAPILetter = [[UILabel alloc] initWithFrame:CGRectMake(140, 280 + self.textFieldCommentsHeight, 160, 20)];
            
            if([parser.letter integerValue] == 0){
                labelOrderAPILetter.text = @"Нет";
                
            }else if([parser.letter integerValue] == 1 || [parser.letter integerValue] == 2){
                labelOrderAPILetter.text = @"Да";
                
            }else{
              labelOrderAPILetter.text = @"Ошибка в базе";
            }
            
            labelOrderAPILetter.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
            
            [self.mainScrollViewOrder addSubview:labelOrderAPILetter];
            
            //
            
            self.textFieldCommentsHeight +=150;
            
            
        }
        
        UILabel* labelHeaderItems = [[UILabel alloc] initWithFrame:CGRectMake(125, 190 + self.textFieldCommentsHeight, 70, 20)];
        labelHeaderItems.text = @"Товары";
        labelHeaderItems.textColor = [UIColor colorWithHexString:@"175e07"];
        labelHeaderItems.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
        [self.mainScrollViewOrder addSubview:labelHeaderItems];
        //
        //Список товаров---------------------------------------------------

        for (int i = 0; i < self.parseItems.count; i++) {
            NSDictionary* dict = [self.parseItems objectAtIndex:i];
            
            //Высота нашего лейбла
            self.labelNameItemsHeight = [heightForText getHeightForText:[dict objectForKey:@"name"] textWith:self.view.frame.size.width withFont:[UIFont systemFontOfSize:18.2f]];
            UILabel* labelNameItems;
            if([self.getting_type integerValue] == 0){
            labelNameItems = [[UILabel alloc] initWithFrame:
            CGRectMake(15, 210 + self.textFieldCommentsHeight + self.labelNameItemsHeight * i , 160, self.labelNameItemsHeight)];
            }else if([self.getting_type integerValue] == 2 || [self.getting_type integerValue] == 1){
                labelNameItems = [[UILabel alloc] initWithFrame:
                                  CGRectMake(50, 210 + self.textFieldCommentsHeight + self.labelNameItemsHeight * i , 160, self.labelNameItemsHeight)];
                UILabel * labelOrderId = [[UILabel alloc] initWithFrame:  CGRectMake(15, 210 + self.textFieldCommentsHeight + self.labelNameItemsHeight * i , 40, self.labelNameItemsHeight)];
                labelOrderId.numberOfLines = 0;
                labelOrderId.lineBreakMode = NSLineBreakByWordWrapping;
                labelOrderId.text = [dict objectForKey:@"order_id"];
                labelOrderId.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
                [self.mainScrollViewOrder addSubview:labelOrderId];
            }
            
            labelNameItems.numberOfLines = 0;
            labelNameItems.lineBreakMode = NSLineBreakByWordWrapping;
            labelNameItems.text = [dict objectForKey:@"name"];
            labelNameItems.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
            [self.mainScrollViewOrder addSubview:labelNameItems];

            UILabel* labelNumberItems = [[UILabel alloc] initWithFrame:
            CGRectMake(200, 210 + self.textFieldCommentsHeight + self.labelNameItemsHeight * i, 150, self.labelNameItemsHeight)];
            NSString* resultCount = [NSString stringWithFormat:@"%@ шт.", [dict objectForKey:@"count"]];
            labelNumberItems.text = resultCount;
            labelNumberItems.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
            [self.mainScrollViewOrder addSubview:labelNumberItems];

            UILabel* labelCostItems = [[UILabel alloc] initWithFrame:
            CGRectMake(240, 210 + self.textFieldCommentsHeight + self.labelNameItemsHeight * i, 150, self.labelNameItemsHeight)];
            NSString* resultPrice = [NSString stringWithFormat:@"%@ руб.", [dict objectForKey:@"price"]];
            labelCostItems.text = resultPrice;
            labelCostItems.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
            [self.mainScrollViewOrder addSubview:labelCostItems];
        }
        
        //Высота всех товаров--------------------------------------------------------------------
        self.heightAllItems = 210 + self.textFieldCommentsHeight + self.labelNameItemsHeight * self.parseItems.count;
        
        //Параметры mainScrollViewOrder----------------------------------------------------------
        NSInteger number = 200 + self.heightAllItems;
        self.mainScrollViewOrder.contentSize = CGSizeMake(320, number);

        
        

        //Не изменяемый label Товаров на сумму---------------------------------
        UILabel* labelItensCostNotActive = [[UILabel alloc] initWithFrame:CGRectMake(80, 40 + self.heightAllItems, 150, 15)];
        labelItensCostNotActive.text = @"Товаров на сумму:";
        labelItensCostNotActive.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
        labelItensCostNotActive.textAlignment = NSTextAlignmentRight;
        labelItensCostNotActive.alpha = 0.5f;
        [self.mainScrollViewOrder addSubview:labelItensCostNotActive];

        //Изменяемый label Товаров на сумму---------------------------------
        UILabel* labelItensCost = [[UILabel alloc] initWithFrame:CGRectMake(240, 40 + self.heightAllItems, 60, 15)];
        labelItensCost.text = parser.order_summ;
        labelItensCost.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
        [self.mainScrollViewOrder addSubview:labelItensCost];

        //Скидка не изменяемый-----------------------------------------------
        UILabel* labelDiscountNotActive = [[UILabel alloc] initWithFrame:CGRectMake(80, 60 + self.heightAllItems, 150, 15)];
        labelDiscountNotActive.text = @"Скидка:";
        labelDiscountNotActive.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
        labelDiscountNotActive.textAlignment = NSTextAlignmentRight;
        labelDiscountNotActive.alpha = 0.5f;
        [self.mainScrollViewOrder addSubview:labelDiscountNotActive];

        //Скидка изменяемый--------------------------------------------------
        UILabel* labelDiscount = [[UILabel alloc] initWithFrame:CGRectMake(240, 60 + self.heightAllItems, 60, 15)];
        labelDiscount.text = parser.discount;
        labelDiscount.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
        [self.mainScrollViewOrder addSubview:labelDiscount];

        //Доставка не изменяемый---------------------------------------------
        UILabel* labelDeliveryNotActive = [[UILabel alloc] initWithFrame:CGRectMake(80, 80 + self.heightAllItems, 150, 15)];
        labelDeliveryNotActive.text = @"Доставка:";
        labelDeliveryNotActive.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
        labelDeliveryNotActive.textAlignment = NSTextAlignmentRight;
        labelDeliveryNotActive.alpha = 0.5f;
        [self.mainScrollViewOrder addSubview:labelDeliveryNotActive];

        //Доставка изменяемый--------------------------------------------------
        UILabel* labelDelivery = [[UILabel alloc] initWithFrame:CGRectMake(240, 80 + self.heightAllItems, 60, 15)];
        labelDelivery.text = parser.shipping;
        labelDelivery.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
        [self.mainScrollViewOrder addSubview:labelDelivery];

        //Итого не изменяемый--------------------------------------------------
        UILabel* labelInTotalNotActive = [[UILabel alloc] initWithFrame:CGRectMake(80, 100 + self.heightAllItems, 150, 20)];
        labelInTotalNotActive.text = @"Итого:";
        labelInTotalNotActive.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
        labelInTotalNotActive.textAlignment = NSTextAlignmentRight;
        labelInTotalNotActive.textColor = [UIColor colorWithHexString:@"980ea1"];
        [self.mainScrollViewOrder addSubview:labelInTotalNotActive];

        //Итого изменяемый-----------------------------------------------------
        UILabel* labelInTotal = [[UILabel alloc] initWithFrame:CGRectMake(240, 100 + self.heightAllItems, 80, 20)];
        labelInTotal.text = parser.amount;
        labelInTotal.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
        labelInTotal.textColor = [UIColor colorWithHexString:@"980ea1"];
        [self.mainScrollViewOrder addSubview:labelInTotal];

        //Создание кнопки присвоить--------------------------------------------
        self.buttonAssigned = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.buttonAssigned setTitle:@"Присвоить" forState:UIControlStateNormal];
        self.buttonAssigned.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
        self.buttonAssigned.frame = CGRectMake(105, 150 + self.heightAllItems, 110, 30);
        self.buttonAssigned.backgroundColor = [UIColor colorWithHexString:@"f0db0c"];
        self.buttonAssigned.layer.borderColor = [UIColor darkGrayColor].CGColor;
        self.buttonAssigned.layer.borderWidth = 1.f;
        self.buttonAssigned.layer.cornerRadius = 9.f;
        [self.mainScrollViewOrder addSubview:self.buttonAssigned];
        [self.buttonAssigned addTarget:self action:@selector(tapButtonAssigned) forControlEvents:UIControlEventTouchDown];
        [self.buttonAssigned addTarget:self action:@selector(actionButtonAssigned) forControlEvents:UIControlEventTouchUpInside];

        //Создание кнопки на карте---------------------------------------------
        self.buttonOnMap = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.buttonOnMap setTitle:@"На карте" forState:UIControlStateNormal];
        self.buttonOnMap.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
        self.buttonOnMap.frame = CGRectMake(210, 70, 80, 30);
        self.buttonOnMap.backgroundColor = [UIColor colorWithHexString:@"0fae19"];
        self.buttonOnMap.layer.borderColor = [UIColor darkGrayColor].CGColor;
        self.buttonOnMap.layer.borderWidth = 1.f;
        self.buttonOnMap.layer.cornerRadius = 9.f;
        [self.mainScrollViewOrder addSubview:self.buttonOnMap];
        [self.buttonOnMap addTarget:self action:@selector(tapButtonOnMap) forControlEvents:UIControlEventTouchDown];
        [self.buttonOnMap addTarget:self action:@selector(actionButtonOnMap) forControlEvents:UIControlEventTouchUpInside];

        //Изображение времени---------------------------------------------------
        NSString* imageTimeName = @"timeImage.png";
        UIImage* imageTime = [UIImage imageNamed:imageTimeName];
        UIImageView* imageViewTime = [[UIImageView alloc] initWithFrame:CGRectMake(10, 25, 20, 20)];
        imageViewTime.image = imageTime;
        imageViewTime.alpha = 0.7f;
        [self.mainScrollViewOrder addSubview:imageViewTime];

        //Изображение местоположения---------------------------------------------
        NSString* imageLocationName = @"locationImage.png";
        UIImage* imageLocation = [UIImage imageNamed:imageLocationName];
        UIImageView* imageViewLocation = [[UIImageView alloc] initWithFrame:CGRectMake(10, 75, 20, 20)];
        imageViewLocation.image = imageLocation;
        imageViewLocation.alpha = 0.7f;
        [self.mainScrollViewOrder addSubview:imageViewLocation];

        //Изображение дома-------------------------------------------------------
        NSString* imageHomeName = @"homeImage.png";
        UIImage* imageHome = [UIImage imageNamed:imageHomeName];
        UIImageView* imageViewHome = [[UIImageView alloc] initWithFrame:CGRectMake(10, 120, 20, 20)];
        imageViewHome.image = imageHome;
        imageViewHome.alpha = 0.7f;
        [self.mainScrollViewOrder addSubview:imageViewHome];

        //Изображение покупателя--------------------------------------------------
        NSString* imageCustomerName = @"customerImage.png";
        UIImage* imageCustomer = [UIImage imageNamed:imageCustomerName];
        UIImageView* imageViewCustomer = [[UIImageView alloc] initWithFrame:CGRectMake(10, 170, 20, 20)];
        imageViewCustomer.image = imageCustomer;
        imageViewCustomer.alpha = 0.7f;
        [self.mainScrollViewOrder addSubview:imageViewCustomer];

        //Параметры кнопки buttonBackDetailScoreboardOrderView-----------------------------------
        self.buttonBackDetailScoreboardOrderView.backgroundColor = [UIColor clearColor];
        [self.buttonBackDetailScoreboardOrderView addTarget:self
                                                     action:@selector(actionButtonBackDetailScoreboardOrderView)
                                           forControlEvents:UIControlEventTouchUpInside];

        //Параметры кнопки buttonSettingDetailOrderView------------------------------------------
        self.buttonSettingDetailOrderView.backgroundColor = [UIColor clearColor];
        [self.buttonSettingDetailOrderView addTarget:self
                                              action:@selector(actionButtonSettingDetailOrderView)
                                    forControlEvents:UIControlEventTouchUpInside];

    }];
    
}

//Тащим заказы с сервера
- (void)getApiOrder:(void (^)(void))block
{
    //Передаваемые параметры

    NSDictionary* params = [[NSDictionary alloc] initWithObjectsAndKeys:
                                                     self.orderID, @"id",
                                                     self.getting_type, @"getting_type",
                                                 nil];

    APIClass* api = [APIClass new]; //создаем API
    [api getDataFromServerWithParams:params
                              method:@"action=load_order"
                     complitionBlock:^(id response) {

                         ParserResponseOrder* parsingResponce = [[ParserResponseOrder alloc] init];
//                         NSLog(@"%@",response);
                         self.arrayResponse = [parsingResponce parsing:response];

                         block();
                     }];
}

//Тащим заказы с сервера
- (void)postApiOrder
{
    NSString * status;
    if([self.getting_type integerValue] == 0){
        status = [NSString stringWithFormat:@"%i",60];
    }else if ([self.getting_type integerValue] == 2) {
        status = [NSString stringWithFormat:@"%i",130];
    }
    //Передаваемые параметры
    NSMutableArray* arrayCourier = [[SingleTone sharedManager] parsingArray];
    ParserCourier* parse = [arrayCourier objectAtIndex:0];

    NSDictionary* params = [[NSDictionary alloc] initWithObjectsAndKeys:
                                                     parse.courierId, @"courier_id",
                                                 self.orderID, @"order_id",
                                                status,@"status",
                                                 nil];

    APIPostClass* api = [APIPostClass new]; //создаем API
    [api postDataToServerWithParams:params
                             method:@"action=take_order"
                    complitionBlock:^(id response) {
                        NSDictionary* dict = (NSDictionary*)response;
                        if ([[dict objectForKey:@"error"] integerValue] == 0) {
                            MyOrdersView* myOrderView = [self.storyboard instantiateViewControllerWithIdentifier:@"scoreboardMyOrders"];
                            [self.navigationController pushViewController:myOrderView animated:YES];
                        }
                        else {
                            [self showAlertViewWithMessage:@"Ошибка присвоения заказа, обратитесь к оператору"];
                        }
                    }];
}

//Цвет ветки метро-------------------------------------------------
- (NSString*)roundMetroColor:(NSString*)lineID
{
    NSString* stationColor;
    switch ([lineID integerValue]) {
    case 1:
        stationColor = @"ff0000";
        break;
    case 2:
        stationColor = @"007d35";
        break;
    case 3:
        stationColor = @"00278d";
        break;
    case 4:
        stationColor = @"008ec2";
        break;
    case 5:
        stationColor = @"643500";
        break;
    case 6:
        stationColor = @"ff9a00";
        break;
    case 7:
        stationColor = @"cb0181";
        break;
    case 8:
        stationColor = @"ffda00";
        break;
    case 9:
        stationColor = @"9f9f9f";
        break;
    case 10:
        stationColor = @"8fd600";
        break;
    case 11:
        stationColor = @"007f9a";
        break;
    case 12:
        stationColor = @"76daea";
        break;

    default:
        break;
    }

    return stationColor;
}

//Имя станции метро--------------------------------------
- (NSString*)metroStationNameByID:(NSString*)stationID
{
    NSString* stationName;

    switch ([stationID integerValue]) {
    case 1:
        stationName = @"Авиамоторная";
        break;
    case 2:
        stationName = @"Автозаводская";
        break;
    case 3:
        stationName = @"Академическая";
        break;
    case 4:
        stationName = @"Александровский Сад";
        break;
    case 5:
        stationName = @"Алексеевская";
        break;
    case 6:
        stationName = @"Алтуфьево";
        break;
    case 7:
        stationName = @"Аннино";
        break;
    case 8:
        stationName = @"Арбатская (ар.)";
        break;
    case 9:
        stationName = @"Арбатская (фил.)";
        break;
    case 10:
        stationName = @"Аэропорт";
        break;
    case 11:
        stationName = @"Бабушкинская";
        break;
    case 12:
        stationName = @"Багратионовская";
        break;
    case 13:
        stationName = @"Баррикадная";
        break;
    case 14:
        stationName = @"Бауманская";
        break;
    case 15:
        stationName = @"Беговая";
        break;
    case 16:
        stationName = @"Белорусская";
        break;
    case 17:
        stationName = @"Беляево";
        break;
    case 18:
        stationName = @"Бибирево";
        break;
    case 19:
        stationName = @"Библиотека имени Ленина";
        break;
    case 21:
        stationName = @"Боровицкая";
        break;
    case 22:
        stationName = @"Ботанический Сад";
        break;
    case 23:
        stationName = @"Братиславская";
        break;
    case 24:
        stationName = @"Бульвар Дмитрия Донского";
        break;
    case 25:
        stationName = @"Бунинская аллея";
        break;
    case 26:
        stationName = @"Варшавская";
        break;
    case 27:
        stationName = @"ВДНХ";
        break;
    case 28:
        stationName = @"Владыкино";
        break;
    case 29:
        stationName = @"Водный Стадион";
        break;
    case 30:
        stationName = @"Войковская";
        break;
    case 31:
        stationName = @"Волгоградский Проспект";
        break;
    case 32:
        stationName = @"Волжская";
        break;
    case 33:
        stationName = @"Волоколамская (стр.)";
        break;
    case 34:
        stationName = @"Воробьевы горы";
        break;
    case 35:
        stationName = @"Выхино";
        break;
    case 36:
        stationName = @"Горчакова ул.";
        break;
    case 38:
        stationName = @"Динамо";
        break;
    case 39:
        stationName = @"Дмитровская";
        break;
    case 40:
        stationName = @"Добрынинская";
        break;
    case 41:
        stationName = @"Домодедовская";
        break;
    case 42:
        stationName = @"Дубровка";
        break;
    case 43:
        stationName = @"Измайловская";
        break;
    case 44:
        stationName = @"Калужская";
        break;
    case 45:
        stationName = @"Кантемировская";
        break;
    case 46:
        stationName = @"Каховская";
        break;
    case 47:
        stationName = @"Каширская";
        break;
    case 48:
        stationName = @"Киевская";
        break;
    case 49:
        stationName = @"Китай-Город";
        break;
    case 50:
        stationName = @"Кожуховская";
        break;
    case 51:
        stationName = @"Коломенская";
        break;
    case 52:
        stationName = @"Комсомольская";
        break;
    case 53:
        stationName = @"Коньково";
        break;
    case 54:
        stationName = @"Красногвардейская";
        break;
    case 55:
        stationName = @"Краснопресненская";
        break;
    case 56:
        stationName = @"Красносельская";
        break;
    case 57:
        stationName = @"Красные Ворота";
        break;
    case 58:
        stationName = @"Крестьянская застава";
        break;
    case 59:
        stationName = @"Кропоткинская";
        break;
    case 60:
        stationName = @"Крылатское";
        break;
    case 61:
        stationName = @"Кузнецкий Мост";
        break;
    case 62:
        stationName = @"Кузьминки";
        break;
    case 63:
        stationName = @"Кунцевская";
        break;
    case 64:
        stationName = @"Курская";
        break;
    case 65:
        stationName = @"Кутузовская";
        break;
    case 66:
        stationName = @"Ленинский Проспект";
        break;
    case 67:
        stationName = @"Лубянка";
        break;
    case 68:
        stationName = @"Люблино";
        break;
    case 69:
        stationName = @"Марксистская";
        break;
    case 70:
        stationName = @"Марьино";
        break;
    case 71:
        stationName = @"Маяковская";
        break;
    case 72:
        stationName = @"Медведково";
        break;
    case 73:
        stationName = @"Международная";
        break;
    case 74:
        stationName = @"Менделеевская";
        break;
    case 75:
        stationName = @"Митино (стр.)";
        break;
    case 76:
        stationName = @"Молодежная";
        break;
    case 77:
        stationName = @"Нагатинская";
        break;
    case 78:
        stationName = @"Нагорная";
        break;
    case 79:
        stationName = @"Нахимовский Проспект";
        break;
    case 80:
        stationName = @"Новогиреево";
        break;
    case 81:
        stationName = @"Новокузнецкая";
        break;
    case 82:
        stationName = @"Новослободская";
        break;
    case 83:
        stationName = @"Новые Черёмушки";
        break;
    case 84:
        stationName = @"Октябрьская";
        break;
    case 85:
        stationName = @"Октябрьское Поле";
        break;
    case 86:
        stationName = @"Орехово";
        break;
    case 87:
        stationName = @"Отрадное";
        break;
    case 88:
        stationName = @"Охотный Ряд";
        break;
    case 89:
        stationName = @"Павелецкая";
        break;
    case 90:
        stationName = @"Парк Культуры";
        break;
    case 91:
        stationName = @"Парк Победы";
        break;
    case 92:
        stationName = @"Партизанская";
        break;
    case 93:
        stationName = @"Первомайская";
        break;
    case 94:
        stationName = @"Перово";
        break;
    case 95:
        stationName = @"Петровско-Разумовская";
        break;
    case 96:
        stationName = @"Печатники";
        break;
    case 97:
        stationName = @"Пионерская";
        break;
    case 98:
        stationName = @"Планерная";
        break;
    case 99:
        stationName = @"Площадь Ильича";
        break;
    case 100:
        stationName = @"Площадь Революции";
        break;
    case 101:
        stationName = @"Полежаевская";
        break;
    case 102:
        stationName = @"Полянка";
        break;
    case 103:
        stationName = @"Пражская";
        break;
    case 104:
        stationName = @"Преображенская Площадь";
        break;
    case 105:
        stationName = @"Пролетарская";
        break;
    case 106:
        stationName = @"Проспект Вернадского";
        break;
    case 107:
        stationName = @"Проспект Мира";
        break;
    case 108:
        stationName = @"Профсоюзная";
        break;
    case 109:
        stationName = @"Пушкинская";
        break;
    case 110:
        stationName = @"Речной Вокзал";
        break;
    case 111:
        stationName = @"Рижская";
        break;
    case 112:
        stationName = @"Римская";
        break;
    case 113:
        stationName = @"Рязанский Проспект";
        break;
    case 114:
        stationName = @"Савеловская";
        break;
    case 115:
        stationName = @"Свиблово";
        break;
    case 116:
        stationName = @"Севастопольская";
        break;
    case 117:
        stationName = @"Семеновская";
        break;
    case 118:
        stationName = @"Серпуховская";
        break;
    case 119:
        stationName = @"Скобелевская";
        break;
    case 120:
        stationName = @"Смоленская (ар.)";
        break;
    case 121:
        stationName = @"Смоленская (фил.)";
        break;
    case 122:
        stationName = @"Сокол";
        break;
    case 123:
        stationName = @"Сокольники";
        break;
    case 124:
        stationName = @"Спортивная";
        break;
    case 125:
        stationName = @"Старокачаловская";
        break;
    case 126:
        stationName = @"Строгино (стр.)";
        break;
    case 127:
        stationName = @"Студенческая";
        break;
    case 128:
        stationName = @"Сухаревская";
        break;
    case 129:
        stationName = @"Сходненская";
        break;
    case 130:
        stationName = @"Таганская";
        break;
    case 131:
        stationName = @"Тверская";
        break;
    case 132:
        stationName = @"Театральная";
        break;
    case 133:
        stationName = @"Текстильщики";
        break;
    case 134:
        stationName = @"Теплый Стан";
        break;
    case 135:
        stationName = @"Тимирязевская";
        break;
    case 136:
        stationName = @"Третьяковская";
        break;
    case 137:
        stationName = @"Тульская";
        break;
    case 138:
        stationName = @"Тургеневская";
        break;
    case 139:
        stationName = @"Тушинская";
        break;
    case 140:
        stationName = @"Улица 1905 года";
        break;
    case 141:
        stationName = @"Улица Академика Янгеля";
        break;
    case 142:
        stationName = @"Улица Подбельского";
        break;
    case 143:
        stationName = @"Университет";
        break;
    case 144:
        stationName = @"Ушакова Адмирала";
        break;
    case 145:
        stationName = @"Филевский Парк";
        break;
    case 146:
        stationName = @"Фили";
        break;
    case 147:
        stationName = @"Фрунзенская";
        break;
    case 148:
        stationName = @"Царицыно";
        break;
    case 149:
        stationName = @"Цветной Бульвар";
        break;
    case 150:
        stationName = @"Черкизовская";
        break;
    case 151:
        stationName = @"Чертановская";
        break;
    case 152:
        stationName = @"Чеховская";
        break;
    case 153:
        stationName = @"Чистые Пруды";
        break;
    case 154:
        stationName = @"Чкаловская";
        break;
    case 155:
        stationName = @"Шаболовская";
        break;
    case 156:
        stationName = @"Шоссе Энтузиастов";
        break;
    case 157:
        stationName = @"Щелковская";
        break;
    case 158:
        stationName = @"Щукинская";
        break;
    case 159:
        stationName = @"Электрозаводская";
        break;
    case 160:
        stationName = @"Юго-Западная";
        break;
    case 161:
        stationName = @"Южная";
        break;
    case 162:
        stationName = @"Ясенево";
        break;
    case 225:
        stationName = @"Трубная";
        break;
    case 226:
        stationName = @"Ховрино";
        break;
    case 227:
        stationName = @"Беломорская ";
        break;
    case 228:
        stationName = @"Алма-Атинская";
        break;
    case 229:
        stationName = @"Славянский бульвар";
        break;
    case 230:
        stationName = @"Мякинино";
        break;
    case 231:
        stationName = @"Пятницкое шоссе";
        break;
    case 232:
        stationName = @"Выставочная";
        break;
    case 233:
        stationName = @"Новоясеневская ";
        break;
    case 234:
        stationName = @"Лермонтовский проспект";
        break;
    case 235:
        stationName = @"Жулебино ";
        break;
    case 236:
        stationName = @"Новокосино";
        break;
    case 237:
        stationName = @"Марьина роща";
        break;
    case 238:
        stationName = @"Достоевская";
        break;
    case 239:
        stationName = @"Сретенский бульвар";
        break;
    case 240:
        stationName = @"Борисово";
        break;
    case 241:
        stationName = @"Шипиловская";
        break;
    case 242:
        stationName = @"Зябликово";
        break;
    default:
        NSLog(@"");
        break;
    }

    return stationName;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

//Действие кнопки buttonSettingDetailOrderView-----------------------------------------------
- (void)actionButtonSettingDetailOrderView
{
    SettingsView* detail = [self.storyboard instantiateViewControllerWithIdentifier:@"settingsView"];
    [self.navigationController pushViewController:detail animated:YES];
}

//Действие кнопки buttonBackDetailScoreboardOrderView----------------------------------------
- (void)actionButtonBackDetailScoreboardOrderView
{
    [self.navigationController popViewControllerAnimated:YES];
}

//Тач по кнопке buttonAssigned---------------------------------------------------------------
- (void)tapButtonAssigned
{
    [Animation move_Label_Text_View_Right:self.buttonAssigned Points:0.f alpha:0.5];
}

//Действие по кнопке buttonAssigned-----------------------------------------------------------
- (void)actionButtonAssigned
{

    SCLAlertView* alertView = [[SCLAlertView alloc] init];

    //Using Selector
    [alertView addButton:@"Подтвердить" target:self selector:@selector(alertButtonYes)];
    [alertView addButton:@"Отмена" target:self selector:@selector(alertButtonNo)];

    [alertView showNotice:self title:@"Внимание!!" subTitle:@"Вы уверенны что вы хотите взять этот заказ?" closeButtonTitle:nil duration:0.0f];

    [Animation move_Label_Text_View_Right:self.buttonAssigned Points:0.f alpha:1.f];
}

//Подтвержение заказа---------------------------------------------------------------------------
- (void)alertButtonYes
{
    [self postApiOrder];
}
//Отмена заказа---------------------------------------------------------------------------------
- (void)alertButtonNo
{
    [self.navigationController popViewControllerAnimated:YES];
}

//Тач по кнопке buttonOnMap---------------------------------------------------------------
- (void)tapButtonOnMap
{
    [Animation move_Label_Text_View_Right:self.buttonOnMap Points:0.f alpha:0.5];
}

//Действие по кнопке buttonOnMap-----------------------------------------------------------
- (void)actionButtonOnMap
{
    [Animation move_Label_Text_View_Right:self.buttonOnMap Points:0.f alpha:1.f];
    MapViewOrder* detail = [self.storyboard instantiateViewControllerWithIdentifier:@"MapOrder"];
    detail.parseItems = self.arrayResponse;
    detail.orderID = self.orderID;
    detail.getting_type = self.getting_type;
    
    [self.navigationController pushViewController:detail animated:YES];
}

//Создание AlertView---------------------------------------------------------

- (void)showAlertViewWithMessage:(NSString*)message
{
    SCLAlertView* alert = [[SCLAlertView alloc] init];

    [alert showNotice:self title:@"Внимание!!!" subTitle:message closeButtonTitle:@"Ок" duration:0.f];
}

@end
