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

#import "APIClass.h"
#import "APIPostClass.h"
#import "ParserOrders.h"
#import "HeightForText.h"

#import "MyOrdersView.h"
#import "SingleTone.h"
#import "ParserResponseOrders.h"

@interface MapViewScoreboardOrders () <CLLocationManagerDelegate, MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet UIView* topBarMapViewScoreboardOrders; //Верхний Бар
@property (weak, nonatomic) IBOutlet UIButton* buttonBackMapViewScoreboardOrders; //Кнопка назад
@property (weak, nonatomic) IBOutlet UIButton* buttonSettingsMapViewScoreboardOrders; //Кнопка настройка
@property (weak, nonatomic) IBOutlet UILabel* labelTopBarMapViewScoreboardOrders; //Строка загаловка
@property (weak, nonatomic) IBOutlet UIButton* buttonZoomInMapViewScoreboardOrders; //Кнопка увелечения
@property (weak, nonatomic) IBOutlet UIButton* buttonZoomOutMapViewScoreboardOrders; //Кнопка уменьшения

@property (strong, nonatomic) NSMutableArray* annotationArray; //Массив Аннотаций
@property (weak, nonatomic) IBOutlet UILabel* labelButtonZoomIn;
@property (weak, nonatomic) IBOutlet UILabel* labelButtomZoomOut;


@end

@implementation MapViewScoreboardOrders {
}

- (void)viewDidLoad

{
    [super viewDidLoad];
    
    ZSAnnotation* annotation = nil;
    
    for (int i = 0; i < self.arrayOrders.count; i++) {
        ParserOrders * parser = [self.arrayOrders objectAtIndex:i];

         NSLog(@"* * * * * * * * * * * *  * * * * * * * * * * *");
            NSLog(@"getting_type == \"%d\"", [parser.getting_type integerValue]);
//        NSLog(@"metro_id == \"%@\"", parser.metro_id);
//        NSLog(@"metro_line_id == \"%@\"", parser.metro_line_id);
//        NSLog(@"olat == \"%@\"", parser.olat);
//        NSLog(@"olong == \"%@\"", parser.olong);
//        NSLog(@"%@", parser.address);

        
        for (int i = 0; i < self.arrayOrders.count; i++) {

            
            annotation = [[ZSAnnotation alloc] init];
            annotation.type = ZSPinAnnotationTypeDisc;
            if ([parser.getting_type integerValue] == 0) {
                annotation.color = [UIColor blueColor];
            }
            else if ([parser.getting_type integerValue] == 1) {
                annotation.color = [UIColor brownColor];
            }
            else if ([parser.getting_type integerValue] == 2) {
                annotation.color = [UIColor greenColor];
            }
            annotation.coordinate = CLLocationCoordinate2DMake([parser.olat floatValue], [parser.olong floatValue]);
            
            

            
//            annotation.title = parser.address;
//            annotation.subtitle = [self metroStationNameByID:parser.metro_id];
            
            
            [self.mapView addAnnotation:annotation];
        }
       


    }


    CLLocationCoordinate2D cord;
    cord.latitude = 55.73850322752935;
    cord.longitude = 37.59373962879181;

    self.mapView.region = MKCoordinateRegionMakeWithDistance(cord, 50000, 50000);

    //Параметры кнопки buttomZoomIn-------------------------------------------------
    self.buttonZoomInMapViewScoreboardOrders.backgroundColor = [UIColor clearColor];
    self.buttonZoomInMapViewScoreboardOrders.layer.borderColor = [UIColor blackColor].CGColor;
    self.buttonZoomInMapViewScoreboardOrders.layer.borderWidth = 2.f;
    self.buttonZoomInMapViewScoreboardOrders.layer.cornerRadius = 15.f;
    self.buttonZoomInMapViewScoreboardOrders.alpha = 7.f;
    [self.buttonZoomInMapViewScoreboardOrders addTarget:self action:@selector(actionButtomZoomIn) forControlEvents:UIControlEventTouchUpInside];

    //Параметры кнопки buttomZoomOut-------------------------------------------------
    self.buttonZoomOutMapViewScoreboardOrders.backgroundColor = [UIColor clearColor];
    self.buttonZoomOutMapViewScoreboardOrders.layer.borderColor = [UIColor blackColor].CGColor;
    self.buttonZoomOutMapViewScoreboardOrders.layer.borderWidth = 2.f;
    self.buttonZoomOutMapViewScoreboardOrders.layer.cornerRadius = 15.f;
    self.buttonZoomOutMapViewScoreboardOrders.alpha = 7.f;
    [self.buttonZoomOutMapViewScoreboardOrders addTarget:self action:@selector(actionButtomZoomOut) forControlEvents:UIControlEventTouchUpInside];

    //Параметры основного view------------------------------------------------------
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];

    //Параметры topBarMapViewOrder--------------------------------------------------
    self.topBarMapViewScoreboardOrders.backgroundColor = [UIColor whiteColor];
    self.topBarMapViewScoreboardOrders.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.topBarMapViewScoreboardOrders.layer.borderWidth = 1.f;

    //Параметры buttonBackMapViewOrder----------------------------------------------
    self.buttonBackMapViewScoreboardOrders.backgroundColor = [UIColor clearColor];
    [self.buttonBackMapViewScoreboardOrders addTarget:self action:@selector(actionButtonBackMapViewScoreboardOrders) forControlEvents:UIControlEventTouchUpInside];

    //Параметры нкопки buttonSettingMapViewOrder------------------------------------
    self.buttonSettingsMapViewScoreboardOrders.backgroundColor = [UIColor clearColor];
    [self.buttonSettingsMapViewScoreboardOrders addTarget:self
                                                   action:@selector(actionButtonSettingsMapViewScoreboardOrders)
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
- (void)actionButtonBackMapViewScoreboardOrders
{
    [self.navigationController popViewControllerAnimated:YES];
}

//Действие кнопки buttonSettingMapViewOrder-----------------------------------------
- (void)actionButtonSettingsMapViewScoreboardOrders
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
    ZSPinAnnotation* pinView = (ZSPinAnnotation*)[self.mapView dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
    if (pinView == nil) {
        pinView = [[ZSPinAnnotation alloc] initWithAnnotation:annotation reuseIdentifier:defaultPinID];
    }

    // Set the type of pin to draw and the color
    pinView.annotationType = ZSPinAnnotationTypeTagStroke;
    pinView.annotationColor = a.color;
    pinView.canShowCallout = YES;

    return pinView;
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
