//
//  ArithmeticsViewController.h
//  Arithmetics
//
//  Created by Christopher Wood on 8/14/13.
//  Copyright (c) 2013 Christopher Wood. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArithmeticsViewController : UIViewController
{
	// The model objects
	NSMutableArray *hiddenFields; // hidden text shown on the button
	NSMutableArray *answerFields; // matched text shown on button
	NSMutableArray *buttonState; // holds NSBool objects that indicate if a button is "active" - showing the answer
	NSMutableArray *buttonOutlets; // reference to the grid outlets
	NSMutableDictionary *buttonPairMap;
	int numActiveButtons;
	int activeButtonLimit;
	int matchedButtons;
	
	// The view objects
	IBOutlet UILabel *scoreField;
	IBOutlet UILabel *timeField;
	IBOutlet UILabel *previewTimeField;
	
	// Button outlets
	IBOutlet UIButton *button1_out;
	IBOutlet UIButton *button2_out;
	IBOutlet UIButton *button3_out;
	IBOutlet UIButton *button4_out;
	IBOutlet UIButton *button5_out;
	IBOutlet UIButton *button6_out;
	IBOutlet UIButton *button7_out;
	IBOutlet UIButton *button8_out;
	IBOutlet UIButton *button9_out;
	IBOutlet UIButton *button10_out;
	IBOutlet UIButton *button11_out;
	IBOutlet UIButton *button12_out;
	
	// Timer for the game (there is no time limit)
	NSTimer *previewTimer;
	NSTimer *gameTimer;
	int gameTime;
	int previewTime;
	int	PREVIEW_TIME_LIMIT;
	int score;
}

-(void)handleButtonPress:(int)buttonSource;
- (IBAction)button1:(id)sender;
- (IBAction)button2:(id)sender;
- (IBAction)button3:(id)sender;
- (IBAction)button4:(id)sender;
- (IBAction)button5:(id)sender;
- (IBAction)button6:(id)sender;
- (IBAction)button7:(id)sender;
- (IBAction)button8:(id)sender;
- (IBAction)button9:(id)sender;
- (IBAction)button10:(id)sender;
- (IBAction)button11:(id)sender;
- (IBAction)button12:(id)sender;
- (IBAction)startButton:(id)sender;
- (IBAction)resetButton:(id)sender;
- (IBAction)modeButton:(id)sender;
- (IBAction)cheatButton:(id)sender;

@end

