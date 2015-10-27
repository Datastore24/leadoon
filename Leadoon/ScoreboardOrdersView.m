//
//  ScoreboardOrdersView.m
//  Leadoon
//
//  Created by Viktor on 14.10.15.
//  Copyright © 2015 Viktor. All rights reserved.
//

#import "ScoreboardOrdersView.h"
#import "Animation.h"
#import "SettingsView.h"
#import "LabelsTableViewCall.h"
#import "DetailsScoreboardOrderView.h"
#import "MainView.h"

#import "SingleTone.h"
#import <SVPullToRefresh/SVPullToRefresh.h>

#import "APIClass.h"
#import "ParserOrders.h"
#import "ParserCourier.h"
#import "ParserResponseOrders.h"
#import "ParseDate.h"
#import "MapViewScoreboardOrders.h"





@interface ScoreboardOrdersView () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *topBarScoreboardsView; //Верхний бар Табло заказов
@property (weak, nonatomic) IBOutlet UILabel *labelTopBarScoreboardOrdersView; //Главный заголовок табло заказов
@property (weak, nonatomic) IBOutlet UIButton *buttonSettingsScoreboardOrdersView; //Кнопка перехода в "Настройки"
@property (weak, nonatomic) IBOutlet UIImageView *imageViewButtonSettings; //Изображение на кнопке "Настройки"
@property (weak, nonatomic) IBOutlet UIButton *buttonBackScoreboardOrdersView; //Кнопка возврата к предыдущему view
@property (weak, nonatomic) IBOutlet UIImageView *imageViewButtonBack; //Изображение кнопки "Back"
@property (weak, nonatomic) IBOutlet UITableView *tableViewScoreboardOrders; //Таблица табла заказов
@property (weak, nonatomic) IBOutlet UIButton *buttonOnMap; //Кнопка отображения заказов на карте
@property (weak, nonatomic) IBOutlet UIButton *buttonFilterScoreboardOrders; //Фильтр заказов

@property (strong, nonatomic) NSMutableArray * arrayResponce; //Массив с данными API
@property (strong, nonatomic) NSMutableArray * arrayOrders; //Массив с заказами

@property (weak, nonatomic) IBOutlet UIView *ViewLineScoreboardOrders; //View для создании линии

@end

@implementation ScoreboardOrdersView

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    //Массив данных авторизованного пользователя
    self.arrayResponce = [[SingleTone sharedManager] parsingArray];
    self.arrayOrders = [NSMutableArray array];
    
    //Параметры основного view------------------------------------------------------
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    //Параметры topBarScoreboardsView-----------------------------------------------
    self.topBarScoreboardsView.backgroundColor = [UIColor whiteColor];
    self.topBarScoreboardsView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.topBarScoreboardsView.layer.borderWidth = 1.f;
    
    //Параметры ViewLineScoreboardOrders--------------------------------------------
    self.ViewLineScoreboardOrders.backgroundColor = [UIColor clearColor];
    self.ViewLineScoreboardOrders.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.ViewLineScoreboardOrders.layer.borderWidth = 1.f;
    
    //Параметры buttonSettingsScoreboardOrdersView----------------------------------
    self.buttonSettingsScoreboardOrdersView.backgroundColor = [UIColor clearColor];
    [self.buttonSettingsScoreboardOrdersView addTarget:self action:@selector(tapButtonSettingsScoreboardOrdersView)
                                  forControlEvents:UIControlEventTouchDown];
    [self.buttonSettingsScoreboardOrdersView addTarget:self action:@selector(actionButtonSettingsScoreboardOrdersView)
                                  forControlEvents:UIControlEventTouchUpInside];
    
    //Параметры buttonBackScoreboardOrdersView---------------------------------------
    self.buttonBackScoreboardOrdersView.backgroundColor = [UIColor clearColor];
    [self.buttonBackScoreboardOrdersView addTarget:self action:@selector(tapButtonBackScoreboardOrdersView)
                                              forControlEvents:UIControlEventTouchDown];
    [self.buttonBackScoreboardOrdersView addTarget:self action:@selector(actionButtonBackScoreboardOrdersView)
                                              forControlEvents:UIControlEventTouchUpInside];
    
    //Параметры кнопки buttonOnMap----------------------------------------------------
    self.buttonOnMap.layer.cornerRadius = 10.f;
    [self.buttonOnMap addTarget:self action:@selector(actionButtonOnMap) forControlEvents:UIControlEventTouchUpInside];
    
    //Параметры tableViewScoreboardOrders---------------------------------------------
    self.tableViewScoreboardOrders.backgroundColor = [UIColor clearColor];
    
    //API методы
    [self getApiOrders];
    
    //Обновление
    
    [self.tableViewScoreboardOrders addPullToRefreshWithActionHandler:^{

        [self.arrayOrders removeAllObjects];
        [self getApiOrders];
        [self.tableViewScoreboardOrders.pullToRefreshView stopAnimating];
        
    }];
    
    
   
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (void) actionButtonOnMap
{
    MapViewScoreboardOrders * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"mapViewScoreboardOrders"];
    detail.arrayOrders=self.arrayOrders; //Массив с данными
    [self.navigationController pushViewController:detail animated:YES];
}

