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

#import "ParserCourier.h"
#import "APIClass.h"
#import "ParserResponseOrders.h"
#import "ParserOrders.h"

@interface WorksCompletedView () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIView* topBarWorksCompletedView; //Верхний бар
@property (weak, nonatomic) IBOutlet UIButton* buttonBackWorksCompletedView; //Кнопка назад
@property (weak, nonatomic) IBOutlet UIButton* buttonSettingWorksCompletedView; //Кнопка настроек
@property (weak, nonatomic) IBOutlet UITableView *tableViewWorksCompleted;

@property (strong, nonatomic) NSMutableArray* arrayResponce; //Массив с данными API
@property (strong, nonatomic) NSMutableArray* arrayOrders; //Массив с заказами


@end

@implementation WorksCompletedView

- (void)viewDidLoad
{
    [super viewDidLoad];

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
    
    //Массив данных авторизованного пользователя
    self.arrayResponce = [[SingleTone sharedManager] parsingArray];
    self.arrayOrders = [NSMutableArray array];
    //API методы
    [self getApiOrders];
    
    [self.tableViewWorksCompleted addPullToRefreshWithActionHandler:^{
        [self.arrayOrders removeAllObjects];
        [self getApiOrders];
        [self.tableViewWorksCompleted.pullToRefreshView stopAnimating];
        
    }];
}

//Тащим заказы с сервера
-(void) getApiOrders{
    //Передаваемые параметры
    ParserCourier * parse = [self.arrayResponce objectAtIndex:0];
    NSDictionary * params = [[NSDictionary alloc] initWithObjectsAndKeys:
                             parse.service_id,@"service_id",
                             parse.courierId,@"courier_id",
                             nil];
    NSLog(@"GO");
    APIClass * api =[APIClass new]; //создаем API
    [api getDataFromServerWithParams:params method:@"action=load_my_completed_orders" complitionBlock:^(id response) {
        //        NSLog(@"%@",response);
        ParserResponseOrders * parsingResponce =[[ParserResponseOrders alloc] init];
        NSLog(@"%@",response);
        [parsingResponce parsing:response andArray:self.arrayOrders andBlock:^{
            
            [self reloadTableViewWhenNewEvent];
        }];
        
        
    }];
    
}

//Обновление таблицы
- (void)reloadTableViewWhenNewEvent {
    
    
    [self.tableViewWorksCompleted
     reloadSections:[NSIndexSet indexSetWithIndex:0]
     withRowAnimation:UITableViewRowAnimationFade];
    
    self.tableViewWorksCompleted.scrollEnabled = YES;
    
    //    Перезагрузка таблицы с
    //    анимацией
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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

    return self.arrayOrders.count;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    static NSString* identifier = @"Cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
   
    ParserOrders * parser =[self.arrayOrders objectAtIndex:indexPath.row];
    cell.backgroundColor = [UIColor groupTableViewBackgroundColor];

    LabelsTableViewCall* typeLabel = [[LabelsTableViewCall alloc] init];

    //Тип заявки------------------------------------------------------------------------
    if ([parser.getting_type integerValue] == 0) {
        [cell addSubview:[typeLabel labelTypeTableViewCell:@"Заказ"]];
    }
    else if ([parser.getting_type  integerValue] == 1) {
        [cell addSubview:[typeLabel labelTypeTableViewCell:@"Закупка"]];
    }
    else {
        [cell addSubview:[typeLabel labelTypeTableViewCell:@"Забор"]];
    }
    //Тип заказа-------------------------------------------------------------------------
    
    [cell addSubview:[typeLabel imageViewTypeTableView:parser.order_type]];
    //Дата выполнения--------------------------------------------------------------------
    //[cell addSubview:[typeLabel labelDataFinish:[dict objectForKey:@"arrayData"]]];

    //метро------------------------------------------------------------------------------
  

    [cell addSubview:[typeLabel roundMetroView: parser.metro_id]];
    [cell addSubview:[typeLabel labelMetroStationName:parser.metro_line_id]];

    //Отображение корзины----------------------------------------------------------------
    [cell addSubview:[typeLabel imageViewBasketTableView]];
    //[cell addSubview:[typeLabel weightAndNumberOfOrders:[dict objectForKey:@"arrayWeight"]]];

    //Получение или оплата денег----------------------------------------------------------
    if ([parser.getting_type integerValue] == 0) {
        [cell addSubview:[typeLabel labelPaymentType:@"Принято :"]];
    }
    else {
        [cell addSubview:[typeLabel labelPaymentType:@"Оплаченно :"]];
    }

    //Сумма--------------------------------------------------------------------------------
    if ([parser.getting_type integerValue] == 2) {
        
        [cell addSubview:[typeLabel labelSum:@"0"]];
    }
    else {
       // [cell addSubview:[typeLabel labelSum:[dict objectForKey:@"arraySum"]]];
    }

    //Заработок----------------------------------------------------------------------------
    [cell addSubview:[typeLabel labelEarnings]];

    //Заработок сумма----------------------------------------------------------------------
    //[cell addSubview:[typeLabel labelEarningsSum:[dict objectForKey:@"earningsArray"]]];

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
