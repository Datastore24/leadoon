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

@interface DetailsScoreboardOrderView ()

@property (strong, nonatomic) UIButton * buttonAssigned;
@property (strong, nonatomic) UIButton * buttonOnMap;

@property (weak, nonatomic) IBOutlet UIView* topBarDetailScoreboardOrderView; //Терхний бар DetailScoreboardOrderView
@property (weak, nonatomic) IBOutlet UIButton* buttonBackDetailScoreboardOrderView; //Кнопка возврата
@property (weak, nonatomic) IBOutlet UILabel* labelTopBarView; //Текст заголовка
@property (weak, nonatomic) IBOutlet UIScrollView* mainScrollViewOrder; //основной scrollView
@property (weak, nonatomic) IBOutlet UIButton *buttonSettingDetailOrderView; //Кнопка настроек



@property (assign, nonatomic) CGFloat heightAllItems; //Высота всех товаров
@property (strong, nonatomic) NSArray* testArrayName; //Тестовый массив списка товаров
@property (strong, nonatomic) NSArray* testArrayNumber; //Тестовый массив колличестви товаров
@property (strong, nonatomic) NSArray* testArrayCost; //Тестовый массив списка стоимости товаров

@end

@implementation DetailsScoreboardOrderView

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.testArrayName = [NSArray arrayWithObjects:@"Мышь оптическая USB", @"Коврик с подогревом", @"Тестовое оборудование", @"Мышь оптическая USB", @"Коврик с подогревом", @"Тестовое оборудование", @"Мышь оптическая USB", @"Коврик с подогревом", @"Тестовое оборудование", @"Мышь оптическая USB", @"Коврик с подогревом", @"Тестовое оборудование", nil];
    self.testArrayNumber = [NSArray arrayWithObjects:@"1 шт", @"2 шт", @"3 шт", @"1 шт", @"2 шт", @"3 шт", @"1 шт", @"2 шт", @"3 шт", @"1 шт", @"2 шт", @"3 шт", nil];
    self.testArrayCost = [NSArray arrayWithObjects:@"650 руб", @"400 руб", @"500 руб", @"650 руб", @"400 руб", @"500 руб", @"650 руб", @"400 руб", @"500 руб", @"650 руб", @"400 руб", @"500 руб", nil];

    //Число для передачи высоты scrollView---------------------------------------------------
    NSInteger integer = self.testArrayName.count - 1;

    //Высота всех товаров--------------------------------------------------------------------
    self.heightAllItems = 300 + 20 * integer;

    //Параметры основного view---------------------------------------------------------------
    self.view.backgroundColor = [UIColor whiteColor];

    //Параметра верхнего Бара DetailScoreboardOrderView--------------------------------------
    self.topBarDetailScoreboardOrderView.backgroundColor = [UIColor whiteColor];
    self.topBarDetailScoreboardOrderView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.topBarDetailScoreboardOrderView.layer.borderWidth = 1.f;

    //Параметры mainScrollViewOrder----------------------------------------------------------
    NSInteger number = 200 + self.heightAllItems;
    self.mainScrollViewOrder.contentSize = CGSizeMake(320, number);
    self.mainScrollViewOrder.backgroundColor = [UIColor groupTableViewBackgroundColor];
//    self.mainScrollViewOrder.bounces = NO; //Отключения оттягивани

