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
		
		[self resetGameState];
		
		// Initialize to normal mode to start
		maxButtonValue = 16;
		currentGameMode = NORMAL_MODE;
		
		// Store button states (which ones were referenced)
		for (int i = 0; i < activeButtonLimit; i++)
		{
			[buttonState addObject:[[NSNumber alloc] initWithInt:0]];
		}
		
		NSLog(@"Initialization done.");
	}
	
	return self; // self is an id type (object reference)
}

-(void)resetGameState
{
	// Fix the preview timer (default to 5s)
	score = 0;
	previewTime = 0;
	gameTime = 0;
	PREVIEW_TIME_LIMIT = 5;
	GAME_TIME_LIMIT = 100;
	numActiveButtons = 0;
	matchedButtons = 0;
	activeButtonLimit = 2; // since everything is paired up
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
	
    // Dispose of any resources that can be recreated...
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
	
	// Initialize button press state
	buttonPressState = [[NSMutableArray alloc] init];
	buttonMatchState = [[NSMutableArray alloc] init];
	for (int i = 0; i < 12; i++)
	{
		[buttonPressState addObject:[NSNumber numberWithBool:NO]];
		[buttonMatchState addObject:[NSNumber numberWithBool:NO]];
	}
	
	// Create the set of available nodes
	modes = [[NSArray alloc] initWithObjects:@"Normal", @"Modular", @"Fractions", nil];
	
	// Make the picker hidden
	modePicker.hidden = YES;
	
	// Create the subview
	optionsController = [[ArithmeticsOptionsViewController alloc] initWithNibName:@"ArithmeticsOptionsViewController" bundle:[NSBundle mainBundle]];
}

