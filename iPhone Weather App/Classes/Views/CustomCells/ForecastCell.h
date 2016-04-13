//
//  ForecastCell.h
//  WeatherApp
//
//  Created by Carlos Alcala on 4/11/16.
//  Copyright © 2016 Carlos Alcala. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForecastCell : UITableViewCell

//IBOutlets
@property (weak, nonatomic) IBOutlet UIImageView *weatherImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;

@end
