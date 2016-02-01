//
//  FRInstrumentInfoCell.h
//  Fermata
//
//  Created by Vytautas Gudaitis on 9/29/13.
//  Copyright (c) 2013 Seriously inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FRInstrumentInfoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *cellLabel;
@property (weak, nonatomic) IBOutlet UITextField *cellTextField;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImage;

@end
