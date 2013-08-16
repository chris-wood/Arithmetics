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
	NSMutableArray *buttonState; //
	
	// The view objects
	IBOutlet UILabel *scoreField;
	IBOutlet UILabel *timeField;
	IBOutlet UILabel *previewTimeField;
	
	// Button references...
	__weak IBOutlet UIButton *button1_out;
	__weak IBOutlet UIButton *button2_out;
	__weak IBOutlet UIButton *button6_out;
	__weak IBOutlet UIButton *button10_out;
	__weak IBOutlet UIButton *button9_out;
	__weak IBOutlet UIButton *button8_out;
	__weak IBOutlet UIButton *button7_out;
	__weak IBOutlet UIButton *button5_out;
	__weak IBOutlet UIButton *button4_out;
	__weak IBOutlet UIButton *button3_out;
	__weak IBOutlet UIButton *button12_out;
	__weak IBOutlet UIButton *button11_out;
	
	// View objects for buttons
//	IBOutlet UILabel *button1Field;
//	IBOutlet UILabel *button2Field;
//	IBOutlet UILabel *button3Field;
//	IBOutlet UILabel *button4Field;
//	IBOutlet UILabel *button5Field;
//	IBOutlet UILabel *button6Field;
//	IBOutlet UILabel *button7Field;
//	IBOutlet UILabel *button8Field;
//	IBOutlet UILabel *button9Field;
//	IBOutlet UILabel *button10Field;
//	IBOutlet UILabel *button11Field;
//	IBOutlet UILabel *button12Field;
	
	// Timer for the game (there is no time limit)
	NSTimer *previewTimer;
	NSTimer *gameTimer;
	int gameTime;
	int previewTime;
	int	PREVIEW_TIME_LIMIT;
	
	// Game state variables
	int numSelected;
	
}

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

@end

