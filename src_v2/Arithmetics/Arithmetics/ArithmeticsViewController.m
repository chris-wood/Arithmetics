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
		hiddenFields = [[NSMutableArray alloc] init]; // allocate space, then invoke init
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
	previewTime = previewTime + 1;
	NSLog(@"Updating time...");
	NSString *intString = [NSString stringWithFormat:@"Time: %ds (get ready...)", previewTime];
	[timeField setText:intString];
	
	if (previewTime == PREVIEW_TIME_LIMIT)
	{
		// Start the timer to fire every one second
		gameTime = 0;
		gameTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(gameTick:) userInfo:nil repeats:YES];
	}
}

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

- (IBAction)button1:(id)sender {
//	questionIndex = (questionIndex + 1) % [questions count];
//	NSString *pQuestion = [questions objectAtIndex:questionIndex];
//	NSLog(@"displaying question : %@", pQuestion); // that's a weird format string...
//	[questionField setText:pQuestion];
//	[answerField setText:@"???"];
}

- (IBAction)button2:(id)sender {
}

- (IBAction)button3:(id)sender {
}

- (IBAction)button4:(id)sender {
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
}
@end
