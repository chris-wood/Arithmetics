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
		buttonOutlets = [[NSMutableArray alloc] init];
		buttonPairMap = [[NSMutableDictionary alloc] init];
		
		// Fix the preview timer (default to 5s)
		previewTime = 0;
		gameTime = 0;
		PREVIEW_TIME_LIMIT = 5;
		numActiveButtons = 0;
		activeButtonLimit = 2; // since everything is paired up
		
		// Store button states (which ones were referenced)
		for (int i = 0; i < activeButtonLimit; i++)
		{
			[buttonState addObject:[[NSNumber alloc] initWithInt:0]];
		}
		
		NSLog(@"Initialization done.");
	}
	
	return self; // self is an id type (object reference)
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewDidLoad
{
    [super viewDidLoad];
	
    // Dump the outlets in the collection
	buttonOutlets = [[NSMutableArray alloc] init];
	[buttonOutlets addObject:button1_out];
	[buttonOutlets addObject:button2_out];
	[buttonOutlets addObject:button3_out];
	[buttonOutlets addObject:button4_out];
	[buttonOutlets addObject:button5_out];
	[buttonOutlets addObject:button6_out];
	[buttonOutlets addObject:button7_out];
	[buttonOutlets addObject:button8_out];
	[buttonOutlets addObject:button9_out];
	[buttonOutlets addObject:button10_out];
	[buttonOutlets addObject:button11_out];
	[buttonOutlets addObject:button12_out];
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
		
		// Move everything to game mode!
		for (int i = 0; i < 12; i++)
		{
			[buttonOutlets[i] setTitle:@"?" forState:UIControlStateNormal];
		}
			
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

- (void) gameTick:(NSTimer *) timer {
	gameTime = gameTime + 1;
	NSLog(@"Updating time...");
	NSString *intString = [NSString stringWithFormat:@"Time: %ds", gameTime];
	[timeField setText:intString];
}

- (void) buttonTimer:(NSTimer *) timer {
	NSDictionary *dict = [timer userInfo];
	int bid = [[dict objectForKey:@"buttonSource"] intValue];
	NSLog(@"Responding to button press timer expiration for: %d", bid);
	
	[[NSOperationQueue mainQueue] addOperationWithBlock:^{
		[buttonOutlets[bid - 1] setTitle:@"?" forState:UIControlStateNormal];
	}];
	
//	[buttonOutlets[i] setTitle:@"?" forState:UIControlStateNormal];
//	[self.view setNeedsDisplay];
//	[buttonOutlets[bid - 1] setNeedsDisplay];
}

-(BOOL)buttonsMatch{
//	int button1 = [buttonState[0] intValue];
//	int button2 = [buttonState[1] intValue];
//	if ([buttonPairMap objectForKey:button1] == button2 && [buttonPairMap objectForKey:button2] == button1)	{
	if ([buttonPairMap objectForKey:buttonState[0]] == buttonState[1] && [buttonPairMap objectForKey:buttonState[1]] == buttonState[0]) {
		return true;
	}
	else {
		return false;
	}
}

-(void)handleButtonPress:(int)buttonSource {
	buttonState[numActiveButtons] = [[NSNumber alloc] initWithInt:buttonSource];
	numActiveButtons++;
	if (numActiveButtons == activeButtonLimit)
	{
		numActiveButtons = 0;
		// If match, cool! Keep them open and lock the buttons, otherwise reset to normal and decrement score
		if ([self buttonsMatch] == true)
		{
			NSLog(@"MATCH!!!");
			[buttonOutlets[[buttonState[0] intValue] - 1] setEnabled:NO];
			[buttonOutlets[[buttonState[1] intValue] - 1] setEnabled:NO];
		}
		else
		{
			[buttonOutlets[[buttonState[0] intValue] - 1] setTitle:@"?" forState: UIControlStateNormal];
			[buttonOutlets[[buttonState[1] intValue] - 1] setTitle:@"?" forState: UIControlStateNormal];
		}
	}
}

- (IBAction)button1:(id)sender {
	// Swap in the button text...
	[button1_out setTitle:answerFields[0] forState:UIControlStateNormal];
	[self handleButtonPress:1];
	
	// Start the timer that will kill it, eventually...
//	NSMutableDictionary *cb = [[NSMutableDictionary alloc] init];
//	[cb setObject:[NSNumber numberWithInt:1] forKey:@"buttonSource"];
//	NSTimer *timer = [NSTimer timerWithTimeInterval:2 target:self selector:@selector(buttonTimer:) userInfo:cb repeats:NO];
//	[[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (IBAction)button2:(id)sender {
	// Swap in the button text...
	[button2_out setTitle:answerFields[1] forState:UIControlStateNormal];
	[self handleButtonPress:2];
	
//	NSMutableDictionary *cb = [[NSMutableDictionary alloc] init];
//	[cb setObject:[NSNumber numberWithInt:2] forKey:@"buttonSource"];
//	NSTimer *timer = [NSTimer timerWithTimeInterval:2 target:self selector:@selector(buttonTimer:) userInfo:cb repeats:NO];
//	[[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (IBAction)button3:(id)sender {
	// Swap in the button text...
	[button3_out setTitle:answerFields[2] forState:UIControlStateNormal];
	[self handleButtonPress:3];
	
//	NSMutableDictionary *cb = [[NSMutableDictionary alloc] init];
//	[cb setObject:[NSNumber numberWithInt:3] forKey:@"buttonSource"];
//	NSTimer *timer = [NSTimer timerWithTimeInterval:2 target:self selector:@selector(buttonTimer:) userInfo:cb repeats:NO];
//	[[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (IBAction)button4:(id)sender {
	// Swap in the button text...
	[button4_out setTitle:answerFields[3] forState:UIControlStateNormal];
	[self handleButtonPress:4];
	
//	NSMutableDictionary *cb = [[NSMutableDictionary alloc] init];
//	[cb setObject:[NSNumber numberWithInt:4] forKey:@"buttonSource"];
//	NSTimer *timer = [NSTimer timerWithTimeInterval:2 target:self selector:@selector(buttonTimer:) userInfo:cb repeats:NO];
//	[[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (IBAction)button5:(id)sender {
	// Swap in the button text...
	[button5_out setTitle:answerFields[4] forState:UIControlStateNormal];
	[self handleButtonPress:5];
	
//	NSMutableDictionary *cb = [[NSMutableDictionary alloc] init];
//	[cb setObject:[NSNumber numberWithInt:5] forKey:@"buttonSource"];
//	NSTimer *timer = [NSTimer timerWithTimeInterval:2 target:self selector:@selector(buttonTimer:) userInfo:cb repeats:NO];
//	[[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (IBAction)button6:(id)sender {
	// Swap in the button text...
	[button6_out setTitle:answerFields[5] forState:UIControlStateNormal];
	[self handleButtonPress:6];
	
//	NSMutableDictionary *cb = [[NSMutableDictionary alloc] init];
//	[cb setObject:[NSNumber numberWithInt:6] forKey:@"buttonSource"];
//	NSTimer *timer = [NSTimer timerWithTimeInterval:2 target:self selector:@selector(buttonTimer:) userInfo:cb repeats:NO];
//	[[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (IBAction)button7:(id)sender {
	// Swap in the button text...
	[button7_out setTitle:answerFields[6] forState:UIControlStateNormal];
	[self handleButtonPress:7];
	
//	NSMutableDictionary *cb = [[NSMutableDictionary alloc] init];
//	[cb setObject:[NSNumber numberWithInt:7] forKey:@"buttonSource"];
//	NSTimer *timer = [NSTimer timerWithTimeInterval:2 target:self selector:@selector(buttonTimer:) userInfo:cb repeats:NO];
//	[[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (IBAction)button8:(id)sender {
	// Swap in the button text...
	[button8_out setTitle:answerFields[7] forState:UIControlStateNormal];
	[self handleButtonPress:8];
	
//	NSMutableDictionary *cb = [[NSMutableDictionary alloc] init];
//	[cb setObject:[NSNumber numberWithInt:8] forKey:@"buttonSource"];
//	NSTimer *timer = [NSTimer timerWithTimeInterval:2 target:self selector:@selector(buttonTimer:) userInfo:cb repeats:NO];
//	[[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (IBAction)button9:(id)sender {
	// Swap in the button text...
	[button9_out setTitle:answerFields[8] forState:UIControlStateNormal];
	[self handleButtonPress:9];
	
//	NSMutableDictionary *cb = [[NSMutableDictionary alloc] init];
//	[cb setObject:[NSNumber numberWithInt:9] forKey:@"buttonSource"];
//	NSTimer *timer = [NSTimer timerWithTimeInterval:2 target:self selector:@selector(buttonTimer:) userInfo:cb repeats:NO];
//	[[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (IBAction)button10:(id)sender {
	// Swap in the button text...
	[button10_out setTitle:answerFields[9] forState:UIControlStateNormal];
	[self handleButtonPress:10];
	
//	NSMutableDictionary *cb = [[NSMutableDictionary alloc] init];
//	[cb setObject:[NSNumber numberWithInt:10] forKey:@"buttonSource"];
//	NSTimer *timer = [NSTimer timerWithTimeInterval:2 target:self selector:@selector(buttonTimer:) userInfo:cb repeats:NO];
//	[[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (IBAction)button11:(id)sender {
	// Swap in the button text...
	[button11_out setTitle:answerFields[10] forState:UIControlStateNormal];
	[self handleButtonPress:11];
	
//	NSMutableDictionary *cb = [[NSMutableDictionary alloc] init];
//	[cb setObject:[NSNumber numberWithInt:11] forKey:@"buttonSource"];
//	NSTimer *timer = [NSTimer timerWithTimeInterval:2 target:self selector:@selector(buttonTimer:) userInfo:cb repeats:NO];
//	[[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (IBAction)button12:(id)sender {
	// Swap in the button text...
	[button12_out setTitle:answerFields[11] forState:UIControlStateNormal];
	[self handleButtonPress:12];
	
//	NSMutableDictionary *cb = [[NSMutableDictionary alloc] init];
//	[cb setObject:[NSNumber numberWithInt:12] forKey:@"buttonSource"];
//	NSTimer *timer = [NSTimer timerWithTimeInterval:2 target:self selector:@selector(buttonTimer:) userInfo:cb repeats:NO];
//	[[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
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
	numActiveButtons = 0;
	
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
	
	// Associate pairs of buttons
	buttonPairMap = [[NSMutableDictionary alloc] init];
	[buttonPairMap setObject:[NSNumber numberWithInt:2] forKey:[NSNumber numberWithInt:1]];
	[buttonPairMap setObject:[NSNumber numberWithInt:1] forKey:[NSNumber numberWithInt:2]];
	[buttonPairMap setObject:[NSNumber numberWithInt:4] forKey:[NSNumber numberWithInt:3]];
	[buttonPairMap setObject:[NSNumber numberWithInt:3] forKey:[NSNumber numberWithInt:4]];
	[buttonPairMap setObject:[NSNumber numberWithInt:6] forKey:[NSNumber numberWithInt:5]];
	[buttonPairMap setObject:[NSNumber numberWithInt:5] forKey:[NSNumber numberWithInt:6]];
	[buttonPairMap setObject:[NSNumber numberWithInt:8] forKey:[NSNumber numberWithInt:7]];
	[buttonPairMap setObject:[NSNumber numberWithInt:7] forKey:[NSNumber numberWithInt:8]];
	[buttonPairMap setObject:[NSNumber numberWithInt:10] forKey:[NSNumber numberWithInt:9]];
	[buttonPairMap setObject:[NSNumber numberWithInt:9] forKey:[NSNumber numberWithInt:10]];
	[buttonPairMap setObject:[NSNumber numberWithInt:12] forKey:[NSNumber numberWithInt:11]];
	[buttonPairMap setObject:[NSNumber numberWithInt:11] forKey:[NSNumber numberWithInt:12]];
	
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
	[button1_out setTitle:answerFields[0] forState: UIControlStateNormal];
	[button2_out setTitle:answerFields[1] forState: UIControlStateNormal];
	[button3_out setTitle:answerFields[2] forState: UIControlStateNormal];
	[button4_out setTitle:answerFields[3] forState: UIControlStateNormal];
	[button5_out setTitle:answerFields[4] forState: UIControlStateNormal];
	[button6_out setTitle:answerFields[5] forState: UIControlStateNormal];
	[button7_out setTitle:answerFields[6] forState: UIControlStateNormal];
	[button8_out setTitle:answerFields[7] forState: UIControlStateNormal];
	[button9_out setTitle:answerFields[8] forState: UIControlStateNormal];
	[button10_out setTitle:answerFields[9] forState: UIControlStateNormal];
	[button11_out setTitle:answerFields[10] forState: UIControlStateNormal];
	[button12_out setTitle:answerFields[11] forState: UIControlStateNormal];
	
	// Update the time/score labels
	previewTime = PREVIEW_TIME_LIMIT;
	NSString *intString = [NSString stringWithFormat:@"Preview: %ds", previewTime];
	[previewTimeField setText:intString];
	intString = [NSString stringWithFormat:@"Time: 0s"];
	[timeField setText:intString];
	intString = [NSString stringWithFormat:@"Score: 0"];
	[scoreField setText:intString];
	
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

- (IBAction)cheatButton:(id)sender {
	NSLog(@"Cheat button pressed - does nothing yet...");	
}


@end