- (NSInteger)numberOfComponentsInPickerView:
(UIPickerView *)pickerView
{
	return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
	return [modes count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView
			 titleForRow:(NSInteger)row
			forComponent:(NSInteger)component
{
	return [modes objectAtIndex:row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
	  inComponent:(NSInteger)component
{
//	float rate = [[exchangeRates objectAtIndex:row] floatValue];
//	float dollars = [dollarText.text floatValue];
//	float result = dollars * rate;
//	NSString *resultString = [[NSString alloc] initWithFormat:
//							  @"%.2f USD = %.2f %@", dollars, result,
//							  [countryNames objectAtIndex:row]];
//	resultLabel.text = resultString;
	
	NSString *newMode = [modes objectAtIndex:row];
	NSString *newLabel = [[NSString alloc] initWithFormat:@"Mode: %s", newMode.cString];
	[modeField setText:newLabel];
	
	NSLog(@"Picked row %d", row);
//	NSLog(@"new label =  %s", newLabel);
	modePicker.hidden = YES; // set back to hidden
}

-(IBAction)textFieldReturn:(id)sender
{
    [sender resignFirstResponder];
}

- (void)updateButtons:(int)max {
	bool success = false;
	switch (currentGameMode)
	{
		case NORMAL_MODE:
			success = [self normalGen:max];
			break;
		default:
			// TODO: need to throw an exception here...
			NSLog(@"In an invalid game state!!!! ");
			break;
	}
	
	// Only activate the buttons if we successfully generated them
	if (success)
	{
		// Reset the button states for everything
		for (int i = 0; i < [buttonOutlets count]; i++)
		{
			[buttonOutlets[i] setTitle:@"?" forState: UIControlStateNormal];
			[buttonOutlets[i] setBackgroundColor:[UIColor clearColor]];
		}
		
		for (int i = 0; i < 12; i++) // MAGIC NUMBER
		{
			[buttonOutlets[i] setTitle:answerFields[i] forState:UIControlStateNormal];
			[buttonOutlets[i] setEnabled:YES];
		}
	}
}

- (bool)normalGen:(int)max
{	
	int count = 0;
	NSMutableArray* targets = [[NSMutableArray alloc] init]; // value that each button equates to
	NSMutableArray* buttonAssignment = [[NSMutableArray alloc] init];
	while (count < 6) // MAGIC NUMBER
	{
		int randNum = (rand() % max) + 1;
		bool found = false;
		for (int i = 0; i < [targets count]; i++)
		{
			if (targets[i] == [NSNumber numberWithInt:randNum])
			{
				found = true;
			}
		}
		NSLog(@"Checking for repetition");
		if (found == false)
		{
			NSLog([NSString stringWithFormat:@"Creating pair #%d", count]);
			[targets addObject:[NSNumber numberWithInt:randNum]];
			
			// Pick four different numbers and operations and work backwards...
//			NSMutableArray* operands = [[NSMutableArray alloc] init];
			int r1 = (rand() % max) + 1;
			int r2 = (rand() % max) + 1;
			while (r1 == r2)
			{
				r2 = (rand() % max) + 1;
			}
			int r1x = randNum - r1;
			int r2x = randNum - r2;
			
			// Assign button locations and the strings to go with them
			// Pick a button location, check to see if it's in our list so far, and then continue
			int buttonId1 = 0;
			bool alreadyPicked = true;
			while (alreadyPicked)
			{
				buttonId1 = rand() % 12;
				bool foundMatch = false;
				for (int i = 0; i < [buttonAssignment count]; i++)
				{
					if (buttonAssignment[i] == [[NSNumber alloc] initWithInt:buttonId1])
					{
						foundMatch = true;
					}
				}
				if (!foundMatch)
				{
					alreadyPicked = false;
				}
			}
			
			NSLog([NSString stringWithFormat:@"Found place for button 1: %d", buttonId1]);
			
			// Set this button information
			[buttonAssignment addObject:[[NSNumber alloc] initWithInt:buttonId1]];
			int buttonId2 = 0;
			alreadyPicked = true;
			while (alreadyPicked)
			{
				buttonId2 = rand() % 12;
				bool foundMatch = false;
				for (int i = 0; i < [buttonAssignment count]; i++)
				{
					if (buttonAssignment[i] == [[NSNumber alloc] initWithInt:buttonId2])
					{
						foundMatch = true;
					}
				}
				if (!foundMatch)
				{
					alreadyPicked = false;
				}
			}
			
			NSLog([NSString stringWithFormat:@"Found place for button 2: %d", buttonId2]);
			
			// Set this button information
			[buttonAssignment addObject:[[NSNumber alloc] initWithInt:buttonId2]];
			
			// Tie the buttons together...
			[buttonPairMap setObject:[NSNumber numberWithInt:(buttonId1 + 1)] forKey:[NSNumber numberWithInt:(buttonId2 + 1)]];
			[buttonPairMap setObject:[NSNumber numberWithInt:(buttonId2 + 1)] forKey:[NSNumber numberWithInt:(buttonId1 + 1)]];
			
			// Set the answer text fields...
			answerFields[buttonId1] = [NSString stringWithFormat:@"%d + %d", r1, r1x];
			answerFields[buttonId2] = [NSString stringWithFormat:@"%d + %d", r2, r2x];
			
			// Bump up the count - number of buttons we've satisfied so far
			count = count + 1;
		}
	}
	
	// We will always be successful here...
	return true;
}

// TODO: implement button generation algorithms for the other modes here

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
		[cheatButton_out setEnabled:YES];
		for (int i = 0; i < 12; i++)
		{
			[buttonOutlets[i] setTitle:@"?" forState:UIControlStateNormal];
			[buttonOutlets[i] setEnabled:YES];
		}
			
		// Start the timer to fire every one second
		gameTimer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(gameTick:) userInfo:nil repeats:YES];
		[[NSRunLoop mainRunLoop] addTimer:gameTimer forMode:NSRunLoopCommonModes];
	}
	else
	{
		NSLog(@"Still in preview mode.");
	}
}

- (void) cheatTick:(NSTimer*) timer {
	gameTime = gameTime - 1;
}

- (void) gameTick:(NSTimer *) timer {
	gameTime = gameTime - 1;
	NSLog(@"Updating time...");
	NSString *intString = [NSString stringWithFormat:@"Time: %ds", gameTime];
	[timeField setText:intString];
	if (gameTime == 0)
	{
		// Make sure both timers are dead.
		[self killTimers];
		
		// Display an alert to show that the game is over
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Game Over!"
														message:[[NSString alloc] initWithFormat: @"Score: %d", score]
													   delegate:nil
											  cancelButtonTitle:@"Play Again"
											  otherButtonTitles:nil];
		[alert show];
	}
}

