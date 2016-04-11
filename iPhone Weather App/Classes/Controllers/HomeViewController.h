//
//  HomeViewController.h
//  iPhone Weather App
//
//  Created by Carlos Alcala on 4/7/16.
//  Copyright © 2016 Carlos Alcala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ForecastViewController.h"

@interface HomeViewController : UIViewController <UIScrollViewDelegate>

//Outlets
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

//Properties
@property (strong, nonatomic) UIView *contentView;
@property (strong, nonatomic) NSMutableArray *controllers;
@property (strong, nonatomic) NSMutableArray *locations;
@property (strong, nonatomic) NSTimer *timer;

@property (assign, nonatomic) BOOL pageControlUsed;

//Actions
- (IBAction)addLocation:(id)sender;


@end
