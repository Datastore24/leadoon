//
//  WorksCompletedViewDetail.m
//  Leadoon
//
//  Created by Viktor on 11.11.15.
//  Copyright © 2015 Viktor. All rights reserved.
//

#import "WorksCompletedViewDetail.h"
#import "UIColor+HexColor.h"
#import "HeightForText.h"
#import "SettingsView.h"

@interface WorksCompletedViewDetail ()

@property (weak, nonatomic) IBOutlet UIView *topBarWorksCompletedViewDetail; //Верхний бар
@property (weak, nonatomic) IBOutlet UIButton *buttonBackWorksCompletedDetail; //Кнопка назад
@property (weak, nonatomic) IBOutlet UIButton *buttonSettingWorksCompletedDetail; //Кнопка настройки
@property (weak, nonatomic) IBOutlet UILabel *labelTopBarWorksCompletedDetail; //Заголовок
@property (weak, nonatomic) IBOutlet UIScrollView *mainScrolViewWorksCompletedDetail; //Основной Scroll View


@property (assign, nonatomic) CGFloat textFieldCommentsHeight; //Высота комментариев
@property (assign, nonatomic) CGFloat labelNameItemsHeight; //ВЫсота наименования товара
@property (assign, nonatomic) CGFloat heightAllItems; //Высота всех товаров

@end