- (void) buttonTimer:(NSTimer *) timer {
	NSDictionary *dict = [timer userInfo];
	int bid = [[dict objectForKey:@"buttonSource"] intValue];
	NSLog(@"Responding to button press timer expiration for: %d", bid);
	
	[[NSOperationQueue mainQueue] addOperationWithBlock:^{
		[buttonOutlets[bid - 1] setTitle:@"?" forState:UIControlStateNormal];
	}];
}

-(BOOL)buttonsMatch{
	if ([buttonPairMap objectForKey:buttonState[0]] == buttonState[1] &&
		[buttonPairMap objectForKey:buttonState[1]] == buttonState[0])
	{
		return true;
	}
	else
	{
		return false;
	}
}

-(void)updateScore {
	NSString *intString = [NSString stringWithFormat:@"Score: %d", score];
	[scoreField setText:intString];
}

-(void)handleButtonPress:(int)buttonSource
{
	NSLog([NSString stringWithFormat:@"Pressed: %d", buttonSource]);
	buttonPressState[buttonSource - 1] = [NSNumber numberWithBool:YES];
	buttonState[numActiveButtons] = [[NSNumber alloc] initWithInt:buttonSource];
	[buttonOutlets[[buttonState[numActiveButtons] intValue] - 1] setBackgroundColor:[UIColor blueColor]];
	numActiveButtons++;
	if (numActiveButtons == activeButtonLimit)
	{
		numActiveButtons = 0;
		// If match, cool! Keep them open and lock the buttons, otherwise reset to normal and decrement score
		if ([self buttonsMatch] == true)
		{
			NSLog(@"MATCH!!!");
			
			// Update the score
			score = score + 1;
			[self updateScore];
			
			// Fix the buttons so that they can't be pressed anymore
			matchedButtons += 2;
			[buttonOutlets[[buttonState[0] intValue] - 1] setEnabled:NO];
			[buttonOutlets[[buttonState[0] intValue] - 1] setBackgroundColor:[UIColor redColor]];
			[buttonOutlets[[buttonState[1] intValue] - 1] setEnabled:NO];
			[buttonOutlets[[buttonState[1] intValue] - 1] setBackgroundColor:[UIColor redColor]];
			
			// Reset button press state back to false/no
			buttonPressState[[buttonState[0] intValue] - 1] = [NSNumber numberWithBool:NO];
			buttonPressState[[buttonState[1] intValue] - 1] = [NSNumber numberWithBool:NO];
			buttonMatchState[[buttonState[0] intValue] - 1] = [NSNumber numberWithBool:YES];
			buttonMatchState[[buttonState[1] intValue] - 1] = [NSNumber numberWithBool:YES];
			
			if (matchedButtons == [buttonOutlets count])
			{
				
				// TODO: put in pauseGame() method
				// Kill the game timer to pause the game
				if (gameTimer != nil)
				{
					[gameTimer invalidate];
					gameTimer = nil;
				}
				
				// pick new game pieces and put them on the board and then enter preview mode
				[self updateButtons:maxButtonValue];
				[self startPreviewMode:false];
			}
		}
		else
		{
			// Incorrect guess, decrement the score
			score = score - 1;
			[self updateScore];
			
			[buttonOutlets[[buttonState[0] intValue] - 1] setTitle:@"?" forState: UIControlStateNormal];
			[buttonOutlets[[buttonState[0] intValue] - 1] setBackgroundColor:[UIColor clearColor]];
			[buttonOutlets[[buttonState[1] intValue] - 1] setTitle:@"?" forState: UIControlStateNormal];
			[buttonOutlets[[buttonState[1] intValue] - 1] setBackgroundColor:[UIColor clearColor]];
		}
	}
}

