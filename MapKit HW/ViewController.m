//
//  ViewController.m
//  MapKit HW
//
//  Created by Nik on 11.09.15.
//  Copyright (c) 2015 Nik. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import "NSStudent.h"
#import "NSMapAnotation.h"
#import "PersonalInfoViewController.h"

@interface ViewController () <MKMapViewDelegate>
@property (strong,nonatomic) NSMutableArray* arrayOfStudents;
@property (strong,nonatomic) NSMutableArray* arrayOfAnnotations;
@property (strong,nonatomic) NSStudent* student;
@property (strong,nonatomic) CLGeocoder* geocoder;
@property (strong,nonatomic) MKDirections* directions;

@end

@implementation ViewController




- (void)viewDidLoad {
    [super viewDidLoad];

    self.arrayOfStudents = [NSMutableArray array];
    self.arrayOfAnnotations = [NSMutableArray array];
    
    [self createStudentsArray];
    
    [self generateAnnotations];
    
    [self.MapView addAnnotations:self.arrayOfAnnotations];
    
    UIBarButtonItem* zoomButton  = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(serchAll:)];
    
    self.navigationItem.rightBarButtonItem = zoomButton;
    self.geocoder = [[CLGeocoder alloc]init];


}
- (void) serchAll:(UIBarButtonItem*) sender {
    
    MKMapRect zoomRect = MKMapRectNull;
    
    
    for (id <MKAnnotation> annotation in self.MapView.annotations) {
        
        
        CLLocationCoordinate2D location = annotation.coordinate;
        
        
        MKMapPoint center = MKMapPointForCoordinate(location);
        
        static double delta = 20000;
        
        MKMapRect rect =  MKMapRectMake(center.x - delta, center.y - delta, delta * 2, delta * 2);
        
        zoomRect = MKMapRectUnion(zoomRect, rect);
        
    }
    zoomRect = [self.MapView mapRectThatFits:zoomRect];
    
    [self.MapView setVisibleMapRect:zoomRect  edgePadding:UIEdgeInsetsMake(50, 50, 50, 50)  animated:YES ];


}
- (void) makeAdress:(NSStudent*) student{
    
    
    
    CLLocationCoordinate2D coordinate = student.location;
    
    CLLocation* location = [[CLLocation alloc]initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    [self.geocoder reverseGeocodeLocation:location
              completionHandler:^(NSArray *placemarks, NSError *error) {
                  CLPlacemark *placemark = [placemarks firstObject];
                
                  
                    student.adress = [[placemark.addressDictionary valueForKey:@"FormattedAddressLines"] componentsJoinedByString:@", "];
                  /*[NSString stringWithFormat:@"%@ %@ %@ %@",
                                       placemark.country ? placemark.country: @"",
                                       placemark.locality ? placemark.locality:@"",
                                       placemark.thoroughfare ? placemark.thoroughfare:@"",
                                       placemark.subThoroughfare ? placemark.subThoroughfare:@""
                                       ];*/
                  
                  
                  NSLog(@"placemark %@",placemark);
                  //String to hold address
                  NSString *locatedAt = [[placemark.addressDictionary valueForKey:@"FormattedAddressLines"] componentsJoinedByString:@", "];
                  NSLog(@"addressDictionary %@", placemark.addressDictionary);
                  
                  NSLog(@"placemark %@",placemark.region);
                  NSLog(@"placemark %@",placemark.country);  // Give Country Name
                  NSLog(@"placemark %@",placemark.locality); // Extract the city name
                  NSLog(@"location %@",placemark.name);
                  NSLog(@"location %@",placemark.ocean);
                  NSLog(@"location %@",placemark.postalCode);
                  NSLog(@"location %@",placemark.subLocality);
                  
                  NSLog(@"location %@",placemark.location);
                  //Print the location to console
                  NSLog(@"I am currently at %@",locatedAt);
    
                
                  
              }
     
    
     ];
    /* [self.geocoder reverseGeocodeLocation:location
                        completionHandler:^(NSArray *placemarks, NSError *error) {
                            
                            NSString* message = nil;
                            
                            if (error) {
                                message = [error localizedDescription];
                                
                            }else{
                                
                                if ([placemarks count] > 0) {
                                    MKPlacemark* placeMark = [placemarks firstObject];
                                    
                                    message = [placeMark.addressDictionary description];
                                }else {
                                    
                                    
                                    message = @"No placemarks found" ;
                                }
                            }
                            
                            student.adress = message;
                        }]; */
    
    
    
    
}
- (void) showInfo:(UIButton*) sender  {

    PersonalInfoViewController* vc= [self.storyboard instantiateViewControllerWithIdentifier:@"PersonalInfoViewController"];
    
    
    [vc setName:self.student.name dateOfBirth:self.student.dateOfBirth andAdress:self.student.adress];
    
   UINavigationController* nav = [[UINavigationController alloc]initWithRootViewController:vc];
   
    UIPopoverController* popover = [[UIPopoverController alloc]initWithContentViewController:nav];
    nav.preferredContentSize = CGSizeMake(500, 500);
    popover.popoverContentSize = CGSizeMake(500, 500);
    [popover presentPopoverFromRect:[sender frame ]
                             inView:sender
           permittedArrowDirections:UIPopoverArrowDirectionLeft | UIPopoverArrowDirectionRight
                           animated:YES
     ];
    
  
    
}
- (void) createStudentsArray{
    
    NSMutableArray* array = [NSMutableArray array];
    
    for (int i = 0 ;  i <15;i++) {
        NSStudent* student = [[NSStudent alloc]init];
        
        [self makeAdress:student];
        
        [array addObject:student];
        
        
    }
    
    self.arrayOfStudents = array;
    
}


#pragma  mark  - MyMethods


- (void) generateAnnotations{
    
    NSMutableArray* array = [NSMutableArray array];
    
    
    for (NSStudent* student in self.arrayOfStudents) {
        
    NSMapAnotation* annotation = [[NSMapAnotation alloc]init];
    
    annotation.title = [NSString stringWithFormat:@"%@ %@",student.name,student.surname];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        
        
        NSDate *date = student.dateOfBirth;
        
        [dateFormatter setDateFormat: @"yyyy-MM-dd"];
        
        
        NSString *string = [dateFormatter stringFromDate: date];

        
    annotation.subtitle = string;
    annotation.coordinate = student.location;
    [array addObject:annotation];

    }
    
    self.arrayOfAnnotations = array;
    
    }

#pragma  mark  - MkMapDelegate
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation{
    
    MKPinAnnotationView* annotationView = nil;
    annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation
                                                      reuseIdentifier:nil];
    annotationView.annotation = annotation;
    
    
    
    
    UIButton* descriptionButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
    [descriptionButton addTarget:self action:@selector(showInfo:) forControlEvents:UIControlEventTouchUpInside];
   
    
    //[[UIButton alloc] addTarget:self action:@selector(showInfo:) forControlEvents:UIControlEventTouchUpInside];
    
    annotationView.rightCalloutAccessoryView = descriptionButton;

    annotationView.image =[UIImage imageNamed:@"pin.png"];
    annotationView.canShowCallout= YES;
    UIImageView* imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 32, 32)];
    imageView.image = [UIImage imageNamed:@"man.png"];
    annotationView.leftCalloutAccessoryView = imageView;
    return annotationView;
    
}
- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    
    NSMapAnotation* anot = view.annotation;
    
    for (int i = 0; i < [self.arrayOfAnnotations count];i++ ) {
        
        NSMapAnotation* mapAnot = [self.arrayOfAnnotations objectAtIndex:i];
        
        if ([anot isEqual:mapAnot]) {
            
            NSStudent* student = [[NSStudent alloc]init];
            student.name = anot.title;
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            
           [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            
            NSDate *formattedDate = [dateFormatter dateFromString:anot.subtitle];
            student.dateOfBirth =  formattedDate;
            NSLog(@"%@",student.dateOfBirth);
         
            NSStudent* stud = [self.arrayOfStudents objectAtIndex:i];
            
            if ([stud.dateOfBirth isEqual:student.dateOfBirth]) {
                student.location = stud.location;
            }
            
            [self makeAdress:student];
            self.student = student;
            
        }
        
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)mapViewWillStartLoadingMap:(MKMapView *)mapView{
    
    NSLog(@"start!");
}
- (void)mapViewDidFinishLoadingMap:(MKMapView *)mapView{
    NSLog(@"finish!");
}
@end
