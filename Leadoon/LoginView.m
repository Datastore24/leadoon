//
//  ViewController.m
//  Leadoon
//
//  Created by Viktor on 11.10.15.
//  Copyright © 2015 Viktor. All rights reserved.
//

#import "LoginView.h"
#import "MainView.h"
#import "Animation.h"
#import "APIClass.h"
#import "ParserCourier.h"
#import "ParserResponseCourier.h"
#import "CouriersDbClass.h"
#import "Couriers.h"

@interface LoginView () <UITextFieldDelegate>
//Атрибуты
@property (weak, nonatomic) IBOutlet UIView* topBarLoginView; //верхний Бар
@property (weak, nonatomic) IBOutlet UILabel* labelTopBarLoginView; //Заголовок
@property (weak, nonatomic) IBOutlet UITextField* textFieldEmailLoginView; //Ввод текста "Email"
@property (weak, nonatomic) IBOutlet UILabel* labelTextFieldEmailLoginView; //Надпись на textFieldEmailLoginView
@property (weak, nonatomic) IBOutlet UITextField* textFieldPasswordLoginView; //Ввод текста "Пароль"
@property (weak, nonatomic) IBOutlet UILabel* labelTextFieldPasswordLoginView; //Надпись на textFieldPasswordLoginView
@property (weak, nonatomic) IBOutlet UIButton* buttonEnterLoginView; //Кнопка запуска авторизации
@property (weak, nonatomic) IBOutlet UIButton* buttonLostPasswordLoginView; //Кнопка потери пароля

@property (strong, nonatomic) NSMutableArray * arrayResponce; //Массив с данными API

- (IBAction)animLabelTextFieldEmailLoginView:(id)sender;
- (IBAction)animLabelTextFielPasswordLoginView:(id)sender;

@end