- (IBAction)button1:(id)sender {
	[button1_out setTitle:answerFields[0] forState:UIControlStateNormal];
	buttonPressState[0] = [NSNumber numberWithBool:YES];
	[self handleButtonPress:1];
}

- (IBAction)button2:(id)sender {
	[button2_out setTitle:answerFields[1] forState:UIControlStateNormal];
	buttonPressState[1] = [NSNumber numberWithBool:YES];
	[self handleButtonPress:2];
}

- (IBAction)button3:(id)sender {
	[button3_out setTitle:answerFields[2] forState:UIControlStateNormal];
	buttonPressState[2] = [NSNumber numberWithBool:YES];
	[self handleButtonPress:3];
}

- (IBAction)button4:(id)sender {
	[button4_out setTitle:answerFields[3] forState:UIControlStateNormal];
	buttonPressState[3] = [NSNumber numberWithBool:YES];
	[self handleButtonPress:4];
}

- (IBAction)button5:(id)sender {
	[button5_out setTitle:answerFields[4] forState:UIControlStateNormal];
	buttonPressState[4] = [NSNumber numberWithBool:YES];
	[self handleButtonPress:5];
}

- (IBAction)button6:(id)sender {
	[button6_out setTitle:answerFields[5] forState:UIControlStateNormal];
	buttonPressState[5] = [NSNumber numberWithBool:YES];
	[self handleButtonPress:6];
}

- (IBAction)button7:(id)sender {
	[button7_out setTitle:answerFields[6] forState:UIControlStateNormal];
	buttonPressState[6] = [NSNumber numberWithBool:YES];
	[self handleButtonPress:7];
}

- (IBAction)button8:(id)sender {
	[button8_out setTitle:answerFields[7] forState:UIControlStateNormal];
	buttonPressState[7] = [NSNumber numberWithBool:YES];
	[self handleButtonPress:8];
}

- (IBAction)button9:(id)sender {
	[button9_out setTitle:answerFields[8] forState:UIControlStateNormal];
	buttonPressState[8] = [NSNumber numberWithBool:YES];
	[self handleButtonPress:9];
}

- (IBAction)button10:(id)sender {
	[button10_out setTitle:answerFields[9] forState:UIControlStateNormal];
	buttonPressState[9] = [NSNumber numberWithBool:YES];
	[self handleButtonPress:10];
}

- (IBAction)button11:(id)sender {
	[button11_out setTitle:answerFields[10] forState:UIControlStateNormal];
	buttonPressState[10] = [NSNumber numberWithBool:YES];
	[self handleButtonPress:11];
}

- (IBAction)button12:(id)sender {
	[button12_out setTitle:answerFields[11] forState:UIControlStateNormal];
	buttonPressState[11] = [NSNumber numberWithBool:YES];
	[self handleButtonPress:12];
}

-(void)killTimers
{
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
	if (cheatTimer != nil)
	{
		[cheatTimer invalidate];
		cheatTimer = nil;
	}
}

