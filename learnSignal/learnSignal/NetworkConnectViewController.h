//
//  NetworkConnectViewController.h
//  learnSignal
//
//  Created by Ming Xu on 9/18/14.
//  Copyright (c) 2014 body7. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NetworkConnectViewController : UIViewController<NSStreamDelegate>

@property (weak, nonatomic) IBOutlet UITextField *ipAddressTextField;
- (IBAction)connectDevice:(id)sender;

@end
