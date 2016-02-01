//
//  FRChartViewController.h
//  Fermata
//
//  Created by Lukas Kekys on 9/29/13.
//  Copyright (c) 2013 Seriously inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FRBaseViewController.h"

typedef enum {
	CHART_TYPE_TEMPERATURE = 0,
	CHART_TYPE_HUMIDITY
} ChartType;

@interface FRChartViewController : FRBaseViewController

@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@property (nonatomic, assign) ChartType chartType;

@end
