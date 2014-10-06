//
//  NetworkConnectViewController.h
//  learnSignal
//
//  Created by Ming Xu on 9/17/14.
//  Copyright (c) 2014 body7. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NetworkConnectViewController : UIViewController

@property (strong, nonatomic) NSInputStream *inputStream;
@property (strong, nonatomic) NSOutputStream *outputStream;

@end