#pragma mark - API

//Тащим заказы с сервера
-(void) getApiOrders{
    //Передаваемые параметры
    ParserCourier * parse = [self.arrayResponce objectAtIndex:0];
    NSDictionary * params = [[NSDictionary alloc] initWithObjectsAndKeys:
                             parse.service_id,@"service_id",
                             nil];
    
    APIClass * api =[APIClass new]; //создаем API
    [api getDataFromServerWithParams:params method:@"action=load_orders" complitionBlock:^(id response) {
        
        ParserResponseOrders * parsingResponce =[[ParserResponseOrders alloc] init];
        NSLog(@"%@",response);
        [parsingResponce parsing:response andArray:self.arrayOrders andBlock:^{
      
            
            [self reloadTableViewWhenNewEvent];
           
            
        }];
        
        
    }];
    
}

//Обновление таблицы
- (void)reloadTableViewWhenNewEvent {
    
    
    [self.tableViewScoreboardOrders
     reloadSections:[NSIndexSet indexSetWithIndex:0]
     withRowAnimation:UITableViewRowAnimationFade];
    
    self.tableViewScoreboardOrders.scrollEnabled = YES;
    
   
    //После обновления
 
    //
    //    Перезагрузка таблицы с
    //    анимацией
    
}

#pragma mark - buttonsAction

//Тап кнопки ButtonBackScoreboardOrdersView-------------------------------------------
- (void)tapButtonBackScoreboardOrdersView
{
    [Animation move_Label_Text_View_Right:self.imageViewButtonBack
                                   Points:0.f
                                    alpha:0.5f];
}

//Действи кнопки ButtonBackScoreboardOrdersView---------------------------------------
- (void) actionButtonBackScoreboardOrdersView
{
    
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
    
    [Animation move_Label_Text_View_Right:self.imageViewButtonBack
                                   Points:0.f
                                    alpha:1.f];
}

//Тап кнопки ButtonSettingsScoreboardOrdersView-------------------------------------------
- (void)tapButtonSettingsScoreboardOrdersView
{
    [Animation move_Label_Text_View_Right:self.imageViewButtonSettings
                                   Points:0.f
                                    alpha:0.5f];
}

