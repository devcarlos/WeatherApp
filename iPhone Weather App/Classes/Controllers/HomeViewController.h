//
//  HomeViewController.h
//  iPhone Weather App
//
//  Created by Carlos Alcala on 4/7/16.
//  Copyright © 2016 Carlos Alcala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ForecastViewController.h"
#import "SearchViewController.h"

@interface HomeViewController : UIViewController <UIScrollViewDelegate, SearchControllerDelegate>

//Outlets
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *deleteLocationButton;

//Properties
@property (strong, nonatomic) UIView *contentView;
@property (strong, nonatomic) NSMutableArray *controllers;
@property (strong, nonatomic) NSMutableArray *locations;
@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) SearchViewController *searchController;

@property (assign, nonatomic) BOOL pageControlUsed;

//Actions
- (IBAction)addLocation:(id)sender;
- (IBAction)deleteLocation:(id)sender;

@end
