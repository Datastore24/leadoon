//
//  MapViewDetailMyOrders.h
//  Leadoon
//
//  Created by Viktor on 21.10.15.
//  Copyright © 2015 Viktor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "MKMapView+ZoomLevel.h"
#import "ZSAnnotation.h"
#import "ZSPinAnnotation.h"


@interface MapViewDetailMyOrders : UIViewController
@property (weak, nonatomic) IBOutlet MKMapView *mapViewDetailMyOrders; //Основная карта
@property (nonatomic, strong) CLLocationManager * locationManager;
@property (nonatomic,strong) CLLocation * currentLocathion;

@end
