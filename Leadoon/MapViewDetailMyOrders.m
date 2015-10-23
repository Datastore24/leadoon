//
//  MapViewDetailMyOrders.m
//  Leadoon
//
//  Created by Viktor on 21.10.15.
//  Copyright © 2015 Viktor. All rights reserved.
//

#import "MapViewDetailMyOrders.h"
#import "SettingsView.h"
#import <SCLAlertView-Objective-C/SCLAlertView.h>

@interface MapViewDetailMyOrders () <CLLocationManagerDelegate, MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *topBarMapViewDetailMyOrders; //Верхний бар
@property (weak, nonatomic) IBOutlet UIButton *buttonBackMapViewDetailMyOrders; //Кнопка возврата
@property (weak, nonatomic) IBOutlet UIButton *buttonSettingMapViewDetailMyOrders; //Кнопка настроек
@property (weak, nonatomic) IBOutlet UILabel *labelTopBarMapViewDetailMyOrders; //Заголовок
@property (weak, nonatomic) IBOutlet UIButton *buttonZoomInMapViewDetailMyOrders; //Кнопка приближения карты
@property (weak, nonatomic) IBOutlet UIButton *buttonZoomOutMapViewDetailMyOrders; //Кнопка удаления карты


@property (strong, nonatomic) NSMutableArray *annotationArray;


@end

@implementation MapViewDetailMyOrders

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.annotationArray = [[NSMutableArray alloc] init];
    
    ZSAnnotation *annotation = nil;
    
    annotation = [[ZSAnnotation alloc] init];
    annotation.coordinate = CLLocationCoordinate2DMake(55.73850322752935, 37.69373962879181);
    annotation.color = [UIColor brownColor];
    annotation.title = @"13-я парковая 40";
    annotation.subtitle = @"Щелковская";
    annotation.type = ZSPinAnnotationTypeDisc;
    [self.annotationArray addObject:annotation];
    
    [self.mapViewDetailMyOrders addAnnotations:self.annotationArray];
    
    
    
    CLLocationCoordinate2D cord;
    cord.latitude = 55.73850322752935;
    cord.longitude = 37.69373962879181;
    
    self.mapViewDetailMyOrders.region = MKCoordinateRegionMakeWithDistance(cord, 2000, 2000);
    
    
    //Параметры кнопки buttomZoomIn-------------------------------------------------
    self.buttonZoomInMapViewDetailMyOrders.backgroundColor = [UIColor clearColor];
    self.buttonZoomInMapViewDetailMyOrders.layer.borderColor = [UIColor blackColor].CGColor;
    self.buttonZoomInMapViewDetailMyOrders.layer.borderWidth = 2.f;
    self.buttonZoomInMapViewDetailMyOrders.layer.cornerRadius = 15.f;
    self.buttonZoomInMapViewDetailMyOrders.alpha = 7.f;
    [self.buttonZoomInMapViewDetailMyOrders addTarget:self
                          action:@selector(actionButtomZoomIn)
                forControlEvents:UIControlEventTouchUpInside];
    
    //Параметры кнопки buttomZoomOut-------------------------------------------------
    self.buttonZoomOutMapViewDetailMyOrders.backgroundColor = [UIColor clearColor];
    self.buttonZoomOutMapViewDetailMyOrders.layer.borderColor = [UIColor blackColor].CGColor;
    self.buttonZoomOutMapViewDetailMyOrders.layer.borderWidth = 2.f;
    self.buttonZoomOutMapViewDetailMyOrders.layer.cornerRadius = 15.f;
    self.buttonZoomOutMapViewDetailMyOrders.alpha = 7.f;
    [self.buttonZoomOutMapViewDetailMyOrders addTarget:self
                           action:@selector(actionButtomZoomOut)
                 forControlEvents:UIControlEventTouchUpInside];
    
    //Параметры основного view------------------------------------------------------
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    //Параметры topBarMapViewOrder--------------------------------------------------
    self.topBarMapViewDetailMyOrders.backgroundColor = [UIColor whiteColor];
    self.topBarMapViewDetailMyOrders.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.topBarMapViewDetailMyOrders.layer.borderWidth = 1.f;
    
    //Параметры buttonBackMapViewOrder----------------------------------------------
    self.buttonBackMapViewDetailMyOrders.backgroundColor = [UIColor clearColor];
    [self.buttonBackMapViewDetailMyOrders addTarget:self action:@selector(actionButtonBackMapViewOrder)
                                               forControlEvents:UIControlEventTouchUpInside];
    
    //Параметры нкопки buttonSettingMapViewOrder------------------------------------
    self.buttonSettingMapViewDetailMyOrders.backgroundColor = [UIColor clearColor];
    [self.buttonSettingMapViewDetailMyOrders addTarget:self
                                       action:@selector(actionButtonSettingMapViewOrder)
                             forControlEvents:UIControlEventTouchUpInside];
    
    //Моё местоположение------------------------------------------------------------
    self.locationManager = [[CLLocationManager alloc] init];
    [self.locationManager requestAlwaysAuthorization];
    
    [self.locationManager startUpdatingLocation];
    self.locationManager.delegate = self;
    
    self.mapViewDetailMyOrders.userLocation.title = @"Ваше местоположение";
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void) actionButtonAssigned
{
    
    SCLAlertView* alertView = [[SCLAlertView alloc] init];
    
    //Using Selector
    [alertView addButton:@"Подтвердить" target:self selector:@selector(alertButtonYes)];
    [alertView addButton:@"Отмена" target:self selector:@selector(alertButtonNo)];
    
    [alertView showNotice:self title:@"Внимание!!" subTitle:@"Вы уверенны что вы хотите взять этот заказ?" closeButtonTitle:nil duration:0.0f];
}

