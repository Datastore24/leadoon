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

@property (weak, nonatomic) IBOutlet UIView *ViewLineScoreboardOrders; //View для создании линии

@end

@implementation ScoreboardOrdersView

- (void)viewDidLoad
{
    [super viewDidLoad];
    
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
    
    //Параметры tableViewScoreboardOrders---------------------------------------------
    self.tableViewScoreboardOrders.backgroundColor = [UIColor clearColor];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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
    [self.navigationController popViewControllerAnimated:YES];
    [Animation move_Label_Text_View_Right:self.imageViewButtonBack
                                   Points:0.f
                                    alpha:1.f];
}

//Тап кнопки ButtonBackScoreboardOrdersView-------------------------------------------
- (void)tapButtonSettingsScoreboardOrdersView
{
    [Animation move_Label_Text_View_Right:self.imageViewButtonSettings
                                   Points:0.f
                                    alpha:0.5f];
}

//Действи кнопки ButtonBackScoreboardOrdersView---------------------------------------
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
    return 3;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"Cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

@end