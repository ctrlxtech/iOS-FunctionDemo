//
//  CtrlXViewController.h
//  learnSignal
//
//  Created by Ming Xu on 9/17/14.
//  Copyright (c) 2014 body7. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CtrlXViewController : UIViewController


@property (weak, nonatomic) IBOutlet UISwitch *learnOrUseSwitch;
- (IBAction)turnUp:(id)sender;
- (IBAction)turnDown:(id)sender;
- (IBAction)volumeIncrease:(id)sender;
- (IBAction)volumeDecrease:(id)sender;

@end
