//
//  ViewController.m
//  Leadoon
//
//  Created by Viktor on 11.10.15.
//  Copyright © 2015 Viktor. All rights reserved.
//

#import "LoginView.h"
#import "MainView.h" //Меню
#import "Animation.h" //Анимации
#import "APIClass.h" //Класс работы с API
#import "ParserCourier.h" //Парсинг данных с Api (MOTIS)
#import "ParserResponseCourier.h" //Парсинг ответа от сервера, добавление его в массив
#import "CouriersDbClass.h" //Работа с CoreData, методы работы с базой
#import "Couriers.h" //атрибуты из CoreData

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
@property (strong, nonatomic) NSMutableArray * arrayCheck; //Массив с данными API

- (IBAction)animLabelTextFieldEmailLoginView:(id)sender;
- (IBAction)animLabelTextFielPasswordLoginView:(id)sender;

@end

@implementation LoginView

- (void)viewDidLoad
{
    [super viewDidLoad];
    /*
     Проверка авторизации пользователя, если пользователь ранее авторизован и данные 
     с сервера соответствуют, то ему буде показан MainView.
     В случае если данные на сервере изменились, то мы считаем пользователя удаленным или забаненным (смена пароля, удаление и т.д) при этом удаляем данные из CoreData и выводим сообщение об ошибки.
     В случае превого захода пользователя и отсутствия данных в  CoreData мы выводим LoginView с предложением ввести
     логин и пароль. При вводе логина проверяем соответствие данных сервера и добавлем данные в CoreData. Главные атрибутов правильного входа в API является ключ enter - который возвращает:
     1 и данные пользователя с сервера
     0 - что означает пользоветль не найден, или не павильный логин и пароль
     
     */
    
    [self CheckAuth];
    
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
        
        ParserResponseCourier * parsingResponce =[[ParserResponseCourier alloc] init];
     
        //парсинг данных и запись в массив
        self.arrayResponce = [parsingResponce parsing:response];
        block();
    }];
    
}

//Проверка существует ли такой пользователь или нет
-(void) getApiCourierCheck:(NSString *) email password: (NSString *) password andBlock:(void (^)(void))block{
    //Передаваемые параметры
    NSDictionary * params = [[NSDictionary alloc] initWithObjectsAndKeys:
                             email,@"email",
                             password,@"password",
                             nil];
    
    APIClass * api =[APIClass new]; //создаем API
    [api getDataFromServerWithParams:params method:@"action=auth" complitionBlock:^(id response) {
        
        ParserResponseCourier * parsingResponce =[[ParserResponseCourier alloc] init];
        
        //парсинг данных и запись в массив
        self.arrayCheck = [parsingResponce parsing:response];
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
            
            //Проверка главного ключа входа 1- успешно, 0 - неуспешно
            if([parse.enter integerValue] == 1){
                CouriersDbClass * courierDbClass = [[CouriersDbClass alloc] init];
                
                //Проверка существует ли пользователь в CoreData
                if(![courierDbClass checkUsers:self.textFieldEmailLoginView.text andPassword:self.textFieldPasswordLoginView.text]){
                    
                    //Добавление данных успешно вошедшего пользователя в CoreData
                     [courierDbClass authFist:self.textFieldEmailLoginView.text andPassword:self.textFieldPasswordLoginView.text andEnter:[NSNumber numberWithInt:1]];
                
                }
                //Переход в меню
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
    NSArray * array = [courier showAllUsers]; //Массив данных CoreData
    
    for (int i; i<array.count; i++) {
        Couriers * courierCoreData = [array objectAtIndex:i];
        
        //Проверка существования пользователя
         [self getApiCourierCheck:courierCoreData.email password:courierCoreData.password andBlock:^{
             ParserCourier * parse = [self.arrayCheck objectAtIndex:0];
          
             //Перенаправление пользоваетеля в слуачае если данные из базы и данные с сервера соответствуют
             
             if([parse.email isEqual: courierCoreData.email] && [parse.password isEqual: courierCoreData.password]){
                 
                 MainView* detail = [self.storyboard instantiateViewControllerWithIdentifier:@"mainView"];
                 [self.navigationController pushViewController:detail animated:YES];
                 
                 
             }else{
                 [courier deleteCourier]; //Удаление устаревших данных
                 [self showAlertViewWithMessage:@"Вы вышли из системы"]; //Вывод сообщения об ошибке
             }
             
         }];
        
        
        
        

    }

    
    
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
