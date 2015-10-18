//
//  MapViewOrder.h
//  Leadoon
//
//  Created by Viktor on 17.10.15.
//  Copyright © 2015 Viktor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "MKMapView+ZoomLevel.h"

@interface MapViewOrder : UIViewController
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) CLLocationManager * locationManager;
@property (nonatomic,strong) CLLocation * currentLocathion;

@end
