//
//  ViewController.h
//  MapKit HW
//
//  Created by Nik on 11.09.15.
//  Copyright (c) 2015 Nik. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NSPersonalInfoDelegate <NSObject>

- (void) setName:(NSString*)name dateOfBirth:(NSDate*) date andAdress:(NSString*)addres;

@end

@class MKMapView;

@interface ViewController : UIViewController
@property (strong,nonatomic) IBOutlet MKMapView* MapView;
@end

