//
//  ForecastViewController.h
//  iPhone Weather App
//
//  Created by Carlos Alcala on 4/7/16.
//  Copyright © 2016 Carlos Alcala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Weather.h"

@interface ForecastViewController : UIViewController

//IBOutlets
@property (weak, nonatomic) IBOutlet UIImageView *backImage;
@property (weak, nonatomic) IBOutlet UIImageView *weatherImage;
@property (weak, nonatomic) IBOutlet UILabel *locationName;
@property (weak, nonatomic) IBOutlet UILabel *nowTemp;
@property (weak, nonatomic) IBOutlet UILabel *nowCondition;
@property (weak, nonatomic) IBOutlet UILabel *nowWind;
@property (weak, nonatomic) IBOutlet UILabel *nowHumidity;


@property (weak, nonatomic) IBOutlet UITableView *tableView;


//Properties
@property (strong, nonatomic) NSString* query;
@property (strong, nonatomic) Weather* weather;
@property (assign, nonatomic) BOOL useImperial;


//Methods
- (void)loadWeather;
- (void)viewMayNeedUpdate;

@end
