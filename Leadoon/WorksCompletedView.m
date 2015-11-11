//
//  WorksCompletedView.m
//  Leadoon
//
//  Created by Viktor on 11.11.15.
//  Copyright © 2015 Viktor. All rights reserved.
//

#import "WorksCompletedView.h"
#import "SettingsView.h"
#import "LabelsTableViewCall.h"

#import "SingleTone.h"
#import <SVPullToRefresh/SVPullToRefresh.h>
#import "WorksCompletedViewDetail.h"

@interface WorksCompletedView () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIView* topBarWorksCompletedView; //Верхний бар
@property (weak, nonatomic) IBOutlet UIButton* buttonBackWorksCompletedView; //Кнопка назад
@property (weak, nonatomic) IBOutlet UIButton* buttonSettingWorksCompletedView; //Кнопка настроек

@property (strong, nonatomic) NSMutableArray* arrayResponce; //Массив с данными API
@property (strong, nonatomic) NSMutableArray* arrayOrders; //Массив с заказами

@property (strong, nonatomic) NSMutableArray* testArray;

@end

@implementation WorksCompletedView

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.testArray = [NSMutableArray new];

    //Основной тип
    NSArray* gettingType = [NSArray arrayWithObjects:@"0", @"1", @"2", @"0", @"2", @"1", @"0", nil];
    //Тип заказа
    NSArray* orderType = [NSArray arrayWithObjects:@"0", @"0", @"2", @"0", @"2", @"2", @"0", nil];
    //Цвет метро
    NSArray* lineMetro = [NSArray arrayWithObjects:@"5", @"7", @"2", @"3", @"8", @"5", @"3", nil];
    //Цвет метро
    NSArray* iDMetro = [NSArray arrayWithObjects:@"47", @"56", @"38", @"21", @"11", @"7", @"3", nil];
    //Дата выполнения заказа
    NSArray* arrayData = [NSArray arrayWithObjects:@"01.02.2015", @"12.08.2015", @"23.11.2015", @"04.03.2015",
                                  @"02.03.2015", @"27.03.2015", @"16.01.2015", nil];
    //Вес
    NSArray* arrayWeight = [NSArray arrayWithObjects:@"3-5 кг", @"2 заказа", @"9-10 кг", @"1-2 кг",
                                    @"5 заказов", @"3-4 кг", @"8 заказао", nil];
    //Сумма
    NSArray* arraySum = [NSArray arrayWithObjects:@"3500 руб", @"2800 руб", @"1500 руб", @"2450 руб",
                                 @"1870 руб", @"1350 руб", @"2570 руб", nil];
    //Заработок
    NSArray* earningsArray = [NSArray arrayWithObjects:@"250 руб", @"250 руб", @"250 руб", @"300 руб",
                                      @"250 руб", @"300 руб", @"250 руб", nil];
    for (int i = 0; i < iDMetro.count; i++) {
        NSDictionary* dict = [NSDictionary dictionaryWithObjectsAndKeys:[gettingType objectAtIndex:i], @"gettingType",
                                           [orderType objectAtIndex:i], @"orderType",
                                           [lineMetro objectAtIndex:i], @"lineMetro",
                                           [iDMetro objectAtIndex:i], @"iDMetro",
                                           [arrayData objectAtIndex:i], @"arrayData",
                                           [arrayWeight objectAtIndex:i], @"arrayWeight",
                                           [arraySum objectAtIndex:i], @"arraySum",
                                           [earningsArray objectAtIndex:i], @"earningsArray",
                                           nil];
        [self.testArray addObject:dict];
    }
    //Параметры основного view------------------------------------------------------
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];

    //Параметры topBarScoreboardsView-----------------------------------------------
    self.topBarWorksCompletedView.backgroundColor = [UIColor whiteColor];
    self.topBarWorksCompletedView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.topBarWorksCompletedView.layer.borderWidth = 1.f;

    //Параметры buttonSettingsScoreboardOrdersView----------------------------------
    self.buttonSettingWorksCompletedView.backgroundColor = [UIColor clearColor];
    [self.buttonSettingWorksCompletedView addTarget:self
                                             action:@selector(actionButtonSettingWorksCompletedView)
                                   forControlEvents:UIControlEventTouchUpInside];

    //Параметры buttonBackScoreboardOrdersView---------------------------------------
    self.buttonBackWorksCompletedView.backgroundColor = [UIColor clearColor];
    [self.buttonBackWorksCompletedView addTarget:self
                                          action:@selector(actionButtonBackWorksCompletedView)
                                forControlEvents:UIControlEventTouchUpInside];

    //Параметры таблицы--------------------------------------------------------------
    self.tableViewWorksCompletedView.backgroundColor = [UIColor clearColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

//Обновление таблицы
- (void)reloadTableViewWhenNewEvent
{

    [self.tableViewWorksCompletedView
          reloadSections:[NSIndexSet indexSetWithIndex:0]
        withRowAnimation:UITableViewRowAnimationFade];

    self.tableViewWorksCompletedView.scrollEnabled = YES;

    //    Перезагрузка таблицы с
    //    анимацией
}

//Действи кнопки ButtonSettingWorksCompletedView---------------------------------------
- (void)actionButtonSettingWorksCompletedView
{
    SettingsView* detail = [self.storyboard instantiateViewControllerWithIdentifier:@"settingsView"];
    [self.navigationController pushViewController:detail animated:YES];
}

//Действи кнопки ButtonBackWorksCompletedView------------------------------------------
- (void)actionButtonBackWorksCompletedView
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{

    return self.testArray.count;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    static NSString* identifier = @"Cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    NSDictionary* dict = [self.testArray objectAtIndex:indexPath.row];

    cell.backgroundColor = [UIColor groupTableViewBackgroundColor];

    LabelsTableViewCall* typeLabel = [[LabelsTableViewCall alloc] init];

    //Тип заявки------------------------------------------------------------------------
    if ([[dict objectForKey:@"gettingType"] integerValue] == 0) {
        [cell addSubview:[typeLabel labelTypeTableViewCell:@"Заказ"]];
    }
    else if ([[dict objectForKey:@"gettingType"] integerValue] == 1) {
        [cell addSubview:[typeLabel labelTypeTableViewCell:@"Закупка"]];
    }
    else {
        [cell addSubview:[typeLabel labelTypeTableViewCell:@"Забор"]];
    }
    //Тип заказа-------------------------------------------------------------------------
    [cell addSubview:[typeLabel imageViewTypeTableView:[dict objectForKey:@"orderType"]]];
    //Дата выполнения--------------------------------------------------------------------
    [cell addSubview:[typeLabel labelDataFinish:[dict objectForKey:@"arrayData"]]];

    //метро------------------------------------------------------------------------------
    [cell addSubview:[typeLabel roundMetroView:[dict objectForKey:@"lineMetro"]]];
    [cell addSubview:[typeLabel labelMetroStationName:[dict objectForKey:@"iDMetro"]]];

    //Отображение корзины----------------------------------------------------------------
    [cell addSubview:[typeLabel imageViewBasketTableView]];
    [cell addSubview:[typeLabel weightAndNumberOfOrders:[dict objectForKey:@"arrayWeight"]]];

    //Получение или оплата денег----------------------------------------------------------
    if ([[dict objectForKey:@"gettingType"] integerValue] == 0) {
        [cell addSubview:[typeLabel labelPaymentType:@"Принято :"]];
    }
    else {
        [cell addSubview:[typeLabel labelPaymentType:@"Оплаченно :"]];
    }

    //Сумма--------------------------------------------------------------------------------
    if ([[dict objectForKey:@"gettingType"] integerValue] == 2) {
        
        [cell addSubview:[typeLabel labelSum:@"0"]];
    }
    else {
        [cell addSubview:[typeLabel labelSum:[dict objectForKey:@"arraySum"]]];
    }

    //Заработок----------------------------------------------------------------------------
    [cell addSubview:[typeLabel labelEarnings]];

    //Заработок сумма----------------------------------------------------------------------
    [cell addSubview:[typeLabel labelEarningsSum:[dict objectForKey:@"earningsArray"]]];

    return cell;
}

#pragma mark - UITableViewDelegate
//Анимация нажатия ячейки--------------------------------------------------------------
- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    WorksCompletedViewDetail * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"worksCompletedViewDetail"];
    [self.navigationController pushViewController:detail animated:YES];

}

@end
