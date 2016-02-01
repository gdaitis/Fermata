//
//  FRUnpairDeviceCell.h
//  Fermata
//
//  Created by Vytautas Gudaitis on 9/29/13.
//  Copyright (c) 2013 Seriously inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FRUnpairDeviceCell;

@protocol FRUnpairDeviceCellDelegate <NSObject>

@optional

- (void)unpairDeviceCellDidClickUnpairDeviceButton:(FRUnpairDeviceCell *)unpairDeviceCell;

@end

@interface FRUnpairDeviceCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *unpairDeviceButton;
@property (nonatomic, strong) id <FRUnpairDeviceCellDelegate> delegate;

@end
