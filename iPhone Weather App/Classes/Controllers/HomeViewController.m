//
//  HomeViewController.m
//  iPhone Weather App
//
//  Created by Carlos Alcala on 4/7/16.
//  Copyright © 2016 Carlos Alcala. All rights reserved.
//

#import "HomeViewController.h"


@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self configureData];
    [self configureControllers];
    [self configureScrollView];
    [self checkDeleteLocations];
}

- (void)configureData {
    self.controllers = [NSMutableArray new];
    self.locations = [NSMutableArray new];
    
    self.searchController = [[UIStoryboard storyboardWithName:@"Search" bundle:nil] instantiateViewControllerWithIdentifier:@"Search"];
    self.searchController.delegate = self;
    
    //user default settings
    [self restoreLocations];
    
    //add default locations
    if ([self.locations count] == 0) {
        //default location
        [self.locations addObject:@"Dublin"];
        [self.locations addObject:@"London"];
        [self.locations addObject:@"Barcelona"];
        [self.locations addObject:@"New York"];
    }
    
    NSLog(@"LOCATIONS: %@", self.locations);
    
    [self saveLocations];
}

- (void)configureControllers {
    
    for (NSString *query in self.locations) {
        ForecastViewController* forecastVC = [[UIStoryboard storyboardWithName:@"Forecast" bundle:nil] instantiateViewControllerWithIdentifier:@"Forecast"];
        forecastVC.query = query;
        [self.controllers addObject:forecastVC];
    }
}

- (void)configureScrollView {
    
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    
    NSLog(@"CONTROLLERS: %d", (int)self.controllers.count);
    
    //scroll content sizes
    CGFloat contentWidth = self.scrollView.frame.size.width * (self.controllers.count);
    CGFloat contentHeight = self.scrollView.frame.size.height;
    
    self.scrollView.backgroundColor = [UIColor clearColor];
    self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, contentWidth, contentHeight)];
    self.contentView.backgroundColor = [UIColor clearColor];
    [self.scrollView addSubview:self.contentView];
    
    //for each controller
    for (int i=0;i<[self.controllers count];i++) {
        
        ForecastViewController *controller = (ForecastViewController *)[self.controllers objectAtIndex:i];
        
        NSLog(@"QUERY: %@", controller.query);
        [self addChildViewController:controller];
        
        CGRect frame = [self viewFrameWithX0:(self.view.bounds.size.width * i) frameSize:self.scrollView.bounds.size];
        
        NSLog(@"VIEW %d = ORIGIN X: %f", i, frame.origin.x);
        NSLog(@"VIEW %d = ORIGIN Y: %f", i, frame.origin.y);
        NSLog(@"VIEW %d = SIZE WIDTH: %f", i, frame.size.width);
        NSLog(@"VIEW %d = SIZE HEIGHT: %f", i, frame.size.height);        
        
        controller.view.frame = frame;
        
        [self.contentView addSubview:controller.view];
        [self addBasicConstraintsOnSubView:controller.view onSuperView:self.contentView];
        
        [controller.view layoutIfNeeded];
        [self.contentView layoutIfNeeded];
    }
    
    self.scrollView.contentSize = CGSizeMake(contentWidth, contentHeight);
    NSLog(@"CONTENT SIZE: %f, %f", contentWidth, contentHeight);
    
    //set origin to first view
    CGPoint scrollPoint = CGPointMake(0, 0);
    [self.scrollView setContentOffset:scrollPoint animated:NO];
    
    self.pageControl.numberOfPages = self.controllers.count;
}

-(CGRect)viewFrameWithX0:(CGFloat)xOrigin frameSize:(CGSize)viewFrameSize {
    
    CGFloat borderWidth = 15.0f;
    CGFloat bottomOffset = 40.0f;
    return CGRectMake(xOrigin + borderWidth, borderWidth, viewFrameSize.width - borderWidth - borderWidth, viewFrameSize.height - borderWidth*2 - bottomOffset);
}

