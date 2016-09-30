//
//  ViewController.m
//  Hold The Door
//
//  Created by Abbin Varghese on 30/09/16.
//  Copyright © 2016 ABN. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    NSTimer *stopTimer;
    NSDate *startDate;
    BOOL running;
}

-(void)startPressed;
-(void)resetPressed;

-(void)updateTimer;


@property (weak, nonatomic) IBOutlet UILabel *lbl;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.lbl.text = @"00.00.00.00";
    running = FALSE;
}

-(void)startPressed{
    if(!running){
        startDate = [NSDate date];
        running = TRUE;
        if (stopTimer == nil) {
            stopTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/100.0
                                                         target:self
                                                       selector:@selector(updateTimer)
                                                       userInfo:nil
                                                        repeats:YES];
        }
    }else{
        running = FALSE;
        [stopTimer invalidate];
        stopTimer = nil;
    }
    
}
-(void)updateTimer{
    NSDate *currentDate = [NSDate date];
    NSTimeInterval timeInterval = [currentDate timeIntervalSinceDate:startDate];
    NSDate *timerDate = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm:ss.SS"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0.0]];
    NSString *timeString=[dateFormatter stringFromDate:timerDate];
    self.lbl.text = timeString;
}

-(void)resetPressed{
    [stopTimer invalidate];
    stopTimer = nil;
    running = FALSE;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)touchCancel:(id)sender {
    [self resetPressed];
}
- (IBAction)touchDown:(id)sender {
    [self startPressed];
}
- (IBAction)touchUpInside:(id)sender {
    [self resetPressed];
}
- (IBAction)touchUpOutside:(id)sender {
    [self resetPressed];
}


@end