@implementation LoginView

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    isTextChoosen = YES;
    isTextChoosen2 = YES;

    //Параметры mainView---------------------------------------------------
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];

    //Параметры topBarLoginView--------------------------------------------
    self.topBarLoginView.backgroundColor = [UIColor whiteColor];
    self.topBarLoginView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.topBarLoginView.layer.borderWidth = 1.f;

    //Параметры labelTextFieldEmailLoginView-------------------------------
    self.labelTextFieldEmailLoginView.alpha = 0.3f;

    //Параметры labelTextFieldPasswordLoginView----------------------------
    self.labelTextFieldPasswordLoginView.alpha = 0.3f;

    //Параметры buttonEnterLoginView---------------------------------------
    self.buttonEnterLoginView.backgroundColor = [UIColor whiteColor];
    self.buttonEnterLoginView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.buttonEnterLoginView.layer.borderWidth = 1.5f;
    self.buttonEnterLoginView.layer.cornerRadius = 5.f;
    //Временная реализация перехода без авторизации пользователя...--------
    [self.buttonEnterLoginView addTarget:self
                                  action:@selector(actionButtonEnterLoginView)
                        forControlEvents:UIControlEventTouchUpInside];
    
    //Параметры buttonLostPasswordLoginView--------------------------------
    [self.buttonLostPasswordLoginView addTarget:self action:@selector(actionButtonLostPasswordLoginView) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - API

//Авторизация пользователей
-(void) getApiCourier:(NSString *) email password: (NSString *) password andBlock:(void (^)(void))block{
    //Передаваемые параметры
    NSDictionary * params = [[NSDictionary alloc] initWithObjectsAndKeys:
                             email,@"email",
                             password,@"password",
                             nil];

    APIClass * api =[APIClass new]; //создаем API
    [api getDataFromServerWithParams:params method:@"action=auth" complitionBlock:^(id response) {
        
//        NSLog(@"%@",response);
//        Запуск парсера
        ParserResponseCourier * parsingResponce =[[ParserResponseCourier alloc] init];
     
        //парсинг данных и запись в массив
        self.arrayResponce = [parsingResponce parsing:response];
        block();
    }];
    
}


#pragma mark - ButtonsAction

//Действие кнопки buttonEnterLoginView---------------------------------------
- (void)actionButtonEnterLoginView
{

    if (self.textFieldPasswordLoginView.text.length == 0 && self.textFieldEmailLoginView.text.length == 0) {

        [self showAlertViewWithMessage:@"Введите E-mail и Пароль"];
    }

    else if (self.textFieldEmailLoginView.text.length == 0) {
        [self showAlertViewWithMessage:@"Введите E-mail"];
    }

    else if (self.textFieldPasswordLoginView.text.length == 0) {
        [self showAlertViewWithMessage:@"Введите Пароль"];
    }

    else {
        [self getApiCourier:self.textFieldEmailLoginView.text password:self.textFieldPasswordLoginView.text andBlock:^{
            
            ParserCourier * parse = [self.arrayResponce objectAtIndex:0];
            if([parse.enter integerValue] == 1){
                CouriersDbClass * courier = [[CouriersDbClass alloc] init];
                
                
              
                     [courier authFist:parse.email andPassword:parse.password andEnter:[NSNumber numberWithInt:1]];
                
                
                MainView* detail = [self.storyboard instantiateViewControllerWithIdentifier:@"mainView"];
                                   [self.navigationController pushViewController:detail animated:YES];
                
            }else{
              [self showAlertViewWithMessage:@"Неверный логин или пароль"];
            }
        }];
        
    }
}

//Проверяем входил ли пользователь, если входил перекидывай на меню
-(void) CheckAuth{
   
    CouriersDbClass * courier = [[CouriersDbClass alloc] init];
    
    
    Couriers *couriers = [[courier showAllUsers] objectAtIndex:2];

    
    
//    if([[courier loadCourier] count]){
//        MainView* detail = [self.storyboard instantiateViewControllerWithIdentifier:@"mainView"];
//        [self.navigationController pushViewController:detail animated:YES];
//
//    }
}

//Действие кнопки buttonLostPasswordLoginView--------------------------------
- (void) actionButtonLostPasswordLoginView {
    NSLog(@"Код восстановления утерянного пароля");
}


//Создание AlertView---------------------------------------------------------

- (void)showAlertViewWithMessage:(NSString*)message
{
    SCLAlertView* alert = [[SCLAlertView alloc] init];

    [alert showNotice:self title:@"Внимание!!!" subTitle:message closeButtonTitle:@"Ок" duration:0.f];
}

#pragma mark - UITextFieldDelegate

//Реализация текстового поля-------------------------------------------------
- (BOOL)textFieldShouldReturn:(UITextField*)textField
{

    if ([textField isEqual:self.textFieldEmailLoginView]) {

        [self.textFieldEmailLoginView resignFirstResponder];
        return YES;
    }

    if ([textField isEqual:self.textFieldPasswordLoginView]) {

        [self.textFieldPasswordLoginView resignFirstResponder];
        return YES;
    }
    return NO;
}

//Анимация label в textFieldEmailLoginView------------------------------------
- (IBAction)animLabelTextFieldEmailLoginView:(id)sender
{

    if (self.textFieldEmailLoginView.text.length != 0) {
        if (isTextChoosen) {

            isTextChoosen = NO;
            [Animation move_Label_Text_View_Right:self.labelTextFieldEmailLoginView
                                           Points:+35.f alpha:0.f];
        }
    }

    else {

        if (!isTextChoosen) {
            isTextChoosen = YES;
            [Animation move_Label_Text_View_Right:self.labelTextFieldEmailLoginView
                                           Points:-35.f alpha:0.3f];
        }
    }
}

//Анимация label в textFieldPasswordLoginView----------------------------------
- (IBAction)animLabelTextFielPasswordLoginView:(id)sender
{
    if (self.textFieldPasswordLoginView.text.length != 0) {
        if (isTextChoosen2) {

            isTextChoosen2 = NO;
            [Animation move_Label_Text_View_Right:self.labelTextFieldPasswordLoginView
                                           Points:+35.f alpha:0.f];
        }
    }

    else {

        if (!isTextChoosen2) {
            isTextChoosen2 = YES;
            [Animation move_Label_Text_View_Right:self.labelTextFieldPasswordLoginView
                                           Points:-35.f alpha:.3f];
        }
    }
}

@end