-(void)addBasicConstraintsOnSubView:(UIView *)subView onSuperView:(UIView *)superView {
    //    [subView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [superView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|-0-[subView]-0-|"] options: NSLayoutFormatAlignmentMask metrics:nil views:NSDictionaryOfVariableBindings(subView)]];
    [superView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"|-%f-[subView(%f)]-%f-|",subView.frame.origin.x, subView.frame.size.width,subView.frame.origin.x] options: NSLayoutFormatAlignmentMask metrics:nil views:NSDictionaryOfVariableBindings(subView)]];
}

-(void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self configureTimer];
}

-(void) viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];

    [self.timer invalidate];
    self.timer = nil;
}

-(void) configureTimer {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(timerFired) userInfo:nil repeats:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Scroll Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (self.pageControlUsed) {
        return;
    }
    
    CGFloat pageWidth = self.scrollView.frame.size.width;
    int page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    NSLog(@"CURRENT PAGE: %d", page);
    
    if (self.pageControl.currentPage != page) {
        self.pageControl.currentPage = page;
    }
}

//scrolling ends
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    //find the page number you are on
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    NSLog(@"Scrolling - Page: %i",page);
    
    self.pageControlUsed = NO;
}

//dragging ends, please switch off paging to listen for this event
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    
    //find the page number you are on
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    NSLog(@"Dragging - Page: %i",page);
    
}

- (void)timerFired{
    if ([self.controllers count] > 0) {
        ForecastViewController* controller = [self.controllers objectAtIndex:self.pageControl.currentPage];
        if (controller) {
            [controller viewMayNeedUpdate];
        }
    }
    NSLog(@"Timer Fired");
}

#pragma mark - Model Functions

-(void)saveLocations {
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:self.locations] forKey:@"locations"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)restoreLocations {
    // locations array
    NSData *dataArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"locations"];
    if (dataArray != nil) {
        NSArray *oldSavedArray = [NSKeyedUnarchiver unarchiveObjectWithData:dataArray];
        if (oldSavedArray != nil) {
            self.locations = [[NSMutableArray alloc] initWithArray:oldSavedArray];
        } else {
            self.locations = [NSMutableArray new];
        }
    } else {
        self.locations = [NSMutableArray new];
    }
    
    NSLog(@"LOCATIONS: %d", (int)[self.locations count]);
}

#pragma mark - Actions
- (IBAction)addLocation:(id)sender {
    [self presentViewController:self.searchController animated:YES completion:nil];
}

- (IBAction)deleteLocation:(id)sender {
    if (self.pageControl.numberOfPages > 1) {
        [self removeLocationAtIndex:self.pageControl.currentPage];
    }
}

- (void)checkDeleteLocations {
    if (self.controllers.count > 1) {
        self.navigationItem.leftBarButtonItem = self.deleteLocationButton;
    } else {
        self.navigationItem.leftBarButtonItem = nil;
    }
}


#pragma mark - PageControl ValueChange

- (IBAction)changePage:(id)sender
{
    CGRect frame = self.scrollView.frame;
    frame.origin.x = frame.size.width * self.pageControl.currentPage;
    frame.origin.y = 0;
    
    [self.scrollView scrollRectToVisible:frame animated:YES];
    self.pageControlUsed = YES;
}

#pragma mark - SearchController Delegate

- (void) searchFinishedWithLocation:(NSString *)location{
    [self addLocationWithLocation:location];
}