//Действи кнопки ButtonSettingsScoreboardOrdersView---------------------------------------
- (void) actionButtonSettingsScoreboardOrdersView
{
    SettingsView * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"settingsView"];
    [self.navigationController pushViewController:detail animated:YES];
    [Animation move_Label_Text_View_Right:self.imageViewButtonSettings
                                   Points:0.f
                                    alpha:1.f];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrayOrders.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"Cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    for (UIView * view in cell.subviews) {
        
        [view removeFromSuperview];
    }
    

    if([self.arrayOrders count] > 0 && [self.arrayOrders count] > indexPath.row){
        
        
        
    
    LabelsTableViewCall * typeLabel = [[LabelsTableViewCall alloc] init];
//    NSString * string = @"Заказ";
    ParserOrders * parser =[self.arrayOrders objectAtIndex:indexPath.row];
    ParseDate * parseDate =[[ParseDate alloc] init];
    
    if([parser.getting_type integerValue] ==0 ){
        [cell addSubview:[typeLabel labelTypeTableViewCell:@"Заказ"]];
    }else if([parser.getting_type integerValue] ==1 ){
        [cell addSubview:[typeLabel labelTypeTableViewCell:@"Закупка"]];
    }else{
        [cell addSubview:[typeLabel labelTypeTableViewCell:@"Забор"]];
    }
    
    //Изменения даты
    if([parser.delivery_date isEqual:[parseDate dateFormatToDay]]){
         [cell addSubview:[typeLabel labelDaysLeft:@"Сегодня:"]];
    }else if([parser.delivery_date isEqual:[parseDate dateFormatTomorow]]){
        
         [cell addSubview:[typeLabel labelDaysLeft:@"Завтра:"]];

    }else{
        [cell addSubview:[typeLabel labelDaysLeft:parser.delivery_date]];
    }
    //
    
    //Обрезаем последние :00
    if(parser.delivery_time_from.length>5){
        parser.delivery_time_from = [parser.delivery_time_from substringToIndex:[parser.delivery_time_from length] - 3];
    }
    
    if(parser.delivery_time_to.length>5){
        parser.delivery_time_to = [parser.delivery_time_to substringToIndex:[parser.delivery_time_to length] - 3];
    }
    //
    
    //Вывод диапазона времени доставки
    NSString * resultDeliveryTime;
    if(!parser.delivery_time_to){
         resultDeliveryTime = [NSString stringWithFormat:@"%@",parser.delivery_time_from];
    }else{
         resultDeliveryTime = [NSString stringWithFormat:@"%@ - %@",parser.delivery_time_from,parser.delivery_time_to];
    }
    
    [cell addSubview:[typeLabel labelTimeInterval:resultDeliveryTime]];
    
    
    [cell addSubview:[typeLabel imageViewTypeTableView:parser.order_type]];
    
    //Статус заказа
    if([parser.status integerValue] == 40){
        [cell addSubview:[typeLabel labelFormation:@"Формируется"]];
    }else{
        [cell addSubview:[typeLabel labelFormation:@"Сформирован"]];
    }
    //
    
    //Отображение корзины
    [cell addSubview:[typeLabel imageViewBasketTableView]];
    //
    
    //Строка веса
    NSString * resultWeight;
    if(!parser.order_count){

            resultWeight = [NSString stringWithFormat:@"Вес %@-%@ кг",parser.wfrom,parser.wto];

        
    }else{
        resultWeight = [NSString stringWithFormat:@"%@ заказа(ов)",parser.order_count];
    }
    
    [cell addSubview:[typeLabel weightAndNumberOfOrders:resultWeight]];
    //
    
    //Оставшееся время
    [cell addSubview:[typeLabel labelTimeRemaining:parser.delivery_string]];
    //
    
    //метро
    [cell addSubview:[typeLabel roundMetroView:parser.metro_line_id]];
    [cell addSubview:[typeLabel labelMetroStationName:parser.metro_id]];
    
    
    
    
    [cell addSubview:[typeLabel labelLineLeft]];
    
    }
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

#pragma mark - UITableViewDelegate
//Анимация нажатия ячейки--------------------------------------------------------------
- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    DetailsScoreboardOrderView* detail = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailsScoreboardOrder"];
    ParserOrders * parser =[self.arrayOrders objectAtIndex:indexPath.row];
    detail.orderID =parser.order_id;
    detail.getting_type=parser.getting_type;
    [self.navigationController pushViewController:detail animated:YES];
}

@end