@implementation WorksCompletedViewDetail

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.mainScrolViewWorksCompletedDetail.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    //Параметры основного view---------------------------------------------------------------
    self.view.backgroundColor = [UIColor whiteColor];
    
    //Параметра верхнего Бара DetailScoreboardOrderView--------------------------------------
    self.topBarWorksCompletedViewDetail.backgroundColor = [UIColor whiteColor];
    self.topBarWorksCompletedViewDetail.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.topBarWorksCompletedViewDetail.layer.borderWidth = 1.f;
    
    //Параметры buttonBackMapViewOrder----------------------------------------------
    self.buttonBackWorksCompletedDetail.backgroundColor = [UIColor clearColor];
    [self.buttonBackWorksCompletedDetail addTarget:self action:@selector(actionButtonBackWorksCompletedDetail) forControlEvents:UIControlEventTouchUpInside];
    
    //Параметры нкопки buttonSettingMapViewOrder------------------------------------
    self.buttonSettingWorksCompletedDetail.backgroundColor = [UIColor clearColor];
    [self.buttonSettingWorksCompletedDetail addTarget:self
                                          action:@selector(actionButtonSettingWorksCompletedDetail)
                                forControlEvents:UIControlEventTouchUpInside];
    
    //Заголовок---
    self.labelTopBarWorksCompletedDetail.text = @"00046";
    
    
        //Дней осталось---------------------------------------------------
        UILabel* labelDays = [[UILabel alloc] initWithFrame:CGRectMake(40, 20, 78, 13)];

        labelDays.text = @"Cегодня";

        
        labelDays.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
        labelDays.textColor = [UIColor blackColor];
        [self.mainScrolViewWorksCompletedDetail addSubview:labelDays];
        
        //Временной интервал-----------------------------------------------
        UILabel* labelTimeInterval = [[UILabel alloc] initWithFrame:CGRectMake(95, 20, 100, 12)];
    
        labelTimeInterval.text = @"2 часа";
        labelTimeInterval.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
        labelTimeInterval.textColor = [UIColor blackColor];
        [self.mainScrolViewWorksCompletedDetail addSubview:labelTimeInterval];
        
        //Осталось не изменяемый label-------------------------------------
        UILabel* labelLine = [[UILabel alloc] initWithFrame:CGRectMake(40, 40, 60, 12)];
        labelLine.text = @"Осталось:";
        labelLine.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
        labelLine.alpha = 0.5f;
        [self.mainScrolViewWorksCompletedDetail addSubview:labelLine];
        
        //Оставшееся время выполнения заказа--------------------------------
        UILabel* labelTime = [[UILabel alloc] initWithFrame:CGRectMake(100, 40, 100, 12)];
        labelTime.text = @"3 часа";
        labelTime.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
        labelTime.alpha = 0.5f;
        [self.mainScrolViewWorksCompletedDetail addSubview:labelTime];
        
        //Название метро----------------------------------------------------
        UILabel* labelMetro = [[UILabel alloc] initWithFrame:CGRectMake(40, 75, 100, 20)];
        labelMetro.text = @"Шаболовское";
        labelMetro.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
        [self.mainScrolViewWorksCompletedDetail addSubview:labelMetro];
        
        //Цвет ветки--------------------------------------------------------
        UIView* colorLine = [[UIView alloc] initWithFrame:CGRectMake(140, 78, 14, 14)];
        colorLine.backgroundColor = [UIColor colorWithHexString:@"008ec2"];
        colorLine.layer.borderColor = [UIColor blackColor].CGColor;
        colorLine.layer.borderWidth = 1.5f;
        colorLine.layer.cornerRadius = 7;
        [self.mainScrolViewWorksCompletedDetail addSubview:colorLine];
        
        //Улица заказщика---------------------------------------------------
        UILabel* labelStreetСustomer = [[UILabel alloc] initWithFrame:CGRectMake(40, 110, 240, 40)];
        labelStreetСustomer.text = @"Ул. Шакирова д. 5";
        labelStreetСustomer.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
        labelStreetСustomer.numberOfLines = 0;
        labelStreetСustomer.lineBreakMode = NSLineBreakByWordWrapping;
        [self.mainScrolViewWorksCompletedDetail addSubview:labelStreetСustomer];
        
        //Квартира, подъезд, домовон----------------------------------------
        UILabel* labelApartmentAndIntercom = [[UILabel alloc] initWithFrame:CGRectMake(40, 140, 250, 20)];
        NSString* resultAdress = [NSString stringWithFormat:@"кв. %@, подъезд %@, домофон %@", @"56", @"3", @"254"];
        labelApartmentAndIntercom.text = resultAdress;
        labelApartmentAndIntercom.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
        labelApartmentAndIntercom.alpha = 0.5f;
        [self.mainScrolViewWorksCompletedDetail addSubview:labelApartmentAndIntercom];
        
        //Имя заказщика---------------------------------------------------
        UILabel* labelNameСustomer = [[UILabel alloc] initWithFrame:CGRectMake(40, 185, 200, 20)];
        labelNameСustomer.text = @"Никифоров Александр";
        labelNameСustomer.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
        [self.mainScrolViewWorksCompletedDetail addSubview:labelNameСustomer];
        
        //Комментарии заказчика-------------------------------------------
        HeightForText* heightForText = [HeightForText new];
        
        self.textFieldCommentsHeight = [heightForText getHeightForText:@"Это мой комментарий, он не очень длинный...." textWith:self.view.frame.size.width withFont:[UIFont systemFontOfSize:14.f]];
        
        UILabel* LabelFieldComments = [[UILabel alloc] initWithFrame:CGRectMake(35, 205, 250, self.textFieldCommentsHeight)];
        LabelFieldComments.text = @"Это мой комментарий";
        LabelFieldComments.numberOfLines = 0;
        LabelFieldComments.lineBreakMode = NSLineBreakByWordWrapping;
        LabelFieldComments.font = [UIFont fontWithName:@"HelveticaNeue-Italic" size:12];
        LabelFieldComments.backgroundColor = [UIColor clearColor];
        [self.mainScrolViewWorksCompletedDetail addSubview:LabelFieldComments];
    
        //Заголовок списка товаров----------------------------------------
        UILabel* labelHeaderItems = [[UILabel alloc] initWithFrame:CGRectMake(125, 215 + self.textFieldCommentsHeight, 70, 20)];
        labelHeaderItems.text = @"Товары";
        labelHeaderItems.textColor = [UIColor colorWithHexString:@"175e07"];
        labelHeaderItems.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
        [self.mainScrolViewWorksCompletedDetail addSubview:labelHeaderItems];
        
        //Список товаров---------------------------------------------------
        
        for (int i = 0; i < 2; i++) {
            
            //Высота нашего лейбла
            self.labelNameItemsHeight = [heightForText getHeightForText:@"Самый важный товар, для очень важных людей" textWith:self.view.frame.size.width withFont:[UIFont systemFontOfSize:14]];
            UILabel* labelNameItems;

                labelNameItems = [[UILabel alloc] initWithFrame:
                                  CGRectMake(40, 230 + self.textFieldCommentsHeight + 10 + 60 * i , 160, self.labelNameItemsHeight + 10)];
                UILabel * labelOrderId = [[UILabel alloc] initWithFrame:  CGRectMake(10, 230 + self.textFieldCommentsHeight + 10 + 60 * i , 40, self.labelNameItemsHeight + 10)];
                labelOrderId.numberOfLines = 0;
                labelOrderId.lineBreakMode = NSLineBreakByWordWrapping;
                labelOrderId.text = @"65";
                labelOrderId.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
            [self.mainScrolViewWorksCompletedDetail addSubview:labelOrderId];

            
            labelNameItems.numberOfLines = 0;
            labelNameItems.lineBreakMode = NSLineBreakByWordWrapping;
            labelNameItems.text = @"Самый важный товар, для очень важных людей";
            labelNameItems.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
            
            [self.mainScrolViewWorksCompletedDetail addSubview:labelNameItems];
            
            
            UILabel* labelNumberItems = [[UILabel alloc] initWithFrame:
                                         CGRectMake(200, 230 + self.textFieldCommentsHeight + 10 + 60 * i, 150, self.labelNameItemsHeight + 10 )];
            NSString* resultCount = [NSString stringWithFormat:@"%@ шт.", @"5"];
            labelNumberItems.text = resultCount;
            labelNumberItems.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
            [self.mainScrolViewWorksCompletedDetail addSubview:labelNumberItems];
            
            UILabel* labelCostItems = [[UILabel alloc] initWithFrame:
                                       CGRectMake(240, 230 + 10 + self.textFieldCommentsHeight + 60 * i, 150, self.labelNameItemsHeight + 10)];
            NSString* resultPrice = [NSString stringWithFormat:@"%@ руб.", @"350"];
            labelCostItems.text = resultPrice;
            labelCostItems.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
            [self.mainScrolViewWorksCompletedDetail addSubview:labelCostItems];
        }
        
        //Высота всех товаров--------------------------------------------------------------------
        self.heightAllItems = 230 + self.textFieldCommentsHeight + 60 * 2;
        
        //Параметры mainScrollViewOrder----------------------------------------------------------
        NSInteger number = 250 + self.heightAllItems;
        self.mainScrolViewWorksCompletedDetail.contentSize = CGSizeMake(320, number);
        
        //Не изменяемый label Товаров на сумму---------------------------------
        UILabel* labelItensCostNotActive = [[UILabel alloc] initWithFrame:CGRectMake(80, 40 + self.heightAllItems, 150, 15)];
        labelItensCostNotActive.text = @"Товаров на сумму:";
        labelItensCostNotActive.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
        labelItensCostNotActive.textAlignment = NSTextAlignmentRight;
        labelItensCostNotActive.alpha = 0.5f;
        [self.mainScrolViewWorksCompletedDetail addSubview:labelItensCostNotActive];
        
        //Изменяемый label Товаров на сумму---------------------------------
        UILabel* labelItensCost = [[UILabel alloc] initWithFrame:CGRectMake(240, 40 + self.heightAllItems, 60, 15)];
        labelItensCost.text = @"5000";
        labelItensCost.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
        [self.mainScrolViewWorksCompletedDetail addSubview:labelItensCost];
        
        //Скидка не изменяемый-----------------------------------------------
        UILabel* labelDiscountNotActive = [[UILabel alloc] initWithFrame:CGRectMake(80, 60 + self.heightAllItems, 150, 15)];
        labelDiscountNotActive.text = @"Скидка:";
        labelDiscountNotActive.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
        labelDiscountNotActive.textAlignment = NSTextAlignmentRight;
        labelDiscountNotActive.alpha = 0.5f;
        [self.mainScrolViewWorksCompletedDetail addSubview:labelDiscountNotActive];
        
        //Скидка изменяемый--------------------------------------------------
        UILabel* labelDiscount = [[UILabel alloc] initWithFrame:CGRectMake(240, 60 + self.heightAllItems, 60, 15)];
        labelDiscount.text = @"150";
        labelDiscount.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
        [self.mainScrolViewWorksCompletedDetail addSubview:labelDiscount];
        
        //Доставка не изменяемый---------------------------------------------
        UILabel* labelDeliveryNotActive = [[UILabel alloc] initWithFrame:CGRectMake(80, 80 + self.heightAllItems, 150, 15)];
        labelDeliveryNotActive.text = @"Доставка:";
        labelDeliveryNotActive.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
        labelDeliveryNotActive.textAlignment = NSTextAlignmentRight;
        labelDeliveryNotActive.alpha = 0.5f;
        [self.mainScrolViewWorksCompletedDetail addSubview:labelDeliveryNotActive];
        
        //Доставка изменяемый--------------------------------------------------
        UILabel* labelDelivery = [[UILabel alloc] initWithFrame:CGRectMake(240, 80 + self.heightAllItems, 60, 15)];
        labelDelivery.text = @"500";
        labelDelivery.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
        [self.mainScrolViewWorksCompletedDetail addSubview:labelDelivery];
        
        //Итого не изменяемый--------------------------------------------------
        UILabel* labelInTotalNotActive = [[UILabel alloc] initWithFrame:CGRectMake(80, 100 + self.heightAllItems, 150, 20)];
        labelInTotalNotActive.text = @"Итого:";
        labelInTotalNotActive.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
        labelInTotalNotActive.textAlignment = NSTextAlignmentRight;
        labelInTotalNotActive.textColor = [UIColor colorWithHexString:@"980ea1"];
        [self.mainScrolViewWorksCompletedDetail addSubview:labelInTotalNotActive];
        
        //Итого изменяемый-----------------------------------------------------
        UILabel* labelInTotal = [[UILabel alloc] initWithFrame:CGRectMake(240, 100 + self.heightAllItems, 80, 20)];
        labelInTotal.text = @"7500";
        labelInTotal.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
        labelInTotal.textColor = [UIColor colorWithHexString:@"980ea1"];
        [self.mainScrolViewWorksCompletedDetail addSubview:labelInTotal];
        
    
        //Изображение времени---------------------------------------------------
        NSString* imageTimeName = @"timeImage.png";
        UIImage* imageTime = [UIImage imageNamed:imageTimeName];
        UIImageView* imageViewTime = [[UIImageView alloc] initWithFrame:CGRectMake(10, 25, 20, 20)];
        imageViewTime.image = imageTime;
        imageViewTime.alpha = 0.7f;
        [self.mainScrolViewWorksCompletedDetail addSubview:imageViewTime];
        
        //Изображение местоположения---------------------------------------------
        NSString* imageLocationName = @"locationImage.png";
        UIImage* imageLocation = [UIImage imageNamed:imageLocationName];
        UIImageView* imageViewLocation = [[UIImageView alloc] initWithFrame:CGRectMake(10, 75, 20, 20)];
        imageViewLocation.image = imageLocation;
        imageViewLocation.alpha = 0.7f;
        [self.mainScrolViewWorksCompletedDetail addSubview:imageViewLocation];
        
        //Изображение дома-------------------------------------------------------
        NSString* imageHomeName = @"homeImage.png";
        UIImage* imageHome = [UIImage imageNamed:imageHomeName];
        UIImageView* imageViewHome = [[UIImageView alloc] initWithFrame:CGRectMake(10, 120, 20, 20)];
        imageViewHome.image = imageHome;
        imageViewHome.alpha = 0.7f;
        [self.mainScrolViewWorksCompletedDetail addSubview:imageViewHome];
        
        //Изображение покупателя--------------------------------------------------
        NSString* imageCustomerName = @"customerImage.png";
        UIImage* imageCustomer = [UIImage imageNamed:imageCustomerName];
        UIImageView* imageViewCustomer = [[UIImageView alloc] initWithFrame:CGRectMake(10, 197, 20, 20)];
        imageViewCustomer.image = imageCustomer;
        imageViewCustomer.alpha = 0.7f;
        [self.mainScrolViewWorksCompletedDetail addSubview:imageViewCustomer];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

//Действие кнопки buttonSettingDetailOrderView-----------------------------------------------
- (void)actionButtonSettingWorksCompletedDetail
{
    SettingsView* detail = [self.storyboard instantiateViewControllerWithIdentifier:@"settingsView"];
    [self.navigationController pushViewController:detail animated:YES];
}

//Действие кнопки buttonBackDetailScoreboardOrderView----------------------------------------
- (void)actionButtonBackWorksCompletedDetail
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end