- (void)addLocationWithLocation:(NSString*)location {
    
    [self.locations addObject:location];
    [self saveLocations];
    
    ForecastViewController* controller = [[UIStoryboard storyboardWithName:@"Forecast" bundle:nil] instantiateViewControllerWithIdentifier:@"Forecast"];
    controller.query = location;
    NSLog(@"QUERY: %@", controller.query);
    
    [self.controllers addObject:controller];
    
    //scroll content sizes
    CGFloat contentWidth = self.scrollView.frame.size.width * (self.controllers.count);
    CGFloat contentHeight = self.scrollView.frame.size.height;
    
    self.contentView.frame = CGRectMake(0, 0, contentWidth, contentHeight);
    
    //for new controller
    int index = (int)([self.controllers count] -1);
    NSLog(@"INDEX: %d", index);
    
    //for each controller
    for (int i=0;i<[self.controllers count];i++) {
        
        ForecastViewController *controller = (ForecastViewController *)[self.controllers objectAtIndex:i];
        
        NSLog(@"QUERY: %@", controller.query);
        CGRect frame = [self viewFrameWithX0:(self.view.bounds.size.width * i) frameSize:self.scrollView.bounds.size];
        controller.view.frame = frame;
        
        if (i == index) {
            [self addChildViewController:controller];
            [self.contentView addSubview:controller.view];
        }
        
        [self addBasicConstraintsOnSubView:controller.view onSuperView:self.contentView];
        
        [controller.view layoutIfNeeded];
        [self.contentView layoutIfNeeded];
    }
    
    self.scrollView.contentSize = CGSizeMake(contentWidth, contentHeight);
    NSLog(@"CONTENT SIZE: %f, %f", contentWidth, contentHeight);
    
    //set origin to first view
    CGFloat pointX = self.view.bounds.size.width * index;
    NSLog(@"POINT X: %f", pointX);
    
    CGPoint scrollPoint = CGPointMake(pointX, 0);
    [self.scrollView setContentOffset:scrollPoint animated:NO];
    self.pageControl.numberOfPages = self.controllers.count;
    self.pageControl.currentPage = self.controllers.count;
}

- (void)removeLocationAtIndex:(NSInteger)index {
    
    if ([self.controllers count] < 1) {
        self.pageControl.numberOfPages = 0;
        return;
    }
    
    // Now the thing to do is to figure out if we have a controller tracking location.
    // If so, increment index by one.
    NSUInteger pageIndex = index;
    
    // remove page with index... from UIScrollView
    NSLog(@"removing page: %d", (int)pageIndex);
    
    NSString* location;
    if ([self.locations count] > 0) {
        location = [self.locations objectAtIndex:pageIndex];
        [self.locations removeObjectAtIndex:pageIndex];
    }
    
    ForecastViewController* controller;
    if ([self.controllers count] > 0) {
        // removeObjectAtIndex will release the object, no need to release controller
        controller = [self.controllers objectAtIndex:pageIndex];
        [controller.view removeFromSuperview];
        [self.controllers removeObjectAtIndex:pageIndex];
    }
    
    //scroll content sizes
    CGFloat contentWidth = self.scrollView.frame.size.width * (self.controllers.count);
    CGFloat contentHeight = self.scrollView.frame.size.height;
    
    self.contentView.frame = CGRectMake(0, 0, contentWidth, contentHeight);
    
    // shift all the views afterwards to the left
    //for each controller
    for (int i=0;i<[self.controllers count];i++) {
        
        ForecastViewController *controller = (ForecastViewController *)[self.controllers objectAtIndex:i];
        
        NSLog(@"QUERY: %@", controller.query);
        CGRect frame = [self viewFrameWithX0:(self.view.bounds.size.width * i) frameSize:self.scrollView.bounds.size];
        controller.view.frame = frame;
        
        [self addBasicConstraintsOnSubView:controller.view onSuperView:self.contentView];
        
        [controller.view layoutIfNeeded];
        [self.contentView layoutIfNeeded];
    }
    
    self.scrollView.contentSize = CGSizeMake(contentWidth, contentHeight);
    NSLog(@"CONTENT SIZE: %f, %f", contentWidth, contentHeight);
    
    CGPoint scrollPoint = CGPointMake(0, 0);
    [self.scrollView setContentOffset:scrollPoint animated:NO];
    
    // fix up PageControl
    self.pageControl.numberOfPages = self.controllers.count;
    
    // save locations
    [self saveLocations];
    
    [self checkDeleteLocations];
}

@end
