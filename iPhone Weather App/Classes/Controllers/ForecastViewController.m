//
//  ForecastViewController.m
//  iPhone Weather App
//
//  Created by Carlos Alcala on 4/7/16.
//  Copyright © 2016 Carlos Alcala. All rights reserved.
//

#import "ForecastViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <UIActivityIndicator-for-SDWebImage/UIImageView+UIActivityIndicatorForSDWebImage.h>
#import "APIManager.h"
#import "ParseManager.h"

@interface ForecastViewController ()

@end

@implementation ForecastViewController

- (id)init {
    self = [super init];
    if (self != nil)
    {
        // Further initialization if needed
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibName bundle:(NSBundle *)bundle {
    self = [super initWithNibName:@"ForecastViewController" bundle:nil];
    if (self != nil)
    {
        // Further initialization if needed
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //configure default appeareance
    [self configureAppearance];
    [self loadWeather];
}

- (void)configureAppearance {
    // Now add rounded corners
    [self.view.layer setCornerRadius:15.0f];
    [self.view.layer setMasksToBounds:YES];
    [self.view.layer setBorderWidth:1.5f];
    [self.view.layer setBorderColor:[UIColor lightGrayColor].CGColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewMayNeedUpdate {
    NSDate *currentTime = [NSDate date];
    NSTimeInterval interval = [currentTime timeIntervalSinceDate:self.weather.timestamp];
    
    // 900 seconds is 15 minutes
    if (interval >= 900) {
        //load wether after
        [self loadWeather];
    }
}

#pragma mark - API Call

- (void)loadWeather {
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    hud.labelText = @"Fetching Weather...";
    
    NSLog(@"QUERY: %@", self.query);
    
    [[APIManager shared] fetchForecastWithQuery:self.query
                                        success:^(NSDictionary *dictionary){
                                            NSLog(@"JSON: %@", dictionary);
                                            
                                            //TODO: parse results and display
                                            self.weather = [[ParseManager shared] parseDataToWeatherFromDictionary:dictionary];
                                            
                                            //request finished timestamp
                                            self.weather.timestamp = [NSDate date];
                                            
                                            [self updateForecast];
                                            
                                            [hud hide:YES];
                                            
                                        }
                                        failure:^(NSString *errorString) {
                                            NSLog(@"ERROR: %@", errorString);
                                            [self showAlertError:errorString];
                                        }];
}

- (void)showAlertError:(NSString*)errorString {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                   message:errorString preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK"
                                                     style:UIAlertActionStyleDefault handler:nil];
    
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - Update Functions

- (void)updateForecast {
    
    //update current location forecast data
    self.locationName.text = self.weather.request.query;
    self.nowCondition.text = self.weather.current.weatherDescription;
    self.nowTemp.text = [self.weather.current formatTemperatureImperial:self.useImperial];
    self.nowWind.text = [self.weather.current formatWindSpeedImperial:self.useImperial];
    self.nowHumidity.text = [NSString stringWithFormat:@"%u%%", [self.weather.current.humidity intValue]];
    
    if ([Validator isValidLengthString:self.weather.current.iconURL] ) {
        
        NSLog(@"URL: %@", self.weather.current.iconURL);
        
        //to avoid repeat the same image each time
        self.weatherImage.image = [UIImage new];
        
        //download image with SDWebImage and spinning
        [self.weatherImage setImageWithURL:[NSURL URLWithString:self.weather.current.iconURL]
                        placeholderImage:nil
                                 options:SDWebImageRefreshCached
                               completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                   NSLog(@"Image Download Complete!");
                               }
             usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    }
    
    //TODO: handle table content to update
//    [self.tableView reloadData];
}

@end
