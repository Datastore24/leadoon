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
@property (weak, nonatomic) IBOutlet UISlider* sliderMapView;

@end

@implementation MapViewOrder

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.sliderMapView.transform = CGAffineTransformMakeRotation(M_PI_2);
    self.sliderMapView.value = 500;
    self.sliderMapView.minimumValue = 500;
    self.sliderMapView.maximumValue = 1000000;

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

#pragma mark - CLLocationManagerDelegate

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager*)manager
    didUpdateToLocation:(CLLocation*)newLocation
           fromLocation:(CLLocation*)oldLocation
{

    [self centerOnUserLocathion:newLocation.coordinate];
}

- (void)centerOnUserLocathion:(CLLocationCoordinate2D)coord
{
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coord, self.sliderMapView.value, self.sliderMapView.value);
    [self.mapView setRegion:region animated:YES];
}

@end
