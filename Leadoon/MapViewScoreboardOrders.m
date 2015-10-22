//
//  MapViewScoreboardOrders.m
//  Leadoon
//
//  Created by Viktor on 22.10.15.
//  Copyright © 2015 Viktor. All rights reserved.
//

#import "MapViewScoreboardOrders.h"
#import "SettingsView.h"
#import <SCLAlertView-Objective-C/SCLAlertView.h>

@interface MapViewScoreboardOrders () <CLLocationManagerDelegate, MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet UIView* topBarMapViewScoreboardOrders; //Верхний Бар
@property (weak, nonatomic) IBOutlet UIButton* buttonBackMapViewScoreboardOrders; //Кнопка назад
@property (weak, nonatomic) IBOutlet UIButton* buttonSettingsMapViewScoreboardOrders; //Кнопка настройка
@property (weak, nonatomic) IBOutlet UILabel* labelTopBarMapViewScoreboardOrders; //Строка загаловка
@property (weak, nonatomic) IBOutlet UIButton* buttonZoomInMapViewScoreboardOrders; //Кнопка увелечения
@property (weak, nonatomic) IBOutlet UIButton* buttonZoomOutMapViewScoreboardOrders; //Кнопка уменьшения

@property (strong, nonatomic) NSMutableArray* annotationArray; //Массив Аннотаций

@end

@implementation MapViewScoreboardOrders

- (void)viewDidLoad

{
    [super viewDidLoad];

    self.annotationArray = [[NSMutableArray alloc] init];

    //Тестовые данные---------------------------------------------------------------------------

    NSDictionary* arrayMapPinOne = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithDouble:55.64504907040862], @"lat", [NSNumber numberWithDouble:37.5347900390625], @"lon", @"Забор", @"type", @"15-я Василевская", @"title", @"Василенская", @"subTitle", nil];

    NSDictionary* arrayMapPinTwo = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithDouble:55.67448697232047], @"lat", [NSNumber numberWithDouble:37.2491455078125], @"lon", @"Заказ", @"type", @"Мартынская 40", @"title", @"Щелковская", @"subTitle", nil];

    NSDictionary* arrayMapPinThree = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithDouble:55.750303644490394], @"lat", [NSNumber numberWithDouble:37.7764892578125], @"lon", @"Закупка", @"type", @"Чукотская 28", @"title", @"Григорьевская", @"subTitle", nil];

    NSDictionary* arrayMapPinFore = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithDouble:55.80128097118045], @"lat", [NSNumber numberWithDouble:37.452392578125], @"lon", @"Забор", @"type", @"Рубинова 67", @"title", @"Дубровская", @"subTitle", nil];

    NSDictionary* arrayMapPinFive = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithDouble:55.60472974085067], @"lat", [NSNumber numberWithDouble:37.63916015625], @"lon", @"Закупка", @"type", @"Арбаткая 87", @"title", @"Арбатская", @"subTitle", nil];

    self.annotationArray = [NSMutableArray arrayWithObjects:arrayMapPinOne, arrayMapPinTwo, arrayMapPinThree, arrayMapPinFore, arrayMapPinFive, nil];

    //-----------------------------------------------------------------------------------------
    //Рабочий парсинг--------------------------------------------------------------------------

    ZSAnnotation* annotation = nil;

    NSString* typeOne = @"Заказ";
    NSString* typeTwo = @"Забор";
    NSString* typeThree = @"Закупка";

    for (int i = 0; i < self.annotationArray.count; i++) {
        NSDictionary* dict = [self.annotationArray objectAtIndex:i];

        annotation = [[ZSAnnotation alloc] init];
        annotation.coordinate = CLLocationCoordinate2DMake([[dict objectForKey:@"lat"] floatValue], [[dict objectForKey:@"lon"] floatValue]);
        if ([dict objectForKey:@"type"] == typeOne) {
            annotation.color = [UIColor blueColor];
        }
        else if ([dict objectForKey:@"type"] == typeTwo) {
            annotation.color = [UIColor greenColor];
        }
        else if ([dict objectForKey:@"type"] == typeThree) {
            annotation.color = [UIColor brownColor];
        }
        annotation.title = [dict objectForKey:@"title"];
        annotation.subtitle = [dict objectForKey:@"subTitle"];
        annotation.type = ZSPinAnnotationTypeDisc;

        [self.mapViewScoreboardOrders addAnnotation:annotation];
    }

    CLLocationCoordinate2D cord;
    cord.latitude = 55.74850322752935;
    cord.longitude = 37.62373962879181;

    self.mapViewScoreboardOrders.region = MKCoordinateRegionMakeWithDistance(cord, 60000, 60000);

    //Параметры кнопки buttomZoomIn-------------------------------------------------
    self.buttonZoomInMapViewScoreboardOrders.backgroundColor = [UIColor clearColor];
    self.buttonZoomInMapViewScoreboardOrders.layer.borderColor = [UIColor blackColor].CGColor;
    self.buttonZoomInMapViewScoreboardOrders.layer.borderWidth = 2.f;
    self.buttonZoomInMapViewScoreboardOrders.layer.cornerRadius = 15.f;
    self.buttonZoomInMapViewScoreboardOrders.alpha = 7.f;
    [self.buttonZoomInMapViewScoreboardOrders addTarget:self
                                                 action:@selector(actionButtomZoomIn)
                                       forControlEvents:UIControlEventTouchUpInside];

    //Параметры кнопки buttomZoomOut-------------------------------------------------
    self.buttonZoomOutMapViewScoreboardOrders.backgroundColor = [UIColor clearColor];
    self.buttonZoomOutMapViewScoreboardOrders.layer.borderColor = [UIColor blackColor].CGColor;
    self.buttonZoomOutMapViewScoreboardOrders.layer.borderWidth = 2.f;
    self.buttonZoomOutMapViewScoreboardOrders.layer.cornerRadius = 15.f;
    self.buttonZoomOutMapViewScoreboardOrders.alpha = 7.f;
    [self.buttonZoomOutMapViewScoreboardOrders addTarget:self
                                                  action:@selector(actionButtomZoomOut)
                                        forControlEvents:UIControlEventTouchUpInside];

    //Параметры основного view------------------------------------------------------
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];

    //Параметры topBarMapViewOrder--------------------------------------------------
    self.topBarMapViewScoreboardOrders.backgroundColor = [UIColor whiteColor];
    self.topBarMapViewScoreboardOrders.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.topBarMapViewScoreboardOrders.layer.borderWidth = 1.f;

    //Параметры buttonBackMapViewOrder----------------------------------------------
    self.buttonBackMapViewScoreboardOrders.backgroundColor = [UIColor clearColor];
    [self.buttonBackMapViewScoreboardOrders addTarget:self
                                               action:@selector(actionButtonBackMapViewOrder)
                                     forControlEvents:UIControlEventTouchUpInside];

    //Параметры нкопки buttonSettingMapViewOrder------------------------------------
    self.buttonSettingsMapViewScoreboardOrders.backgroundColor = [UIColor clearColor];
    [self.buttonSettingsMapViewScoreboardOrders addTarget:self
                                                   action:@selector(actionButtonSettingMapViewOrder)
                                         forControlEvents:UIControlEventTouchUpInside];

    //Моё местоположение------------------------------------------------------------
    self.locationManager = [[CLLocationManager alloc] init];
    [self.locationManager requestAlwaysAuthorization];

    [self.locationManager startUpdatingLocation];
    self.locationManager.delegate = self;

    self.mapViewScoreboardOrders.userLocation.title = @"Ваше местоположение";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)actionButtonAssigned
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

    MKCoordinateRegion region = self.mapViewScoreboardOrders.region;
    region.span.latitudeDelta /= 5.0;
    region.span.longitudeDelta /= 5.0;
    [self.mapViewScoreboardOrders setRegion:region animated:YES];
}