-(void)startPreviewMode:(bool)fresh
{
	if (fresh)
	{
		gameTime = GAME_TIME_LIMIT;
	}
	
	// Disable all buttons except reset (&& options?)
	[cheatButton_out setEnabled:NO];
	for (int i = 0; i < 12; i++) // MAGIC NUMBER
	{
		[buttonOutlets[i] setEnabled:NO];
	}
	
	// Update the time/score labels (this is only for a new game - other times we leave these values alone)
	NSString *intString = [NSString stringWithFormat:@"Preview: %ds", previewTime];
	[previewTimeField setText:intString];
	intString = [NSString stringWithFormat:@"Time: %ds", gameTime];
	[timeField setText:intString];
	intString = [NSString stringWithFormat:@"Score: %d", score];
	[scoreField setText:intString];
	
	// Kick off the preview timer
	previewTime = PREVIEW_TIME_LIMIT;
	previewTimer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(previewTick:) userInfo:nil repeats:YES];
	[[NSRunLoop mainRunLoop] addTimer:previewTimer forMode:NSRunLoopCommonModes];
}

- (IBAction)startButton:(id)sender
{
	NSLog(@"Start button pressed.");
	NSLog(@"Killing both timers.");
	
	// Kill the timers
	[self killTimers];
	
	// Reset the game state
	numActiveButtons = 0;
	
	// Associate pairs of buttons
	buttonPairMap = [[NSMutableDictionary alloc] init];
	
	// And the corresponding answers...
	answerFields = [[NSMutableArray alloc] init];
	for (int i = 0; i < 12; i++)
	{
		[answerFields addObject:@"TMP"];
	}
	
	// Reset game state information and then enter preview mode...
	[self resetGameState];
	[self updateButtons:maxButtonValue];
	[self startPreviewMode:true];
		
	//	Start the timer to fire every one second
//	[self startPreviewMode];
//	previewTimer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(previewTick:) userInfo:nil repeats:YES];
//	[[NSRunLoop mainRunLoop] addTimer:previewTimer forMode:NSRunLoopCommonModes];
}

- (IBAction)resetButton:(id)sender {
	NSLog(@"Reset button pressed.");
	
	// TODO: code below is repeated in startButton action - put into an instance method...
	
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
	
	// Reset times/scores
	numActiveButtons = 0;
	gameTime = 0;
	previewTime = 0;
	score = 0;
	matchedButtons = 0;
	
	// Update the time/score labels
	NSString *intString = [NSString stringWithFormat:@"Preview: %ds", previewTime];
	[previewTimeField setText:intString];
	intString = [NSString stringWithFormat:@"Time: %ds", gameTime];
	[timeField setText:intString];
	intString = [NSString stringWithFormat:@"Score: 0"];
	[scoreField setText:intString];
	
	// Reset the button states for everything
	for (int i = 0; i < [buttonOutlets count]; i++)
	{
		[buttonOutlets[i] setTitle:@"?" forState: UIControlStateNormal];
		[buttonOutlets[i] setBackgroundColor:[UIColor clearColor]];
	}
}

- (IBAction)cheatButtonDown:(id)sender {
	NSLog(@"Cheat button pressed down - does nothing yet...");
	
	// Start the cheat timer to decrement the total time (not the score)
	cheatTimer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(cheatTick:) userInfo:nil repeats:YES];
	[[NSRunLoop mainRunLoop] addTimer:gameTimer forMode:NSRunLoopCommonModes];
	
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
}

- (IBAction)cheatButtonUp:(id)sender {
	NSLog(@"Cheat button left up - does nothing yet...");
	
	// Kill the cheating timer
	if (cheatTimer != nil)
	{
		[cheatTimer invalidate];
		cheatTimer = nil;
	}
	
	// Set the button titles appropriately
	for (int i = 0; i < 12; i++)
	{
		if (buttonMatchState[i] == [NSNumber numberWithBool:NO])
		{
			NSLog(@"False!");
			[buttonOutlets[i] setTitle:@"?" forState: UIControlStateNormal];
		}
		else
		{
			NSLog(@"True! Match! Keep answer");
			[buttonOutlets[i] setTitle:answerFields[i] forState: UIControlStateNormal];
		}
	}
}

- (IBAction)optionsButton:(id)sender {
//	[self presentViewController:optionsController animated:YES completion:nil];
	[self.view addSubview:optionsController.view];
}


@end
