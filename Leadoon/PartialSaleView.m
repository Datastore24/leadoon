//
//  PartialSaleView.m
//  Leadoon
//
//  Created by Viktor on 06.11.15.
//  Copyright © 2015 Viktor. All rights reserved.
//

#import "PartialSaleView.h"
#import "SettingsView.h"
#import "UIColor+HexColor.h"
#import "ParserOrder.h"
#import "HeightForText.h"

@interface PartialSaleView () <UIPickerViewDataSource, UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIView* topBarPartialSaleView; //Верхний бар
@property (weak, nonatomic) IBOutlet UIButton* buttonBackPartialSaleView; //Кнопка назад
@property (weak, nonatomic) IBOutlet UIButton* buttonSettingsPartialSaleView; //Копка настроек
@property (weak, nonatomic) IBOutlet UIScrollView* scrollViewPartialSaleView; //Основной скрол вью
@property (assign, nonatomic) CGFloat labelNameItemsHeight; //ВЫсота наименования товара
@property (strong, nonatomic) NSArray* items; //Список товаров
@property (strong, nonatomic) NSMutableArray* mArrayPickerNumber; //Список элементов пикера колличества
@property (assign, nonatomic) CGFloat heightAllItems; //Высота всех товаров

@end

@implementation PartialSaleView

- (void)viewDidLoad

