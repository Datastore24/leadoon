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
#import "ParserOrder.h"
#import "AnnotationMap.h"
#import "UIView+MKAnnotationView.h"

@interface MapViewDetailMyOrders () <CLLocationManagerDelegate, MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *topBarMapViewDetailMyOrders; //Верхний бар
@property (weak, nonatomic) IBOutlet UIButton *buttonBackMapViewDetailMyOrders; //Кнопка возврата
@property (weak, nonatomic) IBOutlet UIButton *buttonSettingMapViewDetailMyOrders; //Кнопка настроек
@property (weak, nonatomic) IBOutlet UILabel *labelTopBarMapViewDetailMyOrders; //Заголовок
@property (weak, nonatomic) IBOutlet UIButton *buttonZoomInMapViewDetailMyOrders; //Кнопка приближения карты
@property (weak, nonatomic) IBOutlet UIButton *buttonZoomOutMapViewDetailMyOrders; //Кнопка удаления карты
@property (weak, nonatomic) IBOutlet UIButton *buttonСancell; //Кнопка отмена

@property (strong, nonatomic) MKDirections* direction;


@end

@implementation MapViewDetailMyOrders

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    ParserOrder * parser = [self.parseItems objectAtIndex:0];
    
        NSLog(@"orderLat %@", parser.orderLat);
        NSLog(@"orderLong %@", parser.orderLong);
        NSLog(@"address %@", parser.address);
        NSLog(@"metro_id %@", parser.metro_id);
        NSLog(@"getting_type %@", parser.getting_type);
    
    AnnotationMap* annotation = [[AnnotationMap alloc] init];
    
    CGFloat lat = [parser.orderLat floatValue];
    CGFloat lon = [parser.orderLong floatValue];
    
    CLLocationCoordinate2D coord;
    coord.latitude = lat;
    coord.longitude = lon;
    
    annotation.coordinate = coord;
    annotation.title = parser.address;
    annotation.subtitle = [self metroStationNameByID:parser.metro_id];
    annotation.type = parser.getting_type;
    
    [self.mapView addAnnotation:annotation];
    
    
    
    CLLocationCoordinate2D cord;
    cord.latitude = [parser.orderLat floatValue];
    cord.longitude = [parser.orderLong floatValue];
    
    self.mapView.region = MKCoordinateRegionMakeWithDistance(cord, 2000, 2000);
    
    
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
    
    //Параметры кнопки buttonAssigned-----------------------------------------------
    self.buttonСancell.backgroundColor = [UIColor whiteColor];
    self.buttonСancell.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.buttonСancell.layer.borderWidth = 1.f;
    self.buttonСancell.layer.cornerRadius = 9.f;
    [self.buttonСancell addTarget:self action:@selector(actionButtonAssigned)
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
    
    self.mapView.userLocation.title = @"Ваше местоположение";
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    if ([self.direction isCalculating]) {
        [self.direction cancel];
    }
}

