//
//  ArithmeticsViewController.m
//  Arithmetics
//
//  Created by Christopher Wood on 8/14/13.
//  Copyright (c) 2013 Christopher Wood. All rights reserved.
//

#import "ArithmeticsViewController.h"

@interface ArithmeticsViewController ()



@end

@implementation ArithmeticsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self)
	{
		// allocate space, then invoke init
		hiddenFields = [[NSMutableArray alloc] init];
		answerFields = [[NSMutableArray alloc] init];
		buttonState = [[NSMutableArray alloc] init];
		
		// Fix the preview timer (default to 5s)
		previewTime = 0;
		gameTime = 0;
		PREVIEW_TIME_LIMIT = 5;

		// TODO: 
		
		// Add the questions and answers
//		[hiddenFields addObject:@" What is 7 + 7?"];
//		[answerFields addObject:@" 14"];
//		[hiddenFields addObject:@"Does Bob make too much money?"];
//		[answerFields addObject:@"Yes. Of Course."];
	}
	
	return self; // self is an id type (object reference)
}

- (void) previewTick:(NSTimer *) timer {
	previewTime = previewTime - 1;
	NSLog(@"Updating time...");
	NSString *intString = [NSString stringWithFormat:@"Preview: %ds", previewTime];
	[previewTimeField setText:intString];
	
	if (previewTime == 0)
	{
		NSLog(@"Killing the preview timer, swapping buttons, and starting the game.");
		
		// Kill the previewTimer, if necessary...
		if (previewTimer != nil)
		{
			[previewTimer invalidate];
			previewTimer = nil;
		}
		
		// TODO: swap button labels
		[button1_out.titleLabel setText:@"?"];
		[button2_out.titleLabel setText:@"?"];
		[button3_out.titleLabel setText:@"?"];
		[button4_out.titleLabel setText:@"?"];
		[button5_out.titleLabel setText:@"?"];
		[button6_out.titleLabel setText:@"?"];
		[button7_out.titleLabel setText:@"?"];
		[button8_out.titleLabel setText:@"?"];
		[button9_out.titleLabel setText:@"?"];
		[button10_out.titleLabel setText:@"?"];
		[button11_out.titleLabel setText:@"?"];
		[button12_out.titleLabel setText:@"?"];
			
		// Start the timer to fire every one second
		gameTime = 0;
		gameTimer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(gameTick:) userInfo:nil repeats:YES];
		[[NSRunLoop mainRunLoop] addTimer:gameTimer forMode:NSRunLoopCommonModes];
	}
	else
	{
		NSLog(@"Still in preview mode.");
	}
}


//- (void)previewTick
//{
//    // Do your thing here
//	previewTime = previewTime + 1;
//	NSLog(@"Updating time...");
//	NSString *intString = [NSString stringWithFormat:@"Time: %ds", previewTime];
//	[timeField setText:intString];
//	
//	// Kill the previewTimer, if necessary...
//	if (previewTimer != nil)
//    {
//        [previewTimer invalidate];
//        previewTimer = nil;
//    }
//	
//	if (previewTime == PREVIEW_TIME_LIMIT)
//	{
//		// Start the timer to fire every one second
//		gameTime = 0;
//		gameTimer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(gameTick:) userInfo:nil repeats:YES];
//		[[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
//	}
//	
//    // Call this method again using GCD
//    dispatch_queue_t q_background = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
//    double delayInSeconds = 1.0;
//    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
//    dispatch_after(popTime, q_background, ^(void){
//        [self previewTick];
//    });
//}

- (void) gameTick:(NSTimer *) timer {
	gameTime = gameTime + 1;
	NSLog(@"Updating time...");
	NSString *intString = [NSString stringWithFormat:@"Time: %ds", gameTime];
	[timeField setText:intString];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) buttonTimer:(NSTimer *) timer {
	NSDictionary *dict = [timer userInfo];
	int bid = [[dict objectForKey:@"buttonSource"] intValue];
	NSLog(@"Responding to button press timer expiration for: %d", bid);
	
	
	// TODO: need a better way to store/index/reference buttons
	
	if (bid == 4) [button1_out.titleLabel setText:hiddenFields[bid - 1]];
}

