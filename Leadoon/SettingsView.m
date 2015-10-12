//
//  SettingsView.m
//  Leadoon
//
//  Created by Viktor on 12.10.15.
//  Copyright © 2015 Viktor. All rights reserved.
//

#import "SettingsView.h"
#import "Animation.h"

@interface SettingsView ()
@property (weak, nonatomic) IBOutlet UIView* topBarSettingsView; //Верхний бар
@property (weak, nonatomic) IBOutlet UILabel* labelTopBarSettingsView; //Заголовок верхнего была
@property (weak, nonatomic) IBOutlet UIButton* buttonBackSettingsView; //Кнопка возврата к предыдущему view
@property (weak, nonatomic) IBOutlet UILabel* labelIDSettingsView; //Изменяемая строка "ID"
@property (weak, nonatomic) IBOutlet UILabel* labelGroupSettingsView; //Изменяемая строка "Группа"
@property (weak, nonatomic) IBOutlet UILabel* labelE_MailSettingsView; //Измеяемая строка "E-Mail"
@property (weak, nonatomic) IBOutlet UILabel* labelPhoneSettingsView; //Изменяемая строка "Телефон"

@property (weak, nonatomic) IBOutlet UIButton* buttonChangePasswordSettingsView; //Кнопка смены пароля
@property (weak, nonatomic) IBOutlet UIButton* buttonChangePhoneSettingsView; //Кнопка сменя телефона

@property (weak, nonatomic) IBOutlet UISwitch* switchEmployment; //Выбор занятости
@property (weak, nonatomic) IBOutlet UISwitch* switchTransport; //Выбор транспорта
@property (weak, nonatomic) IBOutlet UIImageView* imageButtonBackSettingsView; //Изображение кнопки "Back"

@end

@implementation SettingsView

- (void)viewDidLoad
{
    [super viewDidLoad];

    //Параметры settingsView------------------------------------------------------
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];

    //Параметры topBarSettingsView------------------------------------------------
    self.topBarSettingsView.backgroundColor = [UIColor whiteColor];
    self.topBarSettingsView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.topBarSettingsView.layer.borderWidth = 1.f;

    //Параметры buttonBackSettingsView--------------------------------------------
    self.buttonBackSettingsView.backgroundColor = [UIColor clearColor];
    [self.buttonBackSettingsView addTarget:self
                                    action:@selector(tapButtonBackSettingsView)
                          forControlEvents:UIControlEventTouchDown];
    [self.buttonBackSettingsView addTarget:self
                                    action:@selector(actionButtonBackSettingsView)
                          forControlEvents:UIControlEventTouchUpInside];

    //Параметры buttonChangePasswordSettingsView-----------------------------------
    [self drawButtonsView:self.buttonChangePasswordSettingsView];

    //Параметры buttonChangePhoneSettingsView--------------------------------------
    [self drawButtonsView:self.buttonChangePhoneSettingsView];

    //Параметры переключателя switchEmployment-------------------------------------
    [self.switchEmployment setOn:NO animated:YES];
    [self.switchEmployment addTarget:self
                              action:@selector(actionSwitchEmployment)
                    forControlEvents:UIControlEventTouchUpInside];
    
    //Параметры переключателя switchTransport--------------------------------------
    [self.switchTransport setOn:NO animated:YES];
    [self.switchTransport addTarget:self
                              action:@selector(actionSwitchTransport)
                    forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

//Тап кнопки buttonBackSettingsView--------------------------------------------------
- (void)tapButtonBackSettingsView
{
    [Animation move_Label_Text_View_Right:self.imageButtonBackSettingsView
                                   Points:0.f
                                    alpha:0.5f];
}

//Дествие кнопки buttonBackSettingsView----------------------------------------------
- (void)actionButtonBackSettingsView
{
    [Animation move_Label_Text_View_Right:self.imageButtonBackSettingsView
                                   Points:0.f
                                    alpha:1.f];
    [self.navigationController popViewControllerAnimated:YES];
}

//Рисуем кнопки----------------------------------------------------------------------
- (void)drawButtonsView:(UIButton*)button
{

    button.backgroundColor = [UIColor whiteColor];
    button.layer.borderColor = [UIColor lightGrayColor].CGColor;
    button.layer.borderWidth = 1.5f;
    button.layer.cornerRadius = 10.f;
}

//Действие переключателя switchEmployment--------------------------------------------
- (void)actionSwitchEmployment
{
    if (self.switchEmployment.on) {
        NSLog(@"Занят");
    }
    else {
        NSLog(@"Свободен");
    }
}

//Действие переключателя switchTransport---------------------------------------------
- (void)actionSwitchTransport
{
    if (self.switchTransport.on) {
        NSLog(@"Я пешком");
    }
    else {
        NSLog(@"Я на машине");
    }
}

@end