- (void) actionButtonAssigned
{
    
    SCLAlertView* alertView = [[SCLAlertView alloc] init];
    
    //Using Selector
    [alertView addButton:@"Подтвердить" target:self selector:@selector(alertButtonYes)];
    [alertView addButton:@"Отмена" target:self selector:@selector(alertButtonNo)];
    
    [alertView showNotice:self title:@"Внимание!!" subTitle:@"Вы уверенны что вы хотите отменить этот заказ?" closeButtonTitle:nil duration:0.0f];
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

- (MKAnnotationView*)mapView:(MKMapView*)mV viewForAnnotation:(id<MKAnnotation>)annotation
{
    if (![annotation isKindOfClass:[MKUserLocation class]]) {
        
        MKPinAnnotationView* annView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"ParkingPin"];
//        //Создание кнопки перехода в  детали------------------------------------------------------
        UIButton* buttonDetailMapAnnotation = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
//        [buttonDetailMapAnnotation addTarget:self action:@selector(actionButtonDetailMapAnnotation:) forControlEvents:UIControlEventTouchUpInside];
        
        //Создание кнопки построение маршрута-----------------------------------------------------
        UIImageView * buttonImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav.png"]];
        buttonImage.frame = buttonDetailMapAnnotation.frame;
        
        
        UIButton *directionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [directionButton addTarget:self
                            action:@selector(actionButtonDirection:)
                  forControlEvents:UIControlEventTouchUpInside];
        [directionButton setTitle:@"Show View" forState:UIControlStateNormal];
        directionButton.frame = buttonDetailMapAnnotation.frame;
        [directionButton addSubview:buttonImage];
        
        AnnotationMap* annotationTest = (AnnotationMap*)annotation;
        if ([annotationTest.type integerValue] == 0) {
            
            UIImageView* imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bluePin.png"]];
            imageView.frame = CGRectMake(-6, -5, 30, 50);
            
            annView.animatesDrop = TRUE;
            annView.canShowCallout = YES;
            annView.calloutOffset = CGPointMake(0, 0);
            [annView addSubview:imageView];
//            annView.rightCalloutAccessoryView = buttonDetailMapAnnotation;
            annView.leftCalloutAccessoryView = directionButton;
            
            return annView;
        }
        
        else if ([annotationTest.type integerValue] == 1) {
            
            UIImageView* imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"brownPin.png"]];
            imageView.frame = CGRectMake(-6, -5, 30, 50);
            
            annView.animatesDrop = TRUE;
            annView.canShowCallout = YES;
            annView.calloutOffset = CGPointMake(0, 0);
            [annView addSubview:imageView];
//            annView.rightCalloutAccessoryView = buttonDetailMapAnnotation;
            annView.leftCalloutAccessoryView = directionButton;
            
            return annView;
        }
        
        else {
            
            UIImageView* imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"greenPin.png"]];
            imageView.frame = CGRectMake(-6, -5, 30, 50);
            
            annView.animatesDrop = TRUE;
            annView.canShowCallout = YES;
            annView.calloutOffset = CGPointMake(0, 0);
            [annView addSubview:imageView];
//            annView.rightCalloutAccessoryView = buttonDetailMapAnnotation;
            annView.leftCalloutAccessoryView = directionButton;
            
            return annView;
        }
    }
    
    else {
        return nil;
    }
}

- (MKOverlayRenderer*)mapView:(MKMapView*)mapView rendererForOverlay:(id<MKOverlay>)overlay
{
    
    if ([overlay isKindOfClass:[MKPolyline class]]) {
        
        MKPolylineRenderer* renderer = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
        renderer.lineWidth = 4.f;
        renderer.strokeColor = [UIColor lightGrayColor];
        return renderer;
    }
    
    return nil;
}

//Действие кнопки actionButtonDetailMapAnnotation--------
- (void)actionButtonDetailMapAnnotation:(UIButton*)sender
{
    //Выбирем наше вью-----------------------------------------------
    MKAnnotationView* annotationView = [sender superAnnotationView];
    if (!annotationView) {
        
        return;
    }
    
    CLLocationCoordinate2D location = annotationView.annotation.coordinate;
    
    NSLog(@"location.latitude %f, location.longitude %f", location.latitude, location.longitude);
}

//Действие кнопки actionButtonDirection-----------------
- (void)actionButtonDirection:(UIButton*)sender
{
    //Выбирем наше вью-----------------------------------------------
    MKAnnotationView* annotationView = [sender superAnnotationView];
    if (!annotationView) {
        
        return;
    }
    
    if ([self.direction isCalculating]) {
        [self.direction cancel];
    }
    
    CLLocationCoordinate2D coordinate = annotationView.annotation.coordinate;
    
    MKDirectionsRequest* request = [[MKDirectionsRequest alloc] init];
    
    request.source = [MKMapItem mapItemForCurrentLocation];
    
    MKPlacemark* placemark = [[MKPlacemark alloc] initWithCoordinate:coordinate addressDictionary:nil];
    
    MKMapItem* destination = [[MKMapItem alloc] initWithPlacemark:placemark];
    
    request.destination = destination;
    
    request.transportType = MKDirectionsTransportTypeAutomobile;
    
    if ([self.direction isCalculating]) {
        [self.direction cancel];
    }
    
    self.direction = [[MKDirections alloc] initWithRequest:request];
    
    [self.direction calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse* _Nullable response, NSError* _Nullable error) {
        
        if (error) {
            NSLog(@"Error");
        }
        
        else if ([response.routes count] == 0) {
            NSLog(@"No routes");
        }
        else {
            [self.mapView removeOverlays:[self.mapView overlays]];
            
            NSMutableArray* array = [NSMutableArray array];
            
            for (MKRoute* route in response.routes) {
                [array addObject:route.polyline];
            }
            
            [self.mapView addOverlays:array level:MKOverlayLevelAboveRoads];
            
            [self.mapView setRegion:MKCoordinateRegionMakeWithDistance(self.mapView.userLocation.coordinate, 4000, 4000) animated:YES];
            
            
            
        }
    }];
    
}


