//
//  NSStudent.h
//  Lesson30UITableVIew Dynamic cells
//
//  Created by Nik on 09.08.15.
//  Copyright (c) 2015 Nik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
@interface NSStudent : NSObject
@property (strong,nonatomic) NSString* name;
@property (strong,nonatomic) NSString* surname;
@property (assign,nonatomic) CLLocationCoordinate2D location;
@property (strong,nonatomic) NSDate* dateOfBirth;
@property (strong,nonatomic) NSString* adress;

@end
