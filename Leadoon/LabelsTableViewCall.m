//
//  LabelsTableViewCall.m
//  Leadoon
//
//  Created by Viktor on 15.10.15.
//  Copyright © 2015 Viktor. All rights reserved.
//

#import "LabelsTableViewCall.h"
#import "UIColor+HexColor.h"

@interface LabelsTableViewCall ()

@property (strong, nonatomic) UILabel* typeLabel;

@end

@implementation LabelsTableViewCall

//Тип заказа----------------------------------------------------
- (UILabel*)labelTypeTableViewCell:(NSString*)latebType
{

    self.typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.f, 10.f, 100.f, 20.f)];
    self.typeLabel.text = latebType;
    self.typeLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:20];

    NSString* blueString = @"Заказ";
    NSString* greenString = @"Забор";
    NSString* brownString = @"Закупка";

    if (self.typeLabel.text == blueString) {

        self.typeLabel.textColor = [UIColor colorWithHexString:@"0e59db"];
    }

    else if (self.typeLabel.text == greenString) {

        self.typeLabel.textColor = [UIColor colorWithHexString:@"2c6530"];
    }

    else if (self.typeLabel.text == brownString) {

        self.typeLabel.textColor = [UIColor colorWithHexString:@"cc8023"];
    }

    else {
        self.typeLabel.textColor = [UIColor blackColor];
    }

    return self.typeLabel;
}

//Картинка типа lableTableViewCell-------------------------------------------

- (UIImageView*)imageViewTypeTableView: (NSString *) order_type
{
   

    NSString* nameImage;

    if ([order_type isEqual:@"2"]) {

        nameImage = @"imageMetro1.png";
    }

    else {
        nameImage = @"imageMetro2.png";
    }

    UIImage* image = [UIImage imageNamed:nameImage];

    UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 55, 20, 20)];
    imageView.image = image;

    return imageView;
}

//Цвет ветки метро-------------------------------------------------
- (UIView*) roundMetroView:(NSString *) lineID{
    NSString * stationColor;
    switch ([lineID integerValue]) {
        case 1:
            stationColor = @"ff0000";
            break;
        case 2:
            stationColor = @"007d35";
            break;
        case 3:
            stationColor = @"00278d";
            break;
        case 4:
            stationColor = @"008ec2";
            break;
        case 5:
            stationColor = @"643500";
            break;
        case 6:
            stationColor = @"ff9a00";
            break;
        case 7:
            stationColor = @"cb0181";
            break;
        case 8:
            stationColor = @"ffda00";
            break;
        case 9:
            stationColor = @"9f9f9f";
            break;
        case 10:
            stationColor = @"8fd600";
            break;
        case 11:
            stationColor = @"007f9a";
            break;
        case 12:
            stationColor = @"76daea";
            break;
            
        default:
            break;
    }
    UIView * roundMetro = [[UIView alloc] initWithFrame:CGRectMake(35, 57, 15, 15)];
    roundMetro.backgroundColor = [UIColor colorWithHexString:stationColor];
    roundMetro.layer.borderColor = [UIColor blackColor].CGColor;
    roundMetro.layer.borderWidth = 2;
    roundMetro.layer.cornerRadius = 7.5f;
    
    return roundMetro;
}

//Имя станции метро--------------------------------------
- (UILabel*)labelMetroStationName:(NSString*)stationID
{
    NSString * stationName;
    
    switch ([stationID integerValue])
    {
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
            NSLog (@"Integer out of range");
            break;
    }


    UILabel* labelMetro = [[UILabel alloc] initWithFrame:CGRectMake(55, 55, 100, 20)];

    labelMetro.text = stationName;

    labelMetro.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
    

    return labelMetro;
}

//Изображение тележки---------------------------------------------
- (UIImageView*)imageViewBasketTableView
{

    NSString* imageName = @"basket.png";
    UIImage* imageBusket = [UIImage imageNamed:imageName];

    UIImageView* imageViewBusket = [[UIImageView alloc] initWithFrame:CGRectMake(150, 55, 20, 20)];
    imageViewBusket.image = imageBusket;

    return imageViewBusket;
}

//Вес, кол-во заказов---------------------------------------------
- (UILabel*)weightAndNumberOfOrders:(NSString*)stringOrders
{
    UILabel* labelWeightAndNumbers = [[UILabel alloc] initWithFrame:CGRectMake(175, 55, 80, 20)];
    labelWeightAndNumbers.text = stringOrders;
    labelWeightAndNumbers.font = [UIFont fontWithName:@"HelveticaNeue" size:12];

    return labelWeightAndNumbers;
}

