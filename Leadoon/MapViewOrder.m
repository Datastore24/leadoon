//
//  MapViewOrder.m
//  Leadoon
//
//  Created by Viktor on 17.10.15.
//  Copyright © 2015 Viktor. All rights reserved.
//

#import "MapViewOrder.h"
#import "SettingsView.h"
#import <SCLAlertView-Objective-C/SCLAlertView.h>

@interface MapViewOrder () <CLLocationManagerDelegate, MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet UIView* topBarMapViewOrder; //Верхний бар основного меню
@property (weak, nonatomic) IBOutlet UIButton* buttonBackMapViewOrder; //Кнопка возврата
@property (weak, nonatomic) IBOutlet UIButton* buttonSettingMapViewOrder; //Кнопка Настроек
@property (weak, nonatomic) IBOutlet UIButton* buttomZoomIn; //Кнопка увеличения
@property (weak, nonatomic) IBOutlet UIButton* ButtonZoomOut; //Кнопка уменьшения
@property (weak, nonatomic) IBOutlet UIButton *buttonAssigned; //Кнопка присвоить

@property (strong, nonatomic) NSMutableArray *annotationArray;

@end

@implementation MapViewOrder

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.annotationArray = [[NSMutableArray alloc] init];
    
    ZSAnnotation *annotation = nil;
    
    annotation = [[ZSAnnotation alloc] init];
    annotation.coordinate = CLLocationCoordinate2DMake(55.73850322752935, 37.59373962879181);
    annotation.color = [UIColor blueColor];
    annotation.title = @"13-я парковая 40";
    annotation.subtitle = @"Щелковская";
    annotation.type = ZSPinAnnotationTypeDisc;
    [self.annotationArray addObject:annotation];
    
    [self.mapView addAnnotations:self.annotationArray];
    
    CLLocationCoordinate2D cord;
    cord.latitude = 55.73850322752935;
    cord.longitude = 37.59373962879181;
    
    self.mapView.region = MKCoordinateRegionMakeWithDistance(cord, 2000, 2000);
    

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
    
    //Параметры кнопки buttonAssigned-----------------------------------------------
    self.buttonAssigned.backgroundColor = [UIColor whiteColor];
    self.buttonAssigned.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.buttonAssigned.layer.borderWidth = 1.f;
    self.buttonAssigned.layer.cornerRadius = 9.f;
    [self.buttonAssigned addTarget:self action:@selector(actionButtonAssigned)
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

//- (void) addPinsonArray: (NSMutableArray *) array
//{
//    
//}

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
    ZSPinAnnotation *pinView = (ZSPinAnnotation *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
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
