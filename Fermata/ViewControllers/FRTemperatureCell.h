//
//  FRTemperatureCell.h
//  Fermata
//
//  Created by Lukas Kekys on 9/28/13.
//  Copyright (c) 2013 Seriously inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FRTemperatureCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *celciusLabel;

@property (weak, nonatomic) IBOutlet UIView *background;

@end
