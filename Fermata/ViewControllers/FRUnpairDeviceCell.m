//
//  FRUnpairDeviceCell.m
//  Fermata
//
//  Created by Vytautas Gudaitis on 9/29/13.
//  Copyright (c) 2013 Seriously inc. All rights reserved.
//

#import "FRUnpairDeviceCell.h"

@implementation FRUnpairDeviceCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)unpairButtonClicked:(id)sender
{
    [self.delegate unpairDeviceCellDidClickUnpairDeviceButton:self];
}

@end
