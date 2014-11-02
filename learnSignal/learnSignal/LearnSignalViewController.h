//
//  LearnSignalViewController.h
//  learnSignal
//
//  Created by Ming Xu on 9/18/14.
//  Copyright (c) 2014 body7. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LearnSignalViewController : UIViewController<NSStreamDelegate>

@property (strong, nonatomic) NSInputStream *inputStream;
@property (strong, nonatomic) NSOutputStream *outputStream;
@property (strong, nonatomic) NSString *ip;
@property (weak, nonatomic) IBOutlet UIButton *isLearnBtn;

- (IBAction)clickLearnBtn:(id)sender;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *functionBtn;

- (IBAction)clickFunctionBtn:(id)sender;
@end
