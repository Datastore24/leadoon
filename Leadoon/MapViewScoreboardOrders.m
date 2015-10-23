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
#import <GoogleMaps/GoogleMaps.h>

@interface MapViewScoreboardOrders ()

@property (weak, nonatomic) IBOutlet UIView* topBarMapViewScoreboardOrders; //Верхний Бар
@property (weak, nonatomic) IBOutlet UIButton* buttonBackMapViewScoreboardOrders; //Кнопка назад
@property (weak, nonatomic) IBOutlet UIButton* buttonSettingsMapViewScoreboardOrders; //Кнопка настройка
@property (weak, nonatomic) IBOutlet UILabel* labelTopBarMapViewScoreboardOrders; //Строка загаловка
@property (weak, nonatomic) IBOutlet UIButton* buttonZoomInMapViewScoreboardOrders; //Кнопка увелечения
@property (weak, nonatomic) IBOutlet UIButton* buttonZoomOutMapViewScoreboardOrders; //Кнопка уменьшения

@property (strong, nonatomic) NSMutableArray* annotationArray; //Массив Аннотаций
@property (weak, nonatomic) IBOutlet UILabel *labelButtonZoomIn;
@property (weak, nonatomic) IBOutlet UILabel *labelButtomZoomOut;

@property (strong, nonatomic) GMSCameraPosition * camera;

@end

@implementation MapViewScoreboardOrders{
    GMSMapView *mapView_;
}

- (void)viewDidLoad

{
    [super viewDidLoad];

    self.annotationArray = [[NSMutableArray alloc] init];
    
    //Параметры кнопки buttomZoomIn-------------------------------------------------
    self.buttonZoomInMapViewScoreboardOrders.backgroundColor = [UIColor clearColor];
    self.buttonZoomInMapViewScoreboardOrders.layer.borderColor = [UIColor blackColor].CGColor;
    self.buttonZoomInMapViewScoreboardOrders.layer.borderWidth = 2.f;
    self.buttonZoomInMapViewScoreboardOrders.layer.cornerRadius = 15.f;
    self.buttonZoomInMapViewScoreboardOrders.alpha = 7.f;

    
    //Параметры кнопки buttomZoomOut-------------------------------------------------
    self.buttonZoomOutMapViewScoreboardOrders.backgroundColor = [UIColor clearColor];
    self.buttonZoomOutMapViewScoreboardOrders.layer.borderColor = [UIColor blackColor].CGColor;
    self.buttonZoomOutMapViewScoreboardOrders.layer.borderWidth = 2.f;
    self.buttonZoomOutMapViewScoreboardOrders.layer.cornerRadius = 15.f;
    self.buttonZoomOutMapViewScoreboardOrders.alpha = 7.f;


    //Тестовые данные---------------------------------------------------------------------------

    NSDictionary* arrayMapPinOne = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithDouble:55.64504907040862], @"lat", [NSNumber numberWithDouble:37.5347900390625], @"lon", @"Забор", @"type", @"15-я Василевская", @"title", @"Василенская", @"subTitle", nil];

    NSDictionary* arrayMapPinTwo = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithDouble:55.67448697232047], @"lat", [NSNumber numberWithDouble:37.2491455078125], @"lon", @"Заказ", @"type", @"Мартынская 40", @"title", @"Щелковская", @"subTitle", nil];

    NSDictionary* arrayMapPinThree = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithDouble:55.750303644490394], @"lat", [NSNumber numberWithDouble:37.7764892578125], @"lon", @"Закупка", @"type", @"Чукотская 28", @"title", @"Григорьевская", @"subTitle", nil];

    NSDictionary* arrayMapPinFore = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithDouble:55.80128097118045], @"lat", [NSNumber numberWithDouble:37.452392578125], @"lon", @"Забор", @"type", @"Рубинова 67", @"title", @"Дубровская", @"subTitle", nil];

    NSDictionary* arrayMapPinFive = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithDouble:55.60472974085067], @"lat", [NSNumber numberWithDouble:37.63916015625], @"lon", @"Закупка", @"type", @"Арбаткая 87", @"title", @"Арбатская", @"subTitle", nil];

    self.annotationArray = [NSMutableArray arrayWithObjects:arrayMapPinOne, arrayMapPinTwo, arrayMapPinThree, arrayMapPinFore, arrayMapPinFive, nil];

    //-----------------------------------------------------------------------------------------
    //Рабочий парсинг--------------------------------------------------------------------------
    
    self.camera = [GMSCameraPosition cameraWithLatitude:-33.86
                                                            longitude:151.20
                                                                 zoom:5];
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:self.camera];
    mapView_.myLocationEnabled = YES;
    self.view = mapView_;
    
    // Creates a marker in the center of the map.
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(-33.86, 151.20);
    marker.title = @"Sydney";
    marker.snippet = @"Australia";
    marker.map = mapView_;
    
    [mapView_ addSubview:self.buttonZoomInMapViewScoreboardOrders];
    [mapView_ addSubview:self.buttonZoomOutMapViewScoreboardOrders];
    [mapView_ addSubview:self.labelButtomZoomOut];
    [mapView_ addSubview:self.labelButtonZoomIn];



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





@end
