//
//  FRInstrumentCell.h
//  Fermata
//
//  Created by Lukas Kekys on 9/28/13.
//  Copyright (c) 2013 Seriously inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FRInstrumentLocationCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;

@property (weak, nonatomic) IBOutlet UIView *background;

@end
