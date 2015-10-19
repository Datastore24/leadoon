//
//  MapViewOrder.m
//  Leadoon
//
//  Created by Viktor on 17.10.15.
//  Copyright © 2015 Viktor. All rights reserved.
//

#import "MapViewOrder.h"
#import "SettingsView.h"
#import "CustomAnnotation.h"
#import "CustomMapPinView.h"

@interface MapViewOrder () <CLLocationManagerDelegate, MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet UIView* topBarMapViewOrder; //Верхний бар основного меню
@property (weak, nonatomic) IBOutlet UIButton* buttonBackMapViewOrder; //Кнопка возврата
@property (weak, nonatomic) IBOutlet UIButton* buttonSettingMapViewOrder; //Кнопка Настроек
@property (weak, nonatomic) IBOutlet UIButton* buttomZoomIn; //Кнопка увеличения
@property (weak, nonatomic) IBOutlet UIButton* ButtonZoomOut; //Кнопка уменьшения
@property (strong, nonatomic) NSArray* testArray; //Тестовый массив пинов

@end

@implementation MapViewOrder

- (void)viewDidLoad
{
    [super viewDidLoad];

    //Тестовый массив пинов---------------------------------------------------------

    NSNumber* oneLat = [NSNumber numberWithDouble:55.703907753303355];
    NSNumber* oneLon = [NSNumber numberWithDouble:37.52705699325445];
    NSString* blueString = @"blueString";

    NSNumber* twoLat = [NSNumber numberWithDouble:55.71515035189387];
    NSNumber* twoLon = [NSNumber numberWithDouble:37.68635875106694];
    NSString* brownString = @"brownString";

    NSNumber* threeLat = [NSNumber numberWithDouble:55.811516623930615];
    NSNumber* threeLon = [NSNumber numberWithDouble:37.58815451923337];
    NSString* greenString = @"greenString";

    NSDictionary* one = [NSDictionary dictionaryWithObjectsAndKeys:oneLat, @"Lat",
                                      oneLon, @"Lon",
                                      blueString, @"color", nil];

    NSDictionary* two = [NSDictionary dictionaryWithObjectsAndKeys:twoLat, @"Lat",
                                      twoLon, @"Lon",
                                      brownString, @"color", nil];

    NSDictionary* three = [NSDictionary dictionaryWithObjectsAndKeys:threeLat, @"Lat",
                                        threeLon, @"Lon",
                                        greenString, @"color", nil];

    self.testArray = [NSArray arrayWithObjects:one, two, three, nil];

    //Параметры кнопки buttomZoomIn-------------------------------------------------
    self.buttomZoomIn.backgroundColor = [UIColor clearColor];
    self.buttomZoomIn.layer.borderColor = [UIColor blackColor].CGColor;
    self.buttomZoomIn.layer.borderWidth = 2.f;
    self.buttomZoomIn.layer.cornerRadius = 15.f;
    self.buttomZoomIn.alpha = 7.f;
    [self.buttomZoomIn addTarget:self
                          action:@selector(actionButtomZoomIn)
                forControlEvents:UIControlEventTouchUpInside];

    //Параметры кнопки buttomZoomOut-------------------------------------------------
    self.ButtonZoomOut.backgroundColor = [UIColor clearColor];
    self.ButtonZoomOut.layer.borderColor = [UIColor blackColor].CGColor;
    self.ButtonZoomOut.layer.borderWidth = 2.f;
    self.ButtonZoomOut.layer.cornerRadius = 15.f;
    self.ButtonZoomOut.alpha = 7.f;
    [self.ButtonZoomOut addTarget:self
                           action:@selector(actionButtomZoomOut)
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

    [self setPinsWithArray:self.testArray];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

//Нанесение пинов на карту----------------------------------------------------------

- (void)setPinsWithArray:(NSArray*)arrayPins;
{
    for (int i = 0; i < self.testArray.count; i++) {

        NSDictionary* dict = [arrayPins objectAtIndex:i];
        double lat = [[dict objectForKey:@"Lat"] doubleValue];
        double lon = [[dict objectForKey:@"Lon"] doubleValue];

        CustomAnnotation* annotation = [[CustomAnnotation alloc] initWithLatitude:lat Longitude:lon];

        [self.mapView addAnnotation:annotation];
    }
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
    region.span.latitudeDelta = MIN(region.span.latitudeDelta * 5.0, 180.0);
    region.span.longitudeDelta = MIN(region.span.longitudeDelta * 5.0, 180.0);
    [self.mapView setRegion:region animated:YES];
}

#pragma mark - MKMapViewDelegate

- (nullable MKAnnotationView*)mapView:(MKMapView*)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{

    if (![annotation isKindOfClass:[MKUserLocation class]]) {

        for (int i = 0; i < self.testArray.count; i++) {

            NSDictionary* dict = [self.testArray objectAtIndex:i];

            NSString* stringColor = [dict objectForKey:@"color"];

            if ([stringColor isEqual:@"blueString"]) {

                CustomMapPinView* customPin = [[CustomMapPinView alloc] initWithImageBlue];
                return customPin;
            }

            if ([stringColor isEqual:@"brownString"]) {
                CustomMapPinView* customPin = [[CustomMapPinView alloc] initWithImageBrown];
                return customPin;
            }

            if ([stringColor isEqual:@"greenString"]) {
                CustomMapPinView* customPin = [[CustomMapPinView alloc] initWithImageGreen];
                return customPin;
            }
        }
    }

    return nil;
}

@end