//Дней осталось---------------------------------------------------
- (UILabel*)labelDaysLeft:(NSString*)stringDays
{
    UILabel* labelDays = [[UILabel alloc] initWithFrame:CGRectMake(130, 5, 100, 15)];
    labelDays.text = stringDays;
    labelDays.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    labelDays.textColor = [UIColor colorWithHexString:@"5b038d"];

    return labelDays;
}

//Временной интервал-----------------------------------------------
- (UILabel*)labelTimeInterval:(NSString*)strigInterval
{
    UILabel* labelTimeInterval = [[UILabel alloc] initWithFrame:CGRectMake(208, 5, 100, 15)];
    labelTimeInterval.text = strigInterval;
    labelTimeInterval.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    labelTimeInterval.textColor = [UIColor colorWithHexString:@"5b038d"];

    return labelTimeInterval;
}

//Осталось не изменяемый label-------------------------------------
- (UILabel*)labelLineLeft
{
    UILabel* labelLine = [[UILabel alloc] initWithFrame:CGRectMake(130, 30, 60, 12)];
    labelLine.text = @"Осталось:";
    labelLine.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
    labelLine.alpha = 0.5f;

    return labelLine;
}

//Оставшееся время выполнения заказа--------------------------------
- (UILabel*)labelTimeRemaining:(NSString*)remainingString
{
    UILabel* labelTime = [[UILabel alloc] initWithFrame:CGRectMake(190, 30, 100, 12)];
    labelTime.text = remainingString;
    labelTime.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
    labelTime.alpha = 0.5f;

    return labelTime;
}

//Формирование заказа----------------------------------------------
- (UILabel*)labelFormation:(NSString*)stringFormation
{
    
    UILabel* labelWithFormation = [[UILabel alloc] initWithFrame:CGRectMake(10, 35, 120, 14)];
    labelWithFormation.text = stringFormation;
    labelWithFormation.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
    labelWithFormation.textColor = [UIColor colorWithHexString:@"2c6530"];

    return labelWithFormation;
}

//Дата выполнения заказа----------------------------------------------
- (UILabel*)labelDataFinish:(NSString*)stringFinish
{
    
    UILabel* labelDataFinish = [[UILabel alloc] initWithFrame:CGRectMake(10, 35, 120, 14)];
    labelDataFinish.text = stringFinish;
    labelDataFinish.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
    labelDataFinish.alpha = 0.5f;
    
    return labelDataFinish;
}

//Тип оплаты----------------------------------------------------------
- (UILabel*)labelPaymentType:(NSString*)stringPaymentType
{
    UILabel* labelPaymentType = [[UILabel alloc] initWithFrame:CGRectMake(110, 5, 100, 15)];
    labelPaymentType.text = stringPaymentType;
    labelPaymentType.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    labelPaymentType.textColor = [UIColor colorWithHexString:@"5b038d"];
    labelPaymentType.textAlignment = UITextAlignmentRight;
    
    return labelPaymentType;
}

//Сумма---------------------------------------------------------------
- (UILabel*)labelSum:(NSString*)strigSum
{
    UILabel* labelSum = [[UILabel alloc] initWithFrame:CGRectMake(220, 5, 100, 15)];
    labelSum.text = strigSum;
    labelSum.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    labelSum.textColor = [UIColor colorWithHexString:@"5b038d"];
    
    return labelSum;
}

//Заработок не изменяемый label-------------------------------------
- (UILabel*)labelEarnings
{
    UILabel* labelEarnings = [[UILabel alloc] initWithFrame:CGRectMake(110, 35, 80, 12)];
    labelEarnings.text = @"Заработок:";
    labelEarnings.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
    labelEarnings.alpha = 0.5f;
    
    return labelEarnings;
}

//Сумма заработка--------------------------------------------------
- (UILabel*)labelEarningsSum:(NSString*)earningsSumString
{
    UILabel* labelEarningsSum = [[UILabel alloc] initWithFrame:CGRectMake(190, 35, 100, 12)];
    labelEarningsSum.text = earningsSumString;
    labelEarningsSum.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
    labelEarningsSum.alpha = 0.5f;
    
    return labelEarningsSum;
}

@end
