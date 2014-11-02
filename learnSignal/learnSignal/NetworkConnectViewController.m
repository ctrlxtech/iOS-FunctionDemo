//
//  NetworkConnectViewController.m
//  learnSignal
//
//  Created by Ming Xu on 9/18/14.
//  Copyright (c) 2014 body7. All rights reserved.
//

#import "NetworkConnectViewController.h"
#import "LearnSignalViewController.h"

@interface NetworkConnectViewController ()

@end

@implementation NetworkConnectViewController

@synthesize ipAddressTextField = _ipAddressTextField;


NSInputStream *inputStream;
NSOutputStream *outputStream;
NSString *ip;

- (void)initNetworkConnection
{
    CFReadStreamRef readStream;
    CFWriteStreamRef writeStream;
    CFStringRef remoteHost = (__bridge CFStringRef)ip;
    
    CFStreamCreatePairWithSocketToHost(NULL, remoteHost, 80, &readStream, &writeStream);
    
    inputStream = (__bridge NSInputStream *) readStream;
    outputStream = (__bridge NSOutputStream *) writeStream;
    
    [inputStream setDelegate:self];
    [outputStream setDelegate:self];
    
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation

//pass the ip address to the LearnSignalViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([[segue identifier] isEqualToString:@"pushToLearnSignalSegue"]){
        LearnSignalViewController *lsViewController = (LearnSignalViewController *)[segue destinationViewController];
        lsViewController.inputStream = inputStream;
        lsViewController.outputStream = outputStream;
        
        [lsViewController.inputStream setDelegate:lsViewController];
        [lsViewController.outputStream setDelegate:lsViewController];
        lsViewController.ip = ip;
        
    }
}


- (IBAction)connectDevice:(id)sender {
    ip = _ipAddressTextField.text;
    [self initNetworkConnection];
    [self performSegueWithIdentifier: @"pushToLearnSignalSegue" sender: self];
}
@end
