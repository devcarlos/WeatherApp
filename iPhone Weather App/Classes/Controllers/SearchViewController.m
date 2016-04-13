//
//  SearchViewController.m
//  WeatherApp
//
//  Created by Carlos Alcala on 4/11/16.
//  Copyright © 2016 Carlos Alcala. All rights reserved.
//

#import "SearchViewController.h"
#import "Validator.h"

@interface SearchViewController ()

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self configureSearchBar];
    [self configureSettings];
}

- (void)configureSearchBar {
    self.searchBar.delegate = self;
}

- (void)configureSettings {
    //TODO: create region based on current device position
    self.region = MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(34.0379519, -118.4774865), 1000.0, 1000.0);
    self.locations = [NSMutableArray new];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.locations count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"ForecastCell";
    
    UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    // Configure the cell.
    NSDictionary* location = [self.locations objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [location objectForKey:@"title"];
    cell.detailTextLabel.text = [location objectForKey:@"subtitle"];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"SELECTED: %d", (int)indexPath.row);
    
    [self.searchBar resignFirstResponder];
    self.selectedLocation = [self.locations objectAtIndex:indexPath.row];
    
    [self.delegate searchFinishedWithLocation:[self.selectedLocation objectForKey:@"title"]];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Search Delegate

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    return YES;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    NSString* query = self.searchBar.text;
    
    [self autocompleteLocationsMapKitAPI:query
                              withRegion:self.region
                                 success:^(NSMutableArray *locations){
                                     
                                     //update locations and reload table
                                     self.locations = locations;
                                     [self.tableView reloadData];
                                 
                                 }
                                 failure:^(NSString *errorString){
                                     //show error
                                     [self showAlertError:errorString];
                                 }];

}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self.searchBar resignFirstResponder];
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [self.searchBar resignFirstResponder];
}

- (void)showAlertError:(NSString*)errorString {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                   message:errorString preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK"
                                                     style:UIAlertActionStyleDefault handler:nil];
    
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - Actions

- (IBAction)cancelButtonPressed:(id)sender {
    [self.searchBar resignFirstResponder];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Method

-(void)autocompleteLocationsMapKitAPI:(NSString*)query withRegion:(MKCoordinateRegion)region success:(void(^)(NSMutableArray* locations))success failure:(void(^)(NSString* errorString))failure{
    
    MKLocalSearchRequest* request = [[MKLocalSearchRequest alloc] init];
    request.naturalLanguageQuery = query;
    request.region = region;
    
    MKLocalSearch *search = [[MKLocalSearch alloc] initWithRequest:request];
    
    [search startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error){
    
        if (error != nil) {
            NSLog(@"Error occured in search: %@", error.localizedDescription);
            failure(error.localizedDescription);

        } else if (response.mapItems.count == 0) {
            NSLog(@"No matches found");
            failure(@"No Matched Found");
        } else {
            
            NSMutableArray* locations = [NSMutableArray new];
            
            for (MKMapItem* item in response.mapItems) {
                
                NSString* name = item.name ? item.name : @"" ;
                NSString* number = item.placemark.subThoroughfare ? item.placemark.subThoroughfare : @"" ;
                NSString* street = item.placemark.thoroughfare ? item.placemark.thoroughfare : @"" ;
                NSString* city = item.placemark.locality ? item.placemark.locality : @"" ;
                NSString* state = item.placemark.administrativeArea ? item.placemark.administrativeArea : @"" ;
                NSString* zip = item.placemark.postalCode ? item.placemark.postalCode : @"" ;
                NSString* country = item.placemark.country ? item.placemark.country : @"" ;
                
                CLLocation* location = item.placemark.location;
                
                NSString* title = [NSString stringWithFormat:@"%@", city];
                NSString* subtitle = [NSString stringWithFormat:@"%@ %@ %@ %@ %@ %@ %@", name, number, street, city, state, zip, country];
                
                NSDictionary* locationDict = @{@"title" : title, @"subtitle" : subtitle, @"location" : location};
                
                if ([Validator isValidString:title] && ![title isEqualToString:@""]) {
                    [locations addObject:locationDict];
                }
            }
            
            NSLog(@"LOCATIONS %@", locations);
            
            success(locations);
        }
    }];
}

@end
