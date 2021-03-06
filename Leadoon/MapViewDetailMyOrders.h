//
//  MapViewDetailMyOrders.h
//  Leadoon
//
//  Created by Viktor on 21.10.15.
//  Copyright © 2015 Viktor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>


@interface MapViewDetailMyOrders : UIViewController

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) CLLocationManager * locationManager;
@property (nonatomic,strong) CLLocation * currentLocathion;

@property (strong, nonatomic) NSArray * parseItems; //Массив с заказами
@property (strong,nonatomic) NSString * orderID;

@end