//Действие кнопки buttomZoomOut----------------------------------------------------
- (void)actionButtomZoomOut
{
    MKCoordinateRegion region = self.mapViewScoreboardOrders.region;
    region.span.latitudeDelta = MIN(region.span.latitudeDelta * 5.0, 180.0);
    region.span.longitudeDelta = MIN(region.span.longitudeDelta * 5.0, 180.0);
    [self.mapViewScoreboardOrders setRegion:region animated:YES];
}

#pragma mark - MapKit

- (MKMapRect)makeMapRectWithAnnotations:(NSArray*)annotations
{

    MKMapRect flyTo = MKMapRectNull;
    for (id<MKAnnotation> annotation in annotations) {
        MKMapPoint annotationPoint = MKMapPointForCoordinate(annotation.coordinate);
        MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0, 0);
        if (MKMapRectIsNull(flyTo)) {
            flyTo = pointRect;
        }
        else {
            flyTo = MKMapRectUnion(flyTo, pointRect);
        }
    }

    return flyTo;
}

- (MKAnnotationView*)mapView:(MKMapView*)mV viewForAnnotation:(id<MKAnnotation>)annotation
{

    // Don't mess with user location

    if (![annotation isKindOfClass:[ZSAnnotation class]])

        return nil;

    ZSAnnotation* a = (ZSAnnotation*)annotation;
    static NSString* defaultPinID = @"StandardIdentifier";

    // Create the ZSPinAnnotation object and reuse it
    ZSPinAnnotation* pinView = (ZSPinAnnotation*)[self.mapViewScoreboardOrders dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
    if (pinView == nil) {
        pinView = [[ZSPinAnnotation alloc] initWithAnnotation:annotation reuseIdentifier:defaultPinID];
    }

    // Set the type of pin to draw and the color
    pinView.annotationType = ZSPinAnnotationTypeTagStroke;
    pinView.annotationColor = a.color;
    pinView.canShowCallout = YES;

    return pinView;
}

@end