//Подтвержение заказа---------------------------------------------------------------------------
- (void)alertButtonYes
{
    //Тут метод Кирилла, по подверждению
}
//Отмена заказа---------------------------------------------------------------------------------
- (void)alertButtonNo
{
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:2] animated:YES];
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
    
    MKCoordinateRegion region = self.mapViewDetailMyOrders.region;
    region.span.latitudeDelta /= 5.0;
    region.span.longitudeDelta /= 5.0;
    [self.mapViewDetailMyOrders setRegion:region animated:YES];
}

//Действие кнопки buttomZoomOut----------------------------------------------------
- (void)actionButtomZoomOut
{
    MKCoordinateRegion region = self.mapViewDetailMyOrders.region;
    region.span.latitudeDelta = MIN(region.span.latitudeDelta * 5.0, 180.0);
    region.span.longitudeDelta = MIN(region.span.longitudeDelta * 5.0, 180.0);
    [self.mapViewDetailMyOrders setRegion:region animated:YES];
}

#pragma mark - MapKit

- (MKMapRect)makeMapRectWithAnnotations:(NSArray *)annotations {
    
    MKMapRect flyTo = MKMapRectNull;
    for (id <MKAnnotation> annotation in annotations) {
        MKMapPoint annotationPoint = MKMapPointForCoordinate(annotation.coordinate);
        MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0, 0);
        if (MKMapRectIsNull(flyTo)) {
            flyTo = pointRect;
        } else {
            flyTo = MKMapRectUnion(flyTo, pointRect);
        }
    }
    
    return flyTo;
    
}


- (MKAnnotationView *)mapView:(MKMapView *)mV viewForAnnotation:(id <MKAnnotation>)annotation {
    
    // Don't mess with user location
    
    if(![annotation isKindOfClass:[ZSAnnotation class]])
        
        return nil;
    
    ZSAnnotation *a = (ZSAnnotation *)annotation;
    static NSString *defaultPinID = @"StandardIdentifier";
    
    // Create the ZSPinAnnotation object and reuse it
    ZSPinAnnotation *pinView = (ZSPinAnnotation *)[self.mapViewDetailMyOrders dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
    if (pinView == nil){
        pinView = [[ZSPinAnnotation alloc] initWithAnnotation:annotation reuseIdentifier:defaultPinID];
    }
    
    // Set the type of pin to draw and the color
    pinView.annotationType = ZSPinAnnotationTypeTagStroke;
    pinView.annotationColor = a.color;
    pinView.canShowCallout = YES;
    
    return pinView;
    
}

@end
