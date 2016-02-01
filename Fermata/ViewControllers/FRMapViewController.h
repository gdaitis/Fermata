//
//  FRMapViewController.h
//  Fermata
//
//  Created by Lukas Kekys on 9/29/13.
//  Copyright (c) 2013 Seriously inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FRBaseViewController.h"

typedef enum {
	MAP_TYPE_MAP = 0,
	MAP_TYPE_HISTORY
} MapType;

@interface FRMapViewController : FRBaseViewController

@property (nonatomic, assign) MapType mapType;

@end