- (IBAction)button1:(id)sender {
//	questionIndex = (questionIndex + 1) % [questions count];
//	NSString *pQuestion = [questions objectAtIndex:questionIndex];
//	NSLog(@"displaying question : %@", pQuestion); // that's a weird format string...
//	[questionField setText:pQuestion];
//	[answerField setText:@"???"];
	
	// Swap in the button text...
	[button1_out.titleLabel setText:answerFields[0]];
	
	// Start the timer that will kill it, eventually...
	NSMutableDictionary *cb = [[NSMutableDictionary alloc] init];
	[cb setObject:[NSNumber numberWithInt:2] forKey:@"buttonSource"];
	NSTimer *timer = [NSTimer timerWithTimeInterval:2 target:self selector:@selector(buttonTimer:) userInfo:cb repeats:NO];
	[[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (IBAction)button2:(id)sender {
	NSMutableDictionary *cb = [[NSMutableDictionary alloc] init];
	[cb setObject:[NSNumber numberWithInt:2] forKey:@"buttonSource"];
	NSTimer *timer = [NSTimer timerWithTimeInterval:2 target:self selector:@selector(buttonTimer:) userInfo:cb repeats:NO];
	[[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (IBAction)button3:(id)sender {
}

- (IBAction)button4:(id)sender {
	NSMutableDictionary *cb = [[NSMutableDictionary alloc] init];
	[cb setObject:[NSNumber numberWithInt:4] forKey:@"buttonSource"];
	NSTimer *timer = [NSTimer timerWithTimeInterval:3 target:self selector:@selector(buttonTimer:) userInfo:cb repeats:NO];
	[[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (IBAction)button5:(id)sender {
}

- (IBAction)button6:(id)sender {
}

- (IBAction)button7:(id)sender {
}

- (IBAction)button8:(id)sender {
}

- (IBAction)button9:(id)sender {
}

- (IBAction)button10:(id)sender {
}

- (IBAction)button11:(id)sender {
}

- (IBAction)button12:(id)sender {
	[sender setTitle:@"ASD"];
}

- (IBAction)startButton:(id)sender {
	NSLog(@"Start button pressed.");
	NSLog(@"Killing both timers.");
	
	// Make sure both timers are dead.
	if (previewTimer != nil)
    {
        [previewTimer invalidate];
        previewTimer = nil;
    }
	if (gameTimer != nil)
    {
        [gameTimer invalidate];
        gameTimer = nil;
    }
	
	// Reset the game state
	numSelected = 0;
	
	// TODO: invoke the population code here...
	[hiddenFields addObject:@"1"];
	[hiddenFields addObject:@"1"];
	[hiddenFields addObject:@"2"];
	[hiddenFields addObject:@"2"];
	[hiddenFields addObject:@"3"];
	[hiddenFields addObject:@"3"];
	[hiddenFields addObject:@"4"];
	[hiddenFields addObject:@"4"];
	[hiddenFields addObject:@"5"];
	[hiddenFields addObject:@"5"];
	[hiddenFields addObject:@"6"];
	[hiddenFields addObject:@"6"];
	
	// And the corresponding answers...
	[answerFields addObject:@"0+1"];
	[answerFields addObject:@"1+0"];
	[answerFields addObject:@"1+1"];
	[answerFields addObject:@"3-1"];
	[answerFields addObject:@"2+1"];
	[answerFields addObject:@"3+0"];
	[answerFields addObject:@"2+2"];
	[answerFields addObject:@"3+1"];
	[answerFields addObject:@"4+1"];
	[answerFields addObject:@"3+2"];
	[answerFields addObject:@"5+1"];
	[answerFields addObject:@"3+3"];
	
	// Set the button titles appropriately
	[button1_out.titleLabel setText:hiddenFields[0]];
	[button2_out.titleLabel setText:hiddenFields[1]];
	[button3_out.titleLabel setText:hiddenFields[2]];
	[button4_out.titleLabel setText:hiddenFields[3]];
	[button5_out.titleLabel setText:hiddenFields[4]];
	[button6_out.titleLabel setText:hiddenFields[5]];
	[button7_out.titleLabel setText:hiddenFields[6]];
	[button8_out.titleLabel setText:hiddenFields[7]];
	[button9_out.titleLabel setText:hiddenFields[8]];
	[button10_out.titleLabel setText:hiddenFields[9]];
	[button11_out.titleLabel setText:hiddenFields[10]];
	[button12_out.titleLabel setText:hiddenFields[11]];
	
	// Update the label
	previewTime = PREVIEW_TIME_LIMIT;
	NSString *intString = [NSString stringWithFormat:@"Preview: %ds", previewTime];
	[previewTimeField setText:intString];
	
	// old timer code
//	previewTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(previewTick:) userInfo:nil repeats:YES];
	
	//	Start the timer to fire every one second
	previewTimer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(previewTick:) userInfo:nil repeats:YES];
	[[NSRunLoop mainRunLoop] addTimer:previewTimer forMode:NSRunLoopCommonModes];
}

- (IBAction)resetButton:(id)sender {
	NSLog(@"Reset button pressed.");
}

- (IBAction)modeButton:(id)sender {
	NSLog(@"Mode button pressed - does nothing yet...");
}
@end
