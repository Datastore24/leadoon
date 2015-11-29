//
//  FinanceView.m
//  Leadoon
//
//  Created by Viktor on 22.11.15.
//  Copyright © 2015 Viktor. All rights reserved.
//

#import "FinanceView.h"
#import "SettingsView.h"
#import "HeightForText.h"
#import "UIColor+HexColor.h"
#import "AdditionalExpenses.h"
#import "HistoryOfTheMovement.h"

@interface FinanceView ()
@property (weak, nonatomic) IBOutlet UIView *topBarFinanceView; //Топ бар
@property (weak, nonatomic) IBOutlet UILabel *labelTopBarFinanceView; //Заголовок
@property (weak, nonatomic) IBOutlet UIButton *buttonBackFinanceView; //Кнопка назад
@property (weak, nonatomic) IBOutlet UIButton *buttonSettingFinanceView; //Кнопка настроек
@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewFinanceView; //Основной скрол view

@property (assign, nonatomic) CGFloat labelNameItemsHeight; //ВЫсота наименования товара
@property (assign, nonatomic) CGFloat heightAllItems; //Высота всех товаров

@end

@implementation FinanceView

#pragma mark - Options

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.scrollViewFinanceView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    //Параметры основного view------------------------------------------------------
    self.view.backgroundColor = [UIColor whiteColor];
    
    //Параметра верхнего Бара DetailScoreboardOrderView-----------------------------
    self.topBarFinanceView.backgroundColor = [UIColor whiteColor];
    self.topBarFinanceView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.topBarFinanceView.layer.borderWidth = 1.f;
    
    //Параметры buttonBackMapViewOrder----------------------------------------------
    self.buttonBackFinanceView.backgroundColor = [UIColor clearColor];
    [self.buttonBackFinanceView addTarget:self action:@selector(actionButtonBackFinanceView) forControlEvents:UIControlEventTouchUpInside];
    
    //Параметры нкопки buttonSettingMapViewOrder------------------------------------
    self.buttonSettingFinanceView.backgroundColor = [UIColor clearColor];
    [self.buttonSettingFinanceView addTarget:self
                                               action:@selector(actionButtonSettingFinanceView)
                                     forControlEvents:UIControlEventTouchUpInside];
    
    //Заголовок---
    self.labelTopBarFinanceView.text = @"Финансы";
    
    //Заголовок - Текущий баланс----------------------------------------------------
    UILabel* labelCurrentBalance = [[UILabel alloc] initWithFrame:CGRectMake(90, 15, 240, 40)];
    labelCurrentBalance.text = @"Текущий баланс";
    labelCurrentBalance.font = [UIFont fontWithName:@"HelveticaNeue" size:18];
    [self.scrollViewFinanceView addSubview:labelCurrentBalance];
    
    //К сдаче не изменяеммый---------------------------------------------------------
    UILabel* labelLetting = [[UILabel alloc] initWithFrame:CGRectMake(110, 60, 60, 40)];
    labelLetting.text = @"К сдаче: ";
    labelLetting.font = [UIFont fontWithName:@"HelveticaNeue" size:13];
    [self.scrollViewFinanceView addSubview:labelLetting];
    
    //К сдаче изменяеммый---------------------------------------------------------
    UILabel* labelLettingAction = [[UILabel alloc] initWithFrame:CGRectMake(170, 60, 240, 40)];
    labelLettingAction.text = @"17800";
    labelLettingAction.font = [UIFont fontWithName:@"HelveticaNeue" size:13];
    [self.scrollViewFinanceView addSubview:labelLettingAction];
    
    //Зароботок не изменяеммый----------------------------------------------------
    UILabel* labelEarnMoney = [[UILabel alloc] initWithFrame:CGRectMake(92, 85, 80, 40)];
    labelEarnMoney.text = @"Зароботок: ";
    labelEarnMoney.font = [UIFont fontWithName:@"HelveticaNeue" size:13];
    [self.scrollViewFinanceView addSubview:labelEarnMoney];
    
    //Зароботок изменяеммый----------------------------------------------------
    UILabel* labelEarnMoneyAction = [[UILabel alloc] initWithFrame:CGRectMake(170, 85, 80, 40)];
    labelEarnMoneyAction.text = @"1950";
    labelEarnMoneyAction.font = [UIFont fontWithName:@"HelveticaNeue" size:13];
    [self.scrollViewFinanceView addSubview:labelEarnMoneyAction];
    
    //Штрафные не изменяеммый----------------------------------------------------
    UILabel* labelPenalty = [[UILabel alloc] initWithFrame:CGRectMake(90, 110, 80, 40)];
    labelPenalty.text = @"Штрафные: ";
    labelPenalty.font = [UIFont fontWithName:@"HelveticaNeue" size:13];
    [self.scrollViewFinanceView addSubview:labelPenalty];
    
    //Штрафные изменяеммый----------------------------------------------------
    UILabel* labelPenaltyAction = [[UILabel alloc] initWithFrame:CGRectMake(170, 110, 80, 40)];
    labelPenaltyAction.text = @"220";
    labelPenaltyAction.font = [UIFont fontWithName:@"HelveticaNeue" size:13];
    [self.scrollViewFinanceView addSubview:labelPenaltyAction];
    
    //Итого к сдаче не изменяеммый----------------------------------------------------
    UILabel* labelOutcome = [[UILabel alloc] initWithFrame:CGRectMake(66, 155, 100, 40)];
    labelOutcome.text = @"Итого к сдаче: ";
    labelOutcome.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];
    [self.scrollViewFinanceView addSubview:labelOutcome];
    
    //Итого к сдаче изменяеммый----------------------------------------------------
    UILabel* labelOutcomeAction = [[UILabel alloc] initWithFrame:CGRectMake(170, 155, 100, 40)];
    labelOutcomeAction.text = @"15780";
    labelOutcomeAction.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];
    [self.scrollViewFinanceView addSubview:labelOutcomeAction];
    
    //Товары на руках----------------------------------------------------
    UILabel* labelOnHands = [[UILabel alloc] initWithFrame:CGRectMake(80, 220, 180, 40)];
    labelOnHands.text = @"Товары на руках";
    labelOnHands.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    [self.scrollViewFinanceView addSubview:labelOnHands];
    
    
    
    
    //Ширина текста наименования товара---------------------------------------------
    HeightForText* heightForText = [HeightForText new];
    
    //Список товаров---------------------------------------------------
    
    for (int i = 0; i < 2; i++) {
        
        //Высота нашего лейбла
        self.labelNameItemsHeight = [heightForText getHeightForText:@"Самый важный товар, для очень важных людей" textWith:self.view.frame.size.width withFont:[UIFont systemFontOfSize:14]];
        UILabel* labelNameItems;
        
        labelNameItems = [[UILabel alloc] initWithFrame:
                          CGRectMake(40, 250 + 10 + 60 * i , 160, self.labelNameItemsHeight + 10)];
        UILabel * labelOrderId = [[UILabel alloc] initWithFrame:  CGRectMake(10, 250  + 10 + 60 * i , 40, self.labelNameItemsHeight + 10)];
        labelOrderId.numberOfLines = 0;
        labelOrderId.lineBreakMode = NSLineBreakByWordWrapping;
        labelOrderId.text = @"65";
        labelOrderId.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
        [self.scrollViewFinanceView addSubview:labelOrderId];
        
        
        labelNameItems.numberOfLines = 0;
        labelNameItems.lineBreakMode = NSLineBreakByWordWrapping;
        labelNameItems.text = @"Самый важный товар, для очень важных людей";
        labelNameItems.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
        
        [self.scrollViewFinanceView addSubview:labelNameItems];
        
        
        UILabel* labelNumberItems = [[UILabel alloc] initWithFrame:
                                     CGRectMake(200, 250  + 10 + 60 * i, 150, self.labelNameItemsHeight + 10 )];
        NSString* resultCount = [NSString stringWithFormat:@"%@ шт.", @"5"];
        labelNumberItems.text = resultCount;
        labelNumberItems.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
        [self.scrollViewFinanceView addSubview:labelNumberItems];
        
        UILabel* labelCostItems = [[UILabel alloc] initWithFrame:
                                   CGRectMake(240, 250 + 10  + 60 * i, 150, self.labelNameItemsHeight + 10)];
        NSString* resultPrice = [NSString stringWithFormat:@"%@ руб.", @"350"];
        labelCostItems.text = resultPrice;
        labelCostItems.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
        [self.scrollViewFinanceView addSubview:labelCostItems];
    }
    
    //Высота всех товаров--------------------------------------------------------------------
    self.heightAllItems = 250 + 60 * 2;
    
    //Параметры mainScrollViewOrder----------------------------------------------------------
    NSInteger number = 200 + self.heightAllItems;
    self.scrollViewFinanceView.contentSize = CGSizeMake(320, number);
    
    //Создание кнопки История движения--------------------------------------------
    UIButton * buttonAssigned = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonAssigned setTitle:@"История движения" forState:UIControlStateNormal];
    buttonAssigned.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    buttonAssigned.frame = CGRectMake(70, 60 + self.heightAllItems, 180, 30);
    buttonAssigned.backgroundColor = [UIColor colorWithHexString:@"046323"];
    buttonAssigned.layer.borderColor = [UIColor darkGrayColor].CGColor;
    buttonAssigned.layer.borderWidth = 1.f;
    buttonAssigned.layer.cornerRadius = 9.f;
    [buttonAssigned addTarget:self action:@selector(actionButtonAssigned)
                         forControlEvents:UIControlEventTouchUpInside];
    [self.scrollViewFinanceView addSubview: buttonAssigned];
    
    //Создание кнопки История движения--------------------------------------------
    UIButton * buttonExprenses = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonExprenses setTitle:@"Доп расходы" forState:UIControlStateNormal];
    buttonExprenses.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    buttonExprenses.frame = CGRectMake(70, 20 + self.heightAllItems, 180, 30);
    buttonExprenses.backgroundColor = [UIColor colorWithHexString:@"e41937"];
    buttonExprenses.layer.borderColor = [UIColor darkGrayColor].CGColor;
    buttonExprenses.layer.borderWidth = 1.f;
    buttonExprenses.layer.cornerRadius = 9.f;
    [buttonExprenses addTarget:self action:@selector(actionButtonExprenses)
             forControlEvents:UIControlEventTouchUpInside];
    [self.scrollViewFinanceView addSubview: buttonExprenses];
    

}

#pragma mark - Buttons

//Параметры кнопки ButtonBackFinanceView---------------------------------------------
- (void)actionButtonBackFinanceView
{
    [self.navigationController popViewControllerAnimated:YES];
}

//Параметры кнопки ButtonSettingFinanceView------------------------------------------
- (void)actionButtonSettingFinanceView
{
    SettingsView * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"settingsView"];
    [self.navigationController pushViewController:detail animated:YES];
}

//Параметры кнопки ButtonExprenses---------------------------------------------------
- (void)actionButtonExprenses
{
    AdditionalExpenses * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"additionalExpenses"];
    [self.navigationController pushViewController:detail animated:YES];
}

//Параметры кнопки ButtonAssigned----------------------------------------------------
- (void)actionButtonAssigned
{
    HistoryOfTheMovement * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"historyOfTheMovement"];
    [self.navigationController pushViewController:detail animated:YES];
}

@end
