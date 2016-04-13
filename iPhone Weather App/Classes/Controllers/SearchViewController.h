//
//  SearchViewController.h
//  WeatherApp
//
//  Created by Carlos Alcala on 4/11/16.
//  Copyright © 2016 Carlos Alcala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@protocol SearchControllerDelegate <NSObject>

-(void)searchFinishedWithLocation:(NSString*)location;

@end

@interface SearchViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;


@property (weak, nonatomic) id <SearchControllerDelegate> delegate;

@property (strong, nonatomic) NSMutableArray *locations;
@property (strong, nonatomic) NSDictionary *selectedLocation;
@property (assign, nonatomic) MKCoordinateRegion region;

- (IBAction)cancelButtonPressed:(id)sender;


-(void)autocompleteLocationsMapKitAPI:(NSString*)query withRegion:(MKCoordinateRegion)region success:(void(^)(NSMutableArray* locations))success failure:(void(^)(NSString* errorString))failure;


@end
