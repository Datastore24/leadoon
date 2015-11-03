//
//  MapViewMyOrders.h
//  Leadoon
//
//  Created by Viktor on 03.11.15.
//  Copyright © 2015 Viktor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapViewMyOrders : UIViewController

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) CLLocationManager * locationManager;
@property (nonatomic,strong) CLLocation * currentLocathion;
@property (strong, nonatomic) NSMutableArray * arrayOrders; //Массив с заказами

@end
