//
//  AdditionalExpenses.m
//  Leadoon
//
//  Created by Viktor on 27.11.15.
//  Copyright © 2015 Viktor. All rights reserved.
//

#import "AdditionalExpenses.h"
#import "SettingsView.h"
#import "UIColor+HexColor.h"
#import <SCLAlertView-Objective-C/SCLAlertView.h>
#import "HeightForText.h"

#define NUMBERS_ONLY @"1234567890"
#define CHARACTER_LIMIT 8

@interface AdditionalExpenses () <UITextViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;
@property (weak, nonatomic) IBOutlet UIView *topBarAdditionalExpenses;
@property (weak, nonatomic) IBOutlet UIButton *buttonBackAdditionalExpenses;
@property (weak, nonatomic) IBOutlet UIButton *buttonSettingAdditionalExpenses;
@property (weak, nonatomic) IBOutlet UITextView *textViewTest;
@property (weak, nonatomic) IBOutlet UITextView *textViewSum;

@property (strong, nonatomic) NSMutableArray * testMArray;
@property (assign, nonatomic) CGFloat labelNameItemsHeight; //ВЫсота наименования товара
@property (assign, nonatomic) CGFloat heightItams;

@end

@implementation AdditionalExpenses

#pragma mark - Options

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    HeightForText* heightForText = [HeightForText new];
    self.testMArray = [NSMutableArray new];
    
    for (int i = 0; i < 2; i++) {
    self.labelNameItemsHeight = [heightForText getHeightForText:@"Очень важное описание, описывающее очень важное" textWith:self.view.frame.size.width withFont:[UIFont systemFontOfSize:14]];
        
        UILabel * labelNameItems = [[UILabel alloc] initWithFrame:
                          CGRectMake(80, 20 + 40 * i , 200, self.labelNameItemsHeight + 10)];
 
        labelNameItems.numberOfLines = 0;
        labelNameItems.lineBreakMode = NSLineBreakByWordWrapping;
        labelNameItems.text = @"Очень важное описание, описывающее очень важное";
        labelNameItems.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
        [self.mainScrollView addSubview:labelNameItems];
        
        UILabel * labelSumItems = [[UILabel alloc] initWithFrame:
                                    CGRectMake(200, 30 + 40 * i , 80, 20)];
        
        labelSumItems.numberOfLines = 0;
        labelSumItems.lineBreakMode = NSLineBreakByWordWrapping;
        labelSumItems.text = @"80 р.";
        labelSumItems.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
        labelSumItems.textAlignment = UITextAlignmentRight;
        labelSumItems.textColor = [UIColor colorWithHexString:@"ee7800"];
        [self.mainScrollView addSubview:labelSumItems];
        
        //Создание кнопки Добавление строки--------------------------------------------
        UIButton * buttonDelete = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonDelete.frame = CGRectMake(20, 30 + 40 * i , 30, 30);
        buttonDelete.backgroundColor = [UIColor clearColor];
        [self.mainScrollView addSubview: buttonDelete];
        
        UIImageView * buttonDeleteImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        buttonDeleteImage.image = [UIImage imageNamed:@"deleteButton.png"];
        [buttonDelete addSubview:buttonDeleteImage];
        
    }
    
    self.heightItams = 50 + 20 + 40 * 2;

    
    
    //Text view наименование--------------------------------------------------------
    self.textViewTest.delegate = self;
    self.textViewTest.frame = CGRectMake(50, self.heightItams + 30, 230, 70);
    self.textViewTest.layer.cornerRadius = 7.f;
    self.textViewTest.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.textViewTest.layer.borderWidth = 1.f;
    
    //TextField Сумма----------------------------------------------------------------
    self.textViewSum.delegate = self;
    self.textViewSum.frame = CGRectMake(160, self.heightItams + 120, 120, 30);
    self.textViewSum.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.textViewSum.layer.borderWidth = 1.f;
    self.textViewSum.layer.cornerRadius = 7.f;
    
    //Заоловок наименование---------------------------------------------------------
    UILabel * labelName = [[UILabel alloc] initWithFrame:CGRectMake(50, self.heightItams, 100, 30)];
    labelName.text = @"Описание:";
    labelName.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
    labelName.alpha = 0.5f;
    [self.mainScrollView addSubview:labelName];
    
    //Заоловок наименование---------------------------------------------------------
    UILabel * labelSum = [[UILabel alloc] initWithFrame:CGRectMake(110, self.heightItams + 120, 100, 30)];
    labelSum.text = @"Сумма:";
    labelSum.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
    labelSum.alpha = 0.5f;
    [self.mainScrollView addSubview:labelSum];
    
    
    self.mainScrollView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    //Параметры основного view------------------------------------------------------
    self.view.backgroundColor = [UIColor whiteColor];
    
    //Параметра верхнего Бара DetailScoreboardOrderView-----------------------------
    self.topBarAdditionalExpenses.backgroundColor = [UIColor whiteColor];
    self.topBarAdditionalExpenses.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.topBarAdditionalExpenses.layer.borderWidth = 1.f;
    
    //Параметры buttonBackMapViewOrder----------------------------------------------
    self.buttonBackAdditionalExpenses.backgroundColor = [UIColor clearColor];
    [self.buttonBackAdditionalExpenses addTarget:self action:@selector(actionButtonBackAdditionalExpenses) forControlEvents:UIControlEventTouchUpInside];
    
    //Параметры нкопки buttonSettingMapViewOrder------------------------------------
    self.buttonSettingAdditionalExpenses.backgroundColor = [UIColor clearColor];
    [self.buttonSettingAdditionalExpenses addTarget:self
                                      action:@selector(actionButtonSettingAdditionalExpenses)
                            forControlEvents:UIControlEventTouchUpInside];
    
    //Создание кнопки Добавление строки--------------------------------------------
    UIButton * buttonAddLabel = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonAddLabel setTitle:@"Добавить расход" forState:UIControlStateNormal];
    buttonAddLabel.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    buttonAddLabel.frame = CGRectMake(70, self.heightItams + 230, 180, 30);
    buttonAddLabel.backgroundColor = [UIColor colorWithHexString:@"046323"];
    buttonAddLabel.layer.borderColor = [UIColor darkGrayColor].CGColor;
    buttonAddLabel.layer.borderWidth = 1.f;
    buttonAddLabel.layer.cornerRadius = 9.f;
    [buttonAddLabel addTarget:self action:@selector(actionButtonAddLabel)
             forControlEvents:UIControlEventTouchUpInside];
    [self.mainScrollView addSubview: buttonAddLabel];
    
    self.mainScrollView.contentSize = CGSizeMake(320, self.heightItams + 200 + 150);
    
}

