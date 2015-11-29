//
//  HistoryOfTheMovement.m
//  Leadoon
//
//  Created by Viktor on 27.11.15.
//  Copyright © 2015 Viktor. All rights reserved.
//

#import "HistoryOfTheMovement.h"
#import "SettingsView.h"
#import "UIColor+HexColor.h"

@interface HistoryOfTheMovement () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView* mainTableView;

@property (weak, nonatomic) IBOutlet UIView* topBarHistory;
@property (weak, nonatomic) IBOutlet UIButton* buttonBackHistory;
@property (weak, nonatomic) IBOutlet UIButton* buttonSettingHistory;

@property (assign, nonatomic) CGFloat hightContent;
@end

@implementation HistoryOfTheMovement

#pragma mark - Options

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.hightContent = 0.f;

    //Параметры основного view------------------------------------------------------
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];

    self.mainTableView.backgroundColor = [UIColor clearColor];

    //Параметра верхнего Бара DetailScoreboardOrderView-----------------------------
    self.topBarHistory.backgroundColor = [UIColor whiteColor];
    self.topBarHistory.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.topBarHistory.layer.borderWidth = 1.f;

    //Параметры buttonBackMapViewOrder----------------------------------------------
    self.buttonBackHistory.backgroundColor = [UIColor clearColor];
    [self.buttonBackHistory addTarget:self action:@selector(actionButtonBackHistory) forControlEvents:UIControlEventTouchUpInside];

    //Параметры нкопки buttonSettingMapViewOrder------------------------------------
    self.buttonSettingHistory.backgroundColor = [UIColor clearColor];
    [self.buttonSettingHistory addTarget:self
                                  action:@selector(actionButtonSettingHistory)
                        forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - Buttons

//Параметры кнопки ButtonBackHistory---------------------------------------------
- (void)actionButtonBackHistory
{
    [self.navigationController popViewControllerAnimated:YES];
}

//Параметры кнопки ButtonSettingHistory------------------------------------------
- (void)actionButtonSettingHistory
{
    SettingsView* detail = [self.storyboard instantiateViewControllerWithIdentifier:@"settingsView"];
    [self.navigationController pushViewController:detail animated:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{

    return 15;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    NSString* identifier = @"Cell";
    UITableViewCell* Cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];

    for (int i = 0; i < 7; i++) {

        UILabel* nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 35 + 30 * i, 200, 30)];
        NSString* string = [NSString stringWithFormat:@"Привет как дела ?? : %d", i];
        nameLabel.text = string;
        nameLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
        [Cell addSubview:nameLabel];

        UILabel* sumLabel = [[UILabel alloc] initWithFrame:CGRectMake(250, 35 + 30 * i, 50, 30)];
        sumLabel.text = @"3000";
        sumLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
        sumLabel.textAlignment = UITextAlignmentRight;
        [Cell addSubview:sumLabel];
        
    }
    
    UILabel * inTotalLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 35 + 30 * 7, 200, 40)];
    inTotalLabel.text = @"Итого за сегодная: 27000";
    inTotalLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];
    [Cell addSubview:inTotalLabel];

    [Cell addSubview:[self dateLabel:@"17.08.15"]];

    Cell.backgroundColor = [UIColor clearColor];

    return Cell;
}

- (UILabel*)dateLabel:(NSString*)string
{
    UILabel* dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(140, 10, 60, 20)];
    dateLabel.text = string;
    dateLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
    dateLabel.textColor = [UIColor colorWithHexString:@"6e2a8d"];

    return dateLabel;
}


@end