{
    [super viewDidLoad];

    self.mArrayPickerNumber = [NSMutableArray new];

    ParserOrder* parser = [self.parseItems objectAtIndex:0];
    self.items = parser.items;

    self.scrollViewPartialSaleView.backgroundColor = [UIColor groupTableViewBackgroundColor];

    //Параметра верхнего Бара topBarPartialSaleView--------------------------------------
    self.topBarPartialSaleView.backgroundColor = [UIColor whiteColor];
    self.topBarPartialSaleView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.topBarPartialSaleView.layer.borderWidth = 1.f;

    //Параметры buttonSettingsPartialSaleView----------------------------------
    self.buttonSettingsPartialSaleView.backgroundColor = [UIColor clearColor];
    [self.buttonSettingsPartialSaleView addTarget:self
                                           action:@selector(actionButtonSettingsScoreboardOrdersView)

                                 forControlEvents:UIControlEventTouchUpInside];

    //Параметры buttonBackPartialSaleView---------------------------------------
    self.buttonBackPartialSaleView.backgroundColor = [UIColor clearColor];
    [self.buttonBackPartialSaleView addTarget:self
                                       action:@selector(actionButtonBackScoreboardOrdersView)

                             forControlEvents:UIControlEventTouchUpInside];

    //Заголовок Товары----------------------------------------------------------
    UILabel* labelGoods = [[UILabel alloc] initWithFrame:CGRectMake(130, 70, 70, 20)];
    labelGoods.text = @"Товары";
    labelGoods.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    labelGoods.textAlignment = NSTextAlignmentCenter;
    labelGoods.textColor = [UIColor colorWithHexString:@"0c8927"];
    [self.scrollViewPartialSaleView addSubview:labelGoods];

    HeightForText* heightForText = [HeightForText new];

    for (int i = 0; i < self.items.count; i++) {
        NSDictionary* dict = [self.items objectAtIndex:i];
        //Высота нашего лейбла
        self.labelNameItemsHeight = [heightForText getHeightForText:[dict objectForKey:@"name"] textWith:self.view.frame.size.width withFont:[UIFont systemFontOfSize:14]];

        UILabel* labelNameItems;
        labelNameItems = [[UILabel alloc] initWithFrame:
                                              CGRectMake(30, 130 + 60 * i, 200, self.labelNameItemsHeight + 15)];
        labelNameItems.numberOfLines = 0;
        labelNameItems.lineBreakMode = NSLineBreakByWordWrapping;
        labelNameItems.text = [dict objectForKey:@"name"];
        labelNameItems.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
        [self.scrollViewPartialSaleView addSubview:labelNameItems];

        UILabel* labelOrderId = [[UILabel alloc] initWithFrame:CGRectMake(10, 132.5 + 60 * i, 40, self.labelNameItemsHeight + 10)];
        labelOrderId.numberOfLines = 0;
        labelOrderId.lineBreakMode = NSLineBreakByWordWrapping;
        labelOrderId.text = [dict objectForKey:@"order_id"];
        labelOrderId.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
        [self.scrollViewPartialSaleView addSubview:labelOrderId];

        
        
        UIPickerView* pickerViewNumber = [[UIPickerView alloc] initWithFrame:CGRectMake(230, 122.5 + 60 * i, 30, 50)];
        pickerViewNumber.dataSource = self;
        pickerViewNumber.delegate = self;
        pickerViewNumber.tag = i + 1;
        for (int j = 0; j < 100; j++) {
            NSString* string = [[NSNumber numberWithInt:j] stringValue];
            [self.mArrayPickerNumber addObject:string];
        }

        [self.scrollViewPartialSaleView addSubview:pickerViewNumber];
        
        NSInteger intCount = [[dict objectForKey:@"count"]integerValue];
        [pickerViewNumber selectRow:intCount inComponent:0 animated:YES];

        UILabel* labelPrice = [[UILabel alloc] initWithFrame:CGRectMake(270, 125 + 60 * i, 80, 40)];
        labelPrice.text = [dict objectForKey:@"price"];
        labelPrice.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
        [self.scrollViewPartialSaleView addSubview:labelPrice];
    }

    //Высота всех товаров--------------------------------------------------------------------
    self.heightAllItems = 130 + 60 * self.items.count;
    //Высота ScrollView----------------------------------------------------------------------
    self.scrollViewPartialSaleView.contentSize = CGSizeMake(320, self.heightAllItems + 300);

    //Label товаров на сумму-----------------------------------------------------------------
    UILabel* labelWorthOfGoods = [[UILabel alloc] initWithFrame:CGRectMake(25, self.heightAllItems + 50, 120, 15)];
    labelWorthOfGoods.text = @"Товаров на сумму :";
    labelWorthOfGoods.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
    labelWorthOfGoods.alpha = 0.5f;
    [self.scrollViewPartialSaleView addSubview:labelWorthOfGoods];

    NSString * sumString = parser.order_summ;
    NSString* string = [NSString stringWithFormat:@"%@ руб.", sumString];

    //Label товаров на сумму цена-----------------------------------------------------------
    UILabel* labelWorthOfGoodsCount = [[UILabel alloc] initWithFrame:CGRectMake(150, self.heightAllItems + 50, 100, 15)];
    labelWorthOfGoodsCount.text = string;
    labelWorthOfGoodsCount.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    labelWorthOfGoodsCount.textColor = [UIColor colorWithHexString:@"b838a0"];
    [self.scrollViewPartialSaleView addSubview:labelWorthOfGoodsCount];

    //Скидка не изменяемый-----------------------------------------------
    UILabel* labelDiscountNotActive = [[UILabel alloc] initWithFrame:CGRectMake(60, 100 + self.heightAllItems, 70, 15)];
    labelDiscountNotActive.text = @"Скидка:";
    labelDiscountNotActive.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
    labelDiscountNotActive.textAlignment = NSTextAlignmentRight;
    labelDiscountNotActive.alpha = 0.5f;
    [self.scrollViewPartialSaleView addSubview:labelDiscountNotActive];
    
    //Скидка изменяемый-----------------------------------------------
    UILabel* labelDiscount = [[UILabel alloc] initWithFrame:CGRectMake(130, 100 + self.heightAllItems, 70, 15)];
    labelDiscount.text = parser.discount;
    labelDiscount.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    labelDiscount.textAlignment = NSTextAlignmentRight;
    [self.scrollViewPartialSaleView addSubview:labelDiscount];

    //Доставка не изменяемый---------------------------------------------
    UILabel* labelDeliveryNotActive = [[UILabel alloc] initWithFrame:CGRectMake(60, 122.5 + self.heightAllItems, 70, 15)];
    labelDeliveryNotActive.text = @"Доставка:";
    labelDeliveryNotActive.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
    labelDeliveryNotActive.textAlignment = NSTextAlignmentRight;
    labelDeliveryNotActive.alpha = 0.5f;
    [self.scrollViewPartialSaleView addSubview:labelDeliveryNotActive];
    
    //Доставка изменяемый-----------------------------------------------
    UILabel* labelDelivery = [[UILabel alloc] initWithFrame:CGRectMake(130, 122.5 + self.heightAllItems, 70, 15)];
    labelDelivery.text = parser.shipping;
    labelDelivery.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    labelDelivery.textAlignment = NSTextAlignmentRight;
    [self.scrollViewPartialSaleView addSubview:labelDelivery];
    
    //Итого не изменяемый--------------------------------------------------
    UILabel* labelInTotalNotActive = [[UILabel alloc] initWithFrame:CGRectMake(80, 180 + self.heightAllItems, 80, 20)];
    labelInTotalNotActive.text = @"Итого:";
    labelInTotalNotActive.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
    labelInTotalNotActive.textAlignment = NSTextAlignmentRight;
    [self.scrollViewPartialSaleView addSubview:labelInTotalNotActive];
    
    //Итого изменяемый-----------------------------------------------------
    UILabel* labelInTotal = [[UILabel alloc] initWithFrame:CGRectMake(170, 180 + self.heightAllItems, 80, 20)];
    labelInTotal.text = parser.amount;
    labelInTotal.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
    labelInTotal.textColor = [UIColor colorWithHexString:@"2d5348"];
    [self.scrollViewPartialSaleView addSubview:labelInTotal];
    
    
    //Кнопка расчета суммы с не полным колличеством товаров--------------------------
    UIButton *buttonUpdates = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonUpdates addTarget:self
               action:@selector(actionButtonUpdates)
     forControlEvents:UIControlEventTouchUpInside];
    buttonUpdates.backgroundColor = [UIColor colorWithHexString:@"608dbd"];
    buttonUpdates.layer.borderColor = [UIColor blackColor].CGColor;
    buttonUpdates.layer.borderWidth = 1.5f;
    buttonUpdates.layer.cornerRadius = 10.f;
    [buttonUpdates setTitle:@"Расчиать стоимость" forState:UIControlStateNormal];
    buttonUpdates.frame = CGRectMake(60, self.heightAllItems - 10, 190.0, 30.0);
    [self.scrollViewPartialSaleView addSubview:buttonUpdates];
    
    
    //Кнопка выполнить--------------------------
    UIButton *buttonPerform = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonPerform addTarget:self
                      action:@selector(actionButtonPerform)
            forControlEvents:UIControlEventTouchUpInside];
    buttonPerform.backgroundColor = [UIColor colorWithHexString:@"077831"];
    buttonPerform.layer.borderColor = [UIColor blackColor].CGColor;
    buttonPerform.layer.borderWidth = 1.5f;
    buttonPerform.layer.cornerRadius = 7.f;
    [buttonPerform setTitle:@"Выполнить" forState:UIControlStateNormal];
    buttonPerform.frame = CGRectMake(100, 250 + self.heightAllItems, 100.0, 30.0);
    [self.scrollViewPartialSaleView addSubview:buttonPerform];

}

