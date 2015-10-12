//
//  MainView.m
//  Leadoon
//
//  Created by Viktor on 12.10.15.
//  Copyright © 2015 Viktor. All rights reserved.
//

#import "MainView.h"
#import "Animation.h"
#import "SettingsView.h"

@interface MainView ()
@property (weak, nonatomic) IBOutlet UIView* topBarMainView; //Верхний Бар;
@property (weak, nonatomic) IBOutlet UILabel* topLabelMainView; //Заголовок верхнего бара
@property (weak, nonatomic) IBOutlet UIButton* buttonSettingsMainView; //Кнопка перехода в настройки
@property (weak, nonatomic) IBOutlet UIButton* buttonScoreboardOrdersMainView; //Табло заказов
@property (weak, nonatomic) IBOutlet UIButton* buttonMyOrdersMainView; //Мои заказы
@property (weak, nonatomic) IBOutlet UIButton* buttonCompletedOrdersMainView; //Выполненные заказы
@property (weak, nonatomic) IBOutlet UIButton* buttonFinancesMainView; //Финансы
@property (weak, nonatomic) IBOutlet UIImageView *imageButtonSettingMainView; //Изображение на кнопке "Настройки"

@end

@implementation MainView

- (void)viewDidLoad
{
    [super viewDidLoad];

    //Параметры главного view----------------------------------------------
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];

    //Параметры главного topBarMainView------------------------------------
    self.topBarMainView.backgroundColor = [UIColor whiteColor];
    self.topBarMainView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.topBarMainView.layer.borderWidth = 1.f;

    //Параметры buttonScoreboardOrdersMainView-----------------------------
    [self drawButtonsView:self.buttonScoreboardOrdersMainView];

    //Параметры buttonMyOrdersMainView-------------------------------------
    [self drawButtonsView:self.buttonMyOrdersMainView];

    //Параметры buttonCompletedOrdersMainView------------------------------
    [self drawButtonsView:self.buttonCompletedOrdersMainView];

    //Параметры buttonFinancesMainView-------------------------------------
    [self drawButtonsView:self.buttonFinancesMainView];

    //Параметры buttonSettingsMainView-------------------------------------
    self.buttonSettingsMainView.backgroundColor = [UIColor clearColor];
    [self.buttonSettingsMainView addTarget:self action:@selector(tapButtonSettingsMainView)
                                      forControlEvents:UIControlEventTouchDown];
    [self.buttonSettingsMainView addTarget:self action:@selector(actionButtonSettingsMainView)
                                      forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

//Рисуем кнопки------------------------------------------------------------
- (void)drawButtonsView:(UIButton*)button
{

    button.backgroundColor = [UIColor whiteColor];
    button.layer.borderColor = [UIColor lightGrayColor].CGColor;
    button.layer.borderWidth = 1.5f;
    button.layer.cornerRadius = 10.f;
}

//Тап buttonSettingsMainView-----------------------------------------------
- (void)tapButtonSettingsMainView
{
    [Animation move_Label_Text_View_Right:self.imageButtonSettingMainView Points:0.f
                                                                       alpha:0.5f];

}

//Действие buttonSettingsMainView------------------------------------------
- (void)actionButtonSettingsMainView
{
    [Animation move_Label_Text_View_Right:self.imageButtonSettingMainView Points:0.f
                                                                       alpha:1.f];
    SettingsView * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"settingsView"];
    [self.navigationController pushViewController:detail animated:YES];
    
    
    

}



@end