#pragma mark - Buttons

//Параметры кнопки ButtonBackAdditionalExpenses---------------------------------------------
- (void)actionButtonBackAdditionalExpenses
{
    [self.navigationController popViewControllerAnimated:YES];
}

//Параметры кнопки ButtonSettingAdditionalExpenses------------------------------------------
- (void)actionButtonSettingAdditionalExpenses
{
    SettingsView * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"settingsView"];
    [self.navigationController pushViewController:detail animated:YES];
}


- (void)textViewDidBeginEditing:(UITextView *)textView {
    self.mainScrollView.contentOffset = (CGPoint){
        0, 40 * 2

    };
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    self.mainScrollView.contentOffset = (CGPoint){0, 0};
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [self.textViewTest resignFirstResponder];
        [self.textViewSum resignFirstResponder];
        return NO;
    }
    else {
        return YES;
    }

}


- (void)actionButtonAddLabel
{
    
    //Нужна реализация вводе ссумы, ввод должен производиться только числами !!!!!!
    
    if (self.textViewTest.text.length == 0 && self.textViewSum.text.length == 0) {
        SCLAlertView* alert = [[SCLAlertView alloc] init];
        
        [alert showNotice:self title:@"Внимание!!!" subTitle:@"Введите данные в текстовые поля" closeButtonTitle:@"Ок" duration:0.f];
    }
    
    else if (self.textViewTest.text.length == 0) {
        
        SCLAlertView* alert = [[SCLAlertView alloc] init];
        
        [alert showNotice:self title:@"Внимание!!!" subTitle:@"Введите описание расхода" closeButtonTitle:@"Ок" duration:0.f];
    }
    
    else if (self.textViewSum.text.length == 0)
    {
        SCLAlertView* alert = [[SCLAlertView alloc] init];
        
        [alert showNotice:self title:@"Внимание!!!" subTitle:@"Введите сумму расхода" closeButtonTitle:@"Ок" duration:0.f];
    }
    
    
    else {

        
        self.textViewTest.text = @"";
        self.textViewSum.text = @"";
        
    }
}

@end