//Имя станции метро--------------------------------------
- (NSString*)metroStationNameByID:(NSString*)stationID
{
    NSString* stationName;
    
    switch ([stationID integerValue]) {
        case 1:
            stationName = @"Авиамоторная";
            break;
        case 2:
            stationName = @"Автозаводская";
            break;
        case 3:
            stationName = @"Академическая";
            break;
        case 4:
            stationName = @"Александровский Сад";
            break;
        case 5:
            stationName = @"Алексеевская";
            break;
        case 6:
            stationName = @"Алтуфьево";
            break;
        case 7:
            stationName = @"Аннино";
            break;
        case 8:
            stationName = @"Арбатская (ар.)";
            break;
        case 9:
            stationName = @"Арбатская (фил.)";
            break;
        case 10:
            stationName = @"Аэропорт";
            break;
        case 11:
            stationName = @"Бабушкинская";
            break;
        case 12:
            stationName = @"Багратионовская";
            break;
        case 13:
            stationName = @"Баррикадная";
            break;
        case 14:
            stationName = @"Бауманская";
            break;
        case 15:
            stationName = @"Беговая";
            break;
        case 16:
            stationName = @"Белорусская";
            break;
        case 17:
            stationName = @"Беляево";
            break;
        case 18:
            stationName = @"Бибирево";
            break;
        case 19:
            stationName = @"Библиотека имени Ленина";
            break;
        case 21:
            stationName = @"Боровицкая";
            break;
        case 22:
            stationName = @"Ботанический Сад";
            break;
        case 23:
            stationName = @"Братиславская";
            break;
        case 24:
            stationName = @"Бульвар Дмитрия Донского";
            break;
        case 25:
            stationName = @"Бунинская аллея";
            break;
        case 26:
            stationName = @"Варшавская";
            break;
        case 27:
            stationName = @"ВДНХ";
            break;
        case 28:
            stationName = @"Владыкино";
            break;
        case 29:
            stationName = @"Водный Стадион";
            break;
        case 30:
            stationName = @"Войковская";
            break;
        case 31:
            stationName = @"Волгоградский Проспект";
            break;
        case 32:
            stationName = @"Волжская";
            break;
        case 33:
            stationName = @"Волоколамская (стр.)";
            break;
        case 34:
            stationName = @"Воробьевы горы";
            break;
        case 35:
            stationName = @"Выхино";
            break;
        case 36:
            stationName = @"Горчакова ул.";
            break;
        case 38:
            stationName = @"Динамо";
            break;
        case 39:
            stationName = @"Дмитровская";
            break;
        case 40:
            stationName = @"Добрынинская";
            break;
        case 41:
            stationName = @"Домодедовская";
            break;
        case 42:
            stationName = @"Дубровка";
            break;
        case 43:
            stationName = @"Измайловская";
            break;
        case 44:
            stationName = @"Калужская";
            break;
        case 45:
            stationName = @"Кантемировская";
            break;
        case 46:
            stationName = @"Каховская";
            break;
        case 47:
            stationName = @"Каширская";
            break;
        case 48:
            stationName = @"Киевская";
            break;
        case 49:
            stationName = @"Китай-Город";
            break;
        case 50:
            stationName = @"Кожуховская";
            break;
        case 51:
            stationName = @"Коломенская";
            break;
        case 52:
            stationName = @"Комсомольская";
            break;
        case 53:
            stationName = @"Коньково";
            break;
        case 54:
            stationName = @"Красногвардейская";
            break;
        case 55:
            stationName = @"Краснопресненская";
            break;
        case 56:
            stationName = @"Красносельская";
            break;
        case 57:
            stationName = @"Красные Ворота";
            break;
        case 58:
            stationName = @"Крестьянская застава";
            break;
        case 59:
            stationName = @"Кропоткинская";
            break;
        case 60:
            stationName = @"Крылатское";
            break;
        case 61:
            stationName = @"Кузнецкий Мост";
            break;
        case 62:
            stationName = @"Кузьминки";
            break;
        case 63:
            stationName = @"Кунцевская";
            break;
        case 64:
            stationName = @"Курская";
            break;
        case 65:
            stationName = @"Кутузовская";
            break;
        case 66:
            stationName = @"Ленинский Проспект";
            break;
        case 67:
            stationName = @"Лубянка";
            break;
        case 68:
            stationName = @"Люблино";
            break;
        case 69:
            stationName = @"Марксистская";
            break;
        case 70:
            stationName = @"Марьино";
            break;
        case 71:
            stationName = @"Маяковская";
            break;
        case 72:
            stationName = @"Медведково";
            break;
        case 73:
            stationName = @"Международная";
            break;
        case 74:
            stationName = @"Менделеевская";
            break;
        case 75:
            stationName = @"Митино (стр.)";
            break;
        case 76:
            stationName = @"Молодежная";
            break;
        case 77:
            stationName = @"Нагатинская";
            break;
        case 78:
            stationName = @"Нагорная";
            break;
        case 79:
            stationName = @"Нахимовский Проспект";
            break;
        case 80:
            stationName = @"Новогиреево";
            break;
        case 81:
            stationName = @"Новокузнецкая";
            break;
        case 82:
            stationName = @"Новослободская";
            break;
        case 83:
            stationName = @"Новые Черёмушки";
            break;
        case 84:
            stationName = @"Октябрьская";
            break;
        case 85:
            stationName = @"Октябрьское Поле";
            break;
        case 86:
            stationName = @"Орехово";
            break;
        case 87:
            stationName = @"Отрадное";
            break;
        case 88:
            stationName = @"Охотный Ряд";
            break;
        case 89:
            stationName = @"Павелецкая";
            break;
        case 90:
            stationName = @"Парк Культуры";
            break;
        case 91:
            stationName = @"Парк Победы";
            break;
        case 92:
            stationName = @"Партизанская";
            break;
        case 93:
            stationName = @"Первомайская";
            break;
        case 94:
            stationName = @"Перово";
            break;
        case 95:
            stationName = @"Петровско-Разумовская";
            break;
        case 96:
            stationName = @"Печатники";
            break;
        case 97:
            stationName = @"Пионерская";
            break;
        case 98:
            stationName = @"Планерная";
            break;
        case 99:
            stationName = @"Площадь Ильича";
            break;
        case 100:
            stationName = @"Площадь Революции";
            break;
        case 101:
            stationName = @"Полежаевская";
            break;
        case 102:
            stationName = @"Полянка";
            break;
        case 103:
            stationName = @"Пражская";
            break;
        case 104:
            stationName = @"Преображенская Площадь";
            break;
        case 105:
            stationName = @"Пролетарская";
            break;
        case 106:
            stationName = @"Проспект Вернадского";
            break;
        case 107:
            stationName = @"Проспект Мира";
            break;
        case 108:
            stationName = @"Профсоюзная";
            break;
        case 109:
            stationName = @"Пушкинская";
            break;
        case 110:
            stationName = @"Речной Вокзал";
            break;
        case 111:
            stationName = @"Рижская";
            break;
        case 112:
            stationName = @"Римская";
            break;
        case 113:
            stationName = @"Рязанский Проспект";
            break;
        case 114:
            stationName = @"Савеловская";
            break;
        case 115:
            stationName = @"Свиблово";
            break;
        case 116:
            stationName = @"Севастопольская";
            break;
        case 117:
            stationName = @"Семеновская";
            break;
        case 118:
            stationName = @"Серпуховская";
            break;
        case 119:
            stationName = @"Скобелевская";
            break;
        case 120:
            stationName = @"Смоленская (ар.)";
            break;
        case 121:
            stationName = @"Смоленская (фил.)";
            break;
        case 122:
            stationName = @"Сокол";
            break;
        case 123:
            stationName = @"Сокольники";
            break;
        case 124:
            stationName = @"Спортивная";
            break;
        case 125:
            stationName = @"Старокачаловская";
            break;
        case 126:
            stationName = @"Строгино (стр.)";
            break;
        case 127:
            stationName = @"Студенческая";
            break;
        case 128:
            stationName = @"Сухаревская";
            break;
        case 129:
            stationName = @"Сходненская";
            break;
        case 130:
            stationName = @"Таганская";
            break;
        case 131:
            stationName = @"Тверская";
            break;
        case 132:
            stationName = @"Театральная";
            break;
        case 133:
            stationName = @"Текстильщики";
            break;
        case 134:
            stationName = @"Теплый Стан";
            break;
        case 135:
            stationName = @"Тимирязевская";
            break;
        case 136:
            stationName = @"Третьяковская";
            break;
        case 137:
            stationName = @"Тульская";
            break;
        case 138:
            stationName = @"Тургеневская";
            break;
        case 139:
            stationName = @"Тушинская";
            break;
        case 140:
            stationName = @"Улица 1905 года";
            break;
        case 141:
            stationName = @"Улица Академика Янгеля";
            break;
        case 142:
            stationName = @"Улица Подбельского";
            break;
        case 143:
            stationName = @"Университет";
            break;
        case 144:
            stationName = @"Ушакова Адмирала";
            break;
        case 145:
            stationName = @"Филевский Парк";
            break;
        case 146:
            stationName = @"Фили";
            break;
        case 147:
            stationName = @"Фрунзенская";
            break;
        case 148:
            stationName = @"Царицыно";
            break;
        case 149:
            stationName = @"Цветной Бульвар";
            break;
        case 150:
            stationName = @"Черкизовская";
            break;
        case 151:
            stationName = @"Чертановская";
            break;
        case 152:
            stationName = @"Чеховская";
            break;
        case 153:
            stationName = @"Чистые Пруды";
            break;
        case 154:
            stationName = @"Чкаловская";
            break;
        case 155:
            stationName = @"Шаболовская";
            break;
        case 156:
            stationName = @"Шоссе Энтузиастов";
            break;
        case 157:
            stationName = @"Щелковская";
            break;
        case 158:
            stationName = @"Щукинская";
            break;
        case 159:
            stationName = @"Электрозаводская";
            break;
        case 160:
            stationName = @"Юго-Западная";
            break;
        case 161:
            stationName = @"Южная";
            break;
        case 162:
            stationName = @"Ясенево";
            break;
        case 225:
            stationName = @"Трубная";
            break;
        case 226:
            stationName = @"Ховрино";
            break;
        case 227:
            stationName = @"Беломорская ";
            break;
        case 228:
            stationName = @"Алма-Атинская";
            break;
        case 229:
            stationName = @"Славянский бульвар";
            break;
        case 230:
            stationName = @"Мякинино";
            break;
        case 231:
            stationName = @"Пятницкое шоссе";
            break;
        case 232:
            stationName = @"Выставочная";
            break;
        case 233:
            stationName = @"Новоясеневская ";
            break;
        case 234:
            stationName = @"Лермонтовский проспект";
            break;
        case 235:
            stationName = @"Жулебино ";
            break;
        case 236:
            stationName = @"Новокосино";
            break;
        case 237:
            stationName = @"Марьина роща";
            break;
        case 238:
            stationName = @"Достоевская";
            break;
        case 239:
            stationName = @"Сретенский бульвар";
            break;
        case 240:
            stationName = @"Борисово";
            break;
        case 241:
            stationName = @"Шипиловская";
            break;
        case 242:
            stationName = @"Зябликово";
            break;
        default:
            NSLog(@"Integer out of range");
            break;
    }
    
    return stationName;
}

@end
