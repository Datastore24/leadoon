//
//  MapViewMyOrdersView.m
//  Leadoon
//
//  Created by Viktor on 31.10.15.
//  Copyright © 2015 Viktor. All rights reserved.
//

#import "MapViewMyOrdersView.h"
#import "SettingsView.h"
#import "ParserOrders.h"

@interface MapViewMyOrdersView () <CLLocationManagerDelegate, MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *topBarMapViewMyOrdersView; //Верхний Бар
@property (weak, nonatomic) IBOutlet UIButton *buttonBackMapViewMyOrdersView; //Кнопка назад
@property (weak, nonatomic) IBOutlet UIButton *buttonSettingMapViewMyOrdersView; //Кнопка настройка
@property (weak, nonatomic) IBOutlet UILabel *labelTopBarMapViewMyOrdersView; //Строка загаловка
@property (weak, nonatomic) IBOutlet UIButton *buttonZoomInMapViewMyOrdersView; //Кнопка увелечения
@property (weak, nonatomic) IBOutlet UIButton *buttonZoomOutMapViewMyOrdersView; //Кнопка уменьшения


@end

@implementation MapViewMyOrdersView

- (void)viewDidLoad

{
    [super viewDidLoad];
    
    for (int i = 0; i < self.arrayOrders.count; i++) {
        ParserOrders* parser = [self.arrayOrders objectAtIndex:i];
        
                NSLog(@"* * * * * * * * * * * *  * * * * * * * * * * *");
                NSLog(@"getting_type == \"%@\"", parser.getting_type);
                NSLog(@"order_id == \"%@\"", parser.order_id);
                NSLog(@"olat == \"%@\"", parser.olat);
                NSLog(@"olong == \"%@\"", parser.olong);
                NSLog(@"%@", parser.address);
    }
    
    
    
    CLLocationCoordinate2D cord;
    cord.latitude = 55.73850322752935;
    cord.longitude = 37.59373962879181;
    
    self.mapView.region = MKCoordinateRegionMakeWithDistance(cord, 50000, 50000);
    
    //Параметры кнопки buttomZoomIn-------------------------------------------------
    self.buttonZoomInMapViewMyOrdersView.backgroundColor = [UIColor clearColor];
    self.buttonZoomInMapViewMyOrdersView.layer.borderColor = [UIColor blackColor].CGColor;
    self.buttonZoomInMapViewMyOrdersView.layer.borderWidth = 2.f;
    self.buttonZoomInMapViewMyOrdersView.layer.cornerRadius = 15.f;
    self.buttonZoomInMapViewMyOrdersView.alpha = 7.f;
    [self.buttonZoomInMapViewMyOrdersView addTarget:self action:@selector(actionButtonZoomInMapViewMyOrdersView) forControlEvents:UIControlEventTouchUpInside];
    
    //Параметры кнопки buttomZoomOut-------------------------------------------------
    self.buttonZoomOutMapViewMyOrdersView.backgroundColor = [UIColor clearColor];
    self.buttonZoomOutMapViewMyOrdersView.layer.borderColor = [UIColor blackColor].CGColor;
    self.buttonZoomOutMapViewMyOrdersView.layer.borderWidth = 2.f;
    self.buttonZoomOutMapViewMyOrdersView.layer.cornerRadius = 15.f;
    self.buttonZoomOutMapViewMyOrdersView.alpha = 7.f;
    [self.buttonZoomOutMapViewMyOrdersView addTarget:self action:@selector(actionButtonZoomOutMapViewMyOrdersView) forControlEvents:UIControlEventTouchUpInside];
    
    //Параметры основного view------------------------------------------------------
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    //Параметры topBarMapViewOrder--------------------------------------------------
    self.topBarMapViewMyOrdersView.backgroundColor = [UIColor whiteColor];
    self.topBarMapViewMyOrdersView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.topBarMapViewMyOrdersView.layer.borderWidth = 1.f;
    
    //Параметры buttonBackMapViewOrder----------------------------------------------
    self.buttonBackMapViewMyOrdersView.backgroundColor = [UIColor clearColor];
    [self.buttonBackMapViewMyOrdersView addTarget:self action:@selector(actionButtonBackMapViewMyOrdersView) forControlEvents:UIControlEventTouchUpInside];
    
    //Параметры нкопки buttonSettingMapViewOrder------------------------------------
    self.buttonSettingMapViewMyOrdersView.backgroundColor = [UIColor clearColor];
    [self.buttonSettingMapViewMyOrdersView addTarget:self
                                                   action:@selector(actionButtonSettingMapViewMyOrdersView)
                                         forControlEvents:UIControlEventTouchUpInside];
    
    //Моё местоположение------------------------------------------------------------
    self.locationManager = [[CLLocationManager alloc] init];
    [self.locationManager requestAlwaysAuthorization];
    
    [self.locationManager startUpdatingLocation];
    self.locationManager.delegate = self;
    
    self.mapView.userLocation.title = @"Ваше местоположение";
}

//Действие кнопки buttonZoomInMapViewMyOrdersView------------------------------------
- (void)actionButtonZoomInMapViewMyOrdersView
{
    
    MKCoordinateRegion region = self.mapView.region;
    region.span.latitudeDelta /= 5.0;
    region.span.longitudeDelta /= 5.0;
    [self.mapView setRegion:region animated:YES];
}

//Действие кнопки buttonZoomOutMapViewMyOrdersView------------------------------------
- (void)actionButtonZoomOutMapViewMyOrdersView
{
    MKCoordinateRegion region = self.mapView.region;
    region.span.latitudeDelta = MIN(region.span.latitudeDelta * 5.0, 180.0);
    region.span.longitudeDelta = MIN(region.span.longitudeDelta * 5.0, 180.0);
    [self.mapView setRegion:region animated:YES];
}

//Дествие кнопки buttonBackMapViewMyOrdersView-----------------------------------------
- (void)actionButtonBackMapViewMyOrdersView
{
    [self.navigationController popViewControllerAnimated:YES];
}

//Действие кнопки buttonSettingMapViewMyOrdersView--------------------------------------
- (void)actionButtonSettingMapViewMyOrdersView
{
    SettingsView* detail = [self.storyboard instantiateViewControllerWithIdentifier:@"settingsView"];
    [self.navigationController pushViewController:detail animated:YES];
}
    

@end
