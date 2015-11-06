//
//  PartialSaleView.m
//  Leadoon
//
//  Created by Viktor on 06.11.15.
//  Copyright © 2015 Viktor. All rights reserved.
//

#import "PartialSaleView.h"
#import "SettingsView.h"
#import "UIColor+HexColor.h"

@interface PartialSaleView () <UIPickerViewDataSource, UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *topBarPartialSaleView;
@property (weak, nonatomic) IBOutlet UIButton *buttonBackPartialSaleView;
@property (weak, nonatomic) IBOutlet UIButton *buttonSettingsPartialSaleView;
@property (weak, nonatomic) IBOutlet UIButton *buttonApply;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerNumber1;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerNumber2;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerNumber3;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerNumber4;

@property (strong, nonatomic) NSMutableArray * arrayPicker1;
@property (strong, nonatomic) NSMutableArray * arrayPicker2;


@end

@implementation PartialSaleView

- (void)viewDidLoad

{
    [super viewDidLoad];
    
    //Первый пикер---------------------------------------------------------------------------
    
    self.arrayPicker1 = [NSMutableArray new];
    for (int i = 0; i < 1000; i++) {
        NSString * string = [[NSNumber numberWithInt:i] stringValue];
        [self.arrayPicker1 addObject:string];
    }
    
    self.pickerNumber1.dataSource = self;
    self.pickerNumber1.delegate = self;
    self.pickerNumber1.backgroundColor = [UIColor clearColor];
    self.pickerNumber3.dataSource = self;
    self.pickerNumber3.delegate = self;
    self.pickerNumber3.backgroundColor = [UIColor clearColor];
    
    //Второй пикер---------------------------------------------------------------------------
    self.arrayPicker2 = [NSMutableArray new];
    for (int i = 0; i < 1000; i += 10) {
        NSString * string = [[NSNumber numberWithInt:i] stringValue];
        [self.arrayPicker2 addObject:string];
    }
    
    self.pickerNumber2.delegate = self;
    self.pickerNumber2.dataSource = self;
    self.pickerNumber4.delegate = self;
    self.pickerNumber4.dataSource = self;
    
    
    //Параметры основного view---------------------------------------------------------------
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    //Параметра верхнего Бара topBarPartialSaleView--------------------------------------
    self.topBarPartialSaleView.backgroundColor = [UIColor whiteColor];
    self.topBarPartialSaleView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.topBarPartialSaleView.layer.borderWidth = 1.f;
    
    //Параметры buttonSettingsPartialSaleView----------------------------------
    self.buttonSettingsPartialSaleView.backgroundColor = [UIColor clearColor];
    [self.buttonSettingsPartialSaleView addTarget:self action:@selector(actionButtonSettingsScoreboardOrdersView)
                                      forControlEvents:UIControlEventTouchUpInside];
    
    //Параметры buttonBackPartialSaleView---------------------------------------
    self.buttonBackPartialSaleView.backgroundColor = [UIColor clearColor];
    [self.buttonBackPartialSaleView addTarget:self action:@selector(actionButtonBackScoreboardOrdersView)
                                  forControlEvents:UIControlEventTouchUpInside];
    
    UILabel * labelSum1 = [[UILabel alloc] initWithFrame:CGRectMake(280, 165, 60, 15)];
    labelSum1.text = @"600";
    labelSum1.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
    [self.view addSubview:labelSum1];
    
    UILabel * labelID1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 165, 50, 15)];
    labelID1.text = @"326870";
    labelID1.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
    [self.view addSubview:labelID1];
    
    UILabel * labelName1 = [[UILabel alloc] initWithFrame:CGRectMake(70, 165, 200, 15)];
    labelName1.text = @"Мышь оптическая USB";
    labelName1.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
    [self.view addSubview:labelName1];
    
    
    UILabel * labelSum2 = [[UILabel alloc] initWithFrame:CGRectMake(280, 197, 60, 15)];
    labelSum2.text = @"250";
    labelSum2.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
    [self.view addSubview:labelSum2];
    
    UILabel * labelID2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 197, 50, 15)];
    labelID2.text = @"058976";
    labelID2.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
    [self.view addSubview:labelID2];
    
    UILabel * labelName2 = [[UILabel alloc] initWithFrame:CGRectMake(70, 197, 200, 15)];
    labelName2.text = @"Коврик с подогревом";
    labelName2.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
    [self.view addSubview:labelName2];
    
    self.buttonApply.backgroundColor = [UIColor colorWithHexString:@"0db821"];
    self.buttonApply.layer.borderColor = [UIColor blackColor].CGColor;
    self.buttonApply.layer.cornerRadius = 10.f;
    self.buttonApply.layer.borderWidth = 1.5f;
    
}

//Действи кнопки ButtonBackScoreboardOrdersView---------------------------------------
- (void) actionButtonBackScoreboardOrdersView
{
    [self.navigationController popViewControllerAnimated:YES];
}

//Действи кнопки ButtonSettingsScoreboardOrdersView---------------------------------------
- (void) actionButtonSettingsScoreboardOrdersView
{
    SettingsView * detail = [self.storyboard instantiateViewControllerWithIdentifier:@"settingsView"];
    [self.navigationController pushViewController:detail animated:YES];
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if ([pickerView isEqual:self.pickerNumber1] || [pickerView isEqual:self.pickerNumber3]) {
        return self.arrayPicker1.count;
    }
    else if ([pickerView isEqual:self.pickerNumber2] || [pickerView isEqual:self.pickerNumber4]) {
        return self.arrayPicker2.count;
    }
    return 1;
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if ([pickerView isEqual:self.pickerNumber1] || [pickerView isEqual:self.pickerNumber3]) {
        return self.arrayPicker1[row];
    }
    else if ([pickerView isEqual:self.pickerNumber2] || [pickerView isEqual:self.pickerNumber4]) {
        return self.arrayPicker2[row];
    }
    return nil;
    
}

#pragma mark - UIPickerViewDelegate

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view {
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, pickerView.frame.size.width, 20)];
    label.backgroundColor = [UIColor whiteColor];
    label.textColor = [UIColor blackColor];
    label.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:12];
    if ([pickerView isEqual:self.pickerNumber1] || [pickerView isEqual:self.pickerNumber3]) {
        label.text = [NSString stringWithFormat:@" %@", self.arrayPicker1[row]];
    }
    else if ([pickerView isEqual:self.pickerNumber2] || [pickerView isEqual:self.pickerNumber4]) {
        label.text = [NSString stringWithFormat:@" %@", self.arrayPicker2[row]];
    }
    label.layer.borderColor = [UIColor blackColor].CGColor;
    label.layer.borderWidth = 1.5f;
    label.layer.cornerRadius = 5.f;
    return label;
}

@end
