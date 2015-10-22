//
//  MapViewScoreboardOrders.h
//  Leadoon
//
//  Created by Viktor on 22.10.15.
//  Copyright © 2015 Viktor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "MKMapView+ZoomLevel.h"
#import "ZSAnnotation.h"
#import "ZSPinAnnotation.h"

@interface MapViewScoreboardOrders : UIViewController
@property (weak, nonatomic) IBOutlet MKMapView *mapViewScoreboardOrders;
@property (nonatomic, strong) CLLocationManager * locationManager;
@property (nonatomic,strong) CLLocation * currentLocathion;


@end