#pragma marc - constructorScrollView

    //Формирование заказа----------------------------------------------
    UILabel* labelWithFormation = [[UILabel alloc] initWithFrame:CGRectMake(210, 10, 120, 12)];
    labelWithFormation.text = @"Формируется...";
    labelWithFormation.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
    labelWithFormation.textColor = [UIColor colorWithHexString:@"2c6530"];
    [self.mainScrollViewOrder addSubview:labelWithFormation];

    //Дней осталось---------------------------------------------------
    UILabel* labelDays = [[UILabel alloc] initWithFrame:CGRectMake(40, 20, 78, 13)];
    labelDays.text = @"Завтра";
    labelDays.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
    labelDays.textColor = [UIColor blackColor];
    [self.mainScrollViewOrder addSubview:labelDays];

    //Временной интервал-----------------------------------------------
    UILabel* labelTimeInterval = [[UILabel alloc] initWithFrame:CGRectMake(85, 20, 100, 12)];
    labelTimeInterval.text = @"17:00 - 19:00";
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
    labelTime.text = @"34 чю 23 мин.";
    labelTime.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
    labelTime.alpha = 0.5f;
    [self.mainScrollViewOrder addSubview:labelTime];

    //Название метро----------------------------------------------------
    UILabel* labelMetro = [[UILabel alloc] initWithFrame:CGRectMake(40, 75, 100, 20)];
    labelMetro.text = @"Таганская";
    labelMetro.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
    [self.mainScrollViewOrder addSubview:labelMetro];

    //Цвет ветки--------------------------------------------------------
    UIView* colorLine = [[UIView alloc] initWithFrame:CGRectMake(115, 78, 14, 14)];
    colorLine.backgroundColor = [UIColor colorWithHexString:@"980ea1"];
    colorLine.layer.borderColor = [UIColor blackColor].CGColor;
    colorLine.layer.borderWidth = 1.5f;
    colorLine.layer.cornerRadius = 7;
    [self.mainScrollViewOrder addSubview:colorLine];

    //Улица заказщика---------------------------------------------------
    UILabel* labelStreetСustomer = [[UILabel alloc] initWithFrame:CGRectMake(40, 110, 200, 20)];
    labelStreetСustomer.text = @"г. Химки, ул. Попова 19";
    labelStreetСustomer.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
    [self.mainScrollViewOrder addSubview:labelStreetСustomer];

    //Квартира, подъезд, домовон----------------------------------------
    UILabel* labelApartmentAndIntercom = [[UILabel alloc] initWithFrame:CGRectMake(40, 130, 250, 20)];
    labelApartmentAndIntercom.text = @"кв. 36, подъезд 2, домофон 28K49039";
    labelApartmentAndIntercom.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
    labelApartmentAndIntercom.alpha = 0.5f;
    [self.mainScrollViewOrder addSubview:labelApartmentAndIntercom];

    //Имя заказщика---------------------------------------------------
    UILabel* labelNameСustomer = [[UILabel alloc] initWithFrame:CGRectMake(40, 165, 200, 20)];
    labelNameСustomer.text = @"Константин Воронцов";
    labelNameСustomer.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
    [self.mainScrollViewOrder addSubview:labelNameСustomer];

    //Комментарии заказчика-------------------------------------------
    UITextView* textFieldComments = [[UITextView alloc] initWithFrame:CGRectMake(35, 183, 180, 90)];
    textFieldComments.text = @"Прошу курьеру позвонить за час так как меня может не быть на месте.....";
    textFieldComments.editable = NO;
    textFieldComments.scrollEnabled = NO;
    textFieldComments.font = [UIFont fontWithName:@"HelveticaNeue-Italic" size:12];
    textFieldComments.backgroundColor = [UIColor clearColor];
    [self.mainScrollViewOrder addSubview:textFieldComments];

    //Заголовок списка товаров----------------------------------------
    UILabel* labelHeaderItems = [[UILabel alloc] initWithFrame:CGRectMake(125, 250, 70, 20)];
    labelHeaderItems.text = @"Товары";
    labelHeaderItems.textColor = [UIColor colorWithHexString:@"175e07"];
    labelHeaderItems.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    [self.mainScrollViewOrder addSubview:labelHeaderItems];

    //Список товаров---------------------------------------------------
    for (int i = 0; i < self.testArrayName.count; i++) {

        UILabel* labelNameItems = [[UILabel alloc] initWithFrame:CGRectMake(15, 300 + 20 * i, 150, 15)];
        labelNameItems.text = [self.testArrayName objectAtIndex:i];
        labelNameItems.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
        [self.mainScrollViewOrder addSubview:labelNameItems];

        UILabel* labelNumberItems = [[UILabel alloc] initWithFrame:CGRectMake(200, 300 + 20 * i, 150, 15)];
        labelNumberItems.text = [self.testArrayNumber objectAtIndex:i];
        labelNumberItems.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
        [self.mainScrollViewOrder addSubview:labelNumberItems];

        UILabel* labelCostItems = [[UILabel alloc] initWithFrame:CGRectMake(240, 300 + 20 * i, 150, 15)];
        labelCostItems.text = [self.testArrayCost objectAtIndex:i];
        labelCostItems.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
        [self.mainScrollViewOrder addSubview:labelCostItems];
    }

    //Не изменяемый label Товаров на сумму---------------------------------
    UILabel* labelItensCostNotActive = [[UILabel alloc] initWithFrame:CGRectMake(80, 40 + self.heightAllItems, 150, 15)];
    labelItensCostNotActive.text = @"Товаров на сумму:";
    labelItensCostNotActive.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
    labelItensCostNotActive.textAlignment = UITextAlignmentRight;
    labelItensCostNotActive.alpha = 0.5f;
    [self.mainScrollViewOrder addSubview:labelItensCostNotActive];

    //Изменяемый label Товаров на сумму---------------------------------
    UILabel* labelItensCost = [[UILabel alloc] initWithFrame:CGRectMake(240, 40 + self.heightAllItems, 60, 15)];
    labelItensCost.text = @"1050";
    labelItensCost.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
    [self.mainScrollViewOrder addSubview:labelItensCost];

    //Скидка не изменяемый-----------------------------------------------
    UILabel* labelDiscountNotActive = [[UILabel alloc] initWithFrame:CGRectMake(80, 60 + self.heightAllItems, 150, 15)];
    labelDiscountNotActive.text = @"Скидка:";
    labelDiscountNotActive.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
    labelDiscountNotActive.textAlignment = UITextAlignmentRight;
    labelDiscountNotActive.alpha = 0.5f;
    [self.mainScrollViewOrder addSubview:labelDiscountNotActive];

    //Скидка изменяемый--------------------------------------------------
    UILabel* labelDiscount = [[UILabel alloc] initWithFrame:CGRectMake(240, 60 + self.heightAllItems, 60, 15)];
    labelDiscount.text = @"100";
    labelDiscount.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
    [self.mainScrollViewOrder addSubview:labelDiscount];

    //Доставка не изменяемый---------------------------------------------
    UILabel* labelDeliveryNotActive = [[UILabel alloc] initWithFrame:CGRectMake(80, 80 + self.heightAllItems, 150, 15)];
    labelDeliveryNotActive.text = @"Доставка:";
    labelDeliveryNotActive.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
    labelDeliveryNotActive.textAlignment = UITextAlignmentRight;
    labelDeliveryNotActive.alpha = 0.5f;
    [self.mainScrollViewOrder addSubview:labelDeliveryNotActive];

    //Доставка изменяемый--------------------------------------------------
    UILabel* labelDelivery = [[UILabel alloc] initWithFrame:CGRectMake(240, 80 + self.heightAllItems, 60, 15)];
    labelDelivery.text = @"250";
    labelDelivery.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
    [self.mainScrollViewOrder addSubview:labelDelivery];

    //Итого не изменяемый--------------------------------------------------
    UILabel* labelInTotalNotActive = [[UILabel alloc] initWithFrame:CGRectMake(80, 100 + self.heightAllItems, 150, 20)];
    labelInTotalNotActive.text = @"Итого:";
    labelInTotalNotActive.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    labelInTotalNotActive.textAlignment = UITextAlignmentRight;
    labelInTotalNotActive.textColor = [UIColor colorWithHexString:@"980ea1"];
    [self.mainScrollViewOrder addSubview:labelInTotalNotActive];

    //Итого изменяемый-----------------------------------------------------
    UILabel* labelInTotal = [[UILabel alloc] initWithFrame:CGRectMake(240, 100 + self.heightAllItems, 80, 20)];
    labelInTotal.text = @"1200";
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

//Действие кнопки buttonSettingDetailOrderView-----------------------------------------------
-(void)actionButtonSettingDetailOrderView
{
    SettingsView * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"settingsView"];
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
    [Animation move_Label_Text_View_Right:self.buttonAssigned Points:0.f alpha:1.f];
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
    MapViewOrder * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"MapOrder"];
    [self.navigationController pushViewController:detail animated:YES];
}



@end
