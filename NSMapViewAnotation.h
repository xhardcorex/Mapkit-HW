//
//  NS.h
//  MapKit HW
//
//  Created by Nik on 14.09.15.
//  Copyright (c) 2015 Nik. All rights reserved.
//

#import <MapKit/MapKit.h>
#import <Foundation/Foundation.h>

@interface NSMapViewAnotation : MKAnnotationView
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@end

