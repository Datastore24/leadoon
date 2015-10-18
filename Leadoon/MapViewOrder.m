//
//  MapViewOrder.m
//  Leadoon
//
//  Created by Viktor on 17.10.15.
//  Copyright © 2015 Viktor. All rights reserved.
//

#import "MapViewOrder.h"
#import "SettingsView.h"

@interface MapViewOrder () <CLLocationManagerDelegate, MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet UIView* topBarMapViewOrder; //Верхний бар основного меню
@property (weak, nonatomic) IBOutlet UIButton* buttonBackMapViewOrder; //Кнопка возврата
@property (weak, nonatomic) IBOutlet UIButton* buttonSettingMapViewOrder; //Кнопка Настроек
@property (weak, nonatomic) IBOutlet UIButton* buttomZoomIn; //Кнопка увеличения
@property (weak, nonatomic) IBOutlet UIButton* ButtonZoomOut; //Кнопка уменьшения

@end

@implementation MapViewOrder

- (void)viewDidLoad
{
    [super viewDidLoad];

    //Параметры кнопки buttomZoomIn-------------------------------------------------
    self.buttomZoomIn.backgroundColor = [UIColor clearColor];
    self.buttomZoomIn.layer.borderColor = [UIColor blackColor].CGColor;
    self.buttomZoomIn.layer.borderWidth = 2.f;
    self.buttomZoomIn.layer.cornerRadius = 15.f;
    self.buttomZoomIn.alpha = 7.f;
    [self.buttomZoomIn addTarget:self action:@selector(actionButtomZoomIn)
                            forControlEvents:UIControlEventTouchUpInside];

    //Параметры кнопки buttomZoomOut-------------------------------------------------
    self.ButtonZoomOut.backgroundColor = [UIColor clearColor];
    self.ButtonZoomOut.layer.borderColor = [UIColor blackColor].CGColor;
    self.ButtonZoomOut.layer.borderWidth = 2.f;
    self.ButtonZoomOut.layer.cornerRadius = 15.f;
    self.ButtonZoomOut.alpha = 7.f;
    [self.ButtonZoomOut addTarget:self action:@selector(actionButtomZoomOut)
                             forControlEvents:UIControlEventTouchUpInside];

    //Параметры основного view------------------------------------------------------
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];

    //Параметры topBarMapViewOrder--------------------------------------------------
    self.topBarMapViewOrder.backgroundColor = [UIColor whiteColor];
    self.topBarMapViewOrder.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.topBarMapViewOrder.layer.borderWidth = 1.f;

    //Параметры buttonBackMapViewOrder----------------------------------------------
    self.buttonBackMapViewOrder.backgroundColor = [UIColor clearColor];
    [self.buttonBackMapViewOrder addTarget:self
                                    action:@selector(actionButtonBackMapViewOrder)
                          forControlEvents:UIControlEventTouchUpInside];

    //Параметры нкопки buttonSettingMapViewOrder------------------------------------
    self.buttonSettingMapViewOrder.backgroundColor = [UIColor clearColor];
    [self.buttonSettingMapViewOrder addTarget:self
                                       action:@selector(actionButtonSettingMapViewOrder)
                             forControlEvents:UIControlEventTouchUpInside];

    //Моё местоположение------------------------------------------------------------
    self.locationManager = [[CLLocationManager alloc] init];
    [self.locationManager requestAlwaysAuthorization];

    [self.locationManager startUpdatingLocation];
    self.locationManager.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

//Дествие кнопки buttonBackMapViewOrder---------------------------------------------
- (void)actionButtonBackMapViewOrder
{
    [self.navigationController popViewControllerAnimated:YES];
}

//Действие кнопки buttonSettingMapViewOrder-----------------------------------------
- (void)actionButtonSettingMapViewOrder
{
    SettingsView* detail = [self.storyboard instantiateViewControllerWithIdentifier:@"settingsView"];
    [self.navigationController pushViewController:detail animated:YES];
}

//Действие кнопки buttomZoomIn------------------------------------------------------
- (void)actionButtomZoomIn
{

    MKCoordinateRegion region = self.mapView.region;
    region.span.latitudeDelta /= 5.0;
    region.span.longitudeDelta /= 5.0;
    [self.mapView setRegion:region animated:YES];
}

//Действие кнопки buttomZoomOut----------------------------------------------------
- (void)actionButtomZoomOut
{
    MKCoordinateRegion region = self.mapView.region;
    region.span.latitudeDelta  = MIN(region.span.latitudeDelta  * 5.0, 180.0);
    region.span.longitudeDelta = MIN(region.span.longitudeDelta * 5.0, 180.0);
    [self.mapView setRegion:region animated:YES];
}

@end
