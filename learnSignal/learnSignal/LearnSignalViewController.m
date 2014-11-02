//
//  LearnSignalViewController.m
//  learnSignal
//
//  Created by Ming Xu on 9/18/14.
//  Copyright (c) 2014 body7. All rights reserved.
//

#import "LearnSignalViewController.h"

@interface LearnSignalViewController ()

@end

@implementation LearnSignalViewController

@synthesize inputStream;
@synthesize outputStream;
@synthesize isLearnBtn;
@synthesize functionBtn;
bool isLearn;
int buttonIndex;
NSMutableDictionary *dictionary;

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
    [[self isLearnBtn] setTitle:@"Use" forState:UIControlStateNormal];
    isLearn = false;
    dictionary = [[NSMutableDictionary alloc] init];
    for (int i = 0; i<5; i++) {
        NSLog(@"%d",[functionBtn[i] tag]);
        NSString *initObject = [NSString stringWithFormat:@"%d", i];
        [dictionary setObject:initObject forKey:[NSString stringWithFormat:@"%d", i]];
        //dictionary setObject:<#(id)#> forKey:<#(id<NSCopying>)#>
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)clickLearnBtn:(id)sender {
    if(isLearn)
    {
        [isLearnBtn setTitle:@"Use" forState:UIControlStateNormal];
        isLearn = false;
        
    }
    else
    {
        [isLearnBtn setTitle:@"Learn" forState:UIControlStateNormal];
        isLearn = true;
    }
        
}



- (IBAction)clickFunctionBtn:(id)sender {
    if (isLearn == false) {
        [self sendMessage:[sender tag]];
    }
    else
    {
        /*for (int i; i<5; i++) {
            [functionBtn[i] setBackgroundColor:[UIColor whiteColor]];
        }*/
        
        [functionBtn[buttonIndex] setBackgroundColor:[UIColor whiteColor]];
        buttonIndex = [sender tag];
        if ([sender isMemberOfClass:[UIButton class]])
        {
            UIButton *btn = (UIButton *)sender;
            
            // Then you can reference the title or a tag of the clicked button to do some further conditional logic if you want.
            [btn setBackgroundColor:[UIColor blackColor]];
                }
    }
    
   }

- (void)stream:(NSStream *)theStream handleEvent:(NSStreamEvent)streamEvent
{
    
    switch(streamEvent) {
        case NSStreamEventHasBytesAvailable:
        {
            if (theStream == inputStream) {
                
                uint8_t buffer[1024];
                int len;
                
                while ([inputStream hasBytesAvailable]) {
                    len = [inputStream read:buffer maxLength:sizeof(buffer)];
                    if (len > 0) {
                        
                        NSString *output = [[NSString alloc] initWithBytes:buffer length:len encoding:NSASCIIStringEncoding];
                        
                        if (nil != output) {
                            
                            NSLog(@"\nreciving data------%s",buffer);
                                  
                                  [self messageReceived:output];
                                  
                                  }
                                }
                            }
                        }
        }
    }
}
            /* if(!_data) {
                _data = [[NSMutableData data] retain];
            }
            uint8_t buf[1024];
            unsigned int len = 0;
            len = [(NSInputStream *)stream read:buf maxLength:1024];
            if(len) {
                [_data appendBytes:(const void *)buf length:len];
                // bytesRead is an instance variable of type NSNumber.
                [bytesRead setIntValue:[bytesRead intValue]+len];
            } else {
                NSLog(@"no buffer!");
            }
            break;
        }
        case NSStreamEventHasSpaceAvailable:
        {
            uint8_t *readBytes = (uint8_t *)[_data mutableBytes];
            readBytes += byteIndex; // instance variable to move pointer
            int data_len = [_data length];
            unsigned int len = ((data_len - byteIndex >= 1024) ?
                                1024 : (data_len-byteIndex));
            uint8_t buf[len];
            (void)memcpy(buf, readBytes, len);
            len = [stream write:(const uint8_t *)buf maxLength:len];
            byteIndex += len;
            break;
            */
        

    
- (void) messageReceived:(NSString *)message {
    
    //add the message to the co-responding button
    //when sending the message, use send it to the Device
    //[NSString stringWithFormat:@"%d", buttonIndex];
    [dictionary setObject:message forKey:[NSString stringWithFormat:@"%d", buttonIndex]];
    NSLog(@"receive learn signal %@ for button%d\n",message,buttonIndex);
    
    [functionBtn[buttonIndex] setBackgroundColor:[UIColor whiteColor]];
    }

- (void) sendMessage:(int)index
{
    //NSString *response  = @"lets start chat";
    
    //change this to the string stored in the dictionary
    NSString *response = [dictionary objectForKey:[NSString stringWithFormat:@"%d",index]];
    NSLog(@"%d",index);
    NSData *data = [[NSData alloc] initWithData:[response dataUsingEncoding:NSASCIIStringEncoding]];
    [outputStream write:[data bytes] maxLength:[data length]];
}
@end
