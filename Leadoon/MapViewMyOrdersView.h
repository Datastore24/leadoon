//
//  MapViewMyOrdersView.h
//  Leadoon
//
//  Created by Viktor on 31.10.15.
//  Copyright © 2015 Viktor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapViewMyOrdersView : UIViewController
@property (weak, nonatomic) IBOutlet MKMapView *mapView; //Карта
@property (nonatomic, strong) CLLocationManager * locationManager;
@property (nonatomic,strong) CLLocation * currentLocathion;

@property (nonatomic, strong) NSMutableArray * arrayOrders;

@end
