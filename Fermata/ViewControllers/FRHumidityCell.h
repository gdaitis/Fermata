//
//  FRHumidityCell.h
//  Fermata
//
//  Created by Lukas Kekys on 9/28/13.
//  Copyright (c) 2013 Seriously inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FRHumidityCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *humidityLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *percentLabel;

@property (weak, nonatomic) IBOutlet UIView *background;

@end