//Действи кнопки ButtonBackScoreboardOrdersView---------------------------------------
- (void)actionButtonBackScoreboardOrdersView
{
    [self.navigationController popViewControllerAnimated:YES];
}

//Действи кнопки ButtonSettingsScoreboardOrdersView---------------------------------------
- (void)actionButtonSettingsScoreboardOrdersView
{
    SettingsView* detail = [self.storyboard instantiateViewControllerWithIdentifier:@"settingsView"];
    [self.navigationController pushViewController:detail animated:YES];
}

- (void) actionButtonUpdates
{
    NSLog(@"Пост данных на изменение суммы доставки и скидки");
}

- (void) actionButtonPerform
{
    NSLog(@"Реализация кнопки выполнить");
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView*)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{


        UIPickerView* picerView = (UIPickerView*)pickerView;
        for (int i = 0; i < self.mArrayPickerNumber.count; i++) {
            NSDictionary* dict = [self.items objectAtIndex:i];

            if (picerView.tag == i + 1) {

                return [[dict objectForKey:@"count"] integerValue] + 1;
            }
        }
    return 0;
}

- (NSString*)pickerView:(UIPickerView*)thePickerView
            titleForRow:(NSInteger)row
           forComponent:(NSInteger)component
{


        return [self.mArrayPickerNumber objectAtIndex:row];
    }


- (UIView*)pickerView:(UIPickerView*)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView*)view
{

    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, pickerView.frame.size.width, 20)];

    label.backgroundColor = [UIColor whiteColor];
    label.textColor = [UIColor blackColor];
    label.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:12];
    label.text = [NSString stringWithFormat:@" %@", self.mArrayPickerNumber[row]];
    label.layer.borderColor = [UIColor blackColor].CGColor;
    label.layer.borderWidth = 1.5f;
    label.layer.cornerRadius = 5.f;
    return label;
}

@end
