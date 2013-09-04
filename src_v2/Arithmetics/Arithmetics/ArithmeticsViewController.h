//
//  ArithmeticsViewController.h
//  Arithmetics
//
//  Created by Christopher Wood on 8/14/13.
//  Copyright (c) 2013 Christopher Wood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArithmeticsOptionsViewController.h"

// enum for game mode
typedef enum { NORMAL_MODE, MODULAR_MODE, FRACTION_MODE, COMPLEX_MODE } GameMode;

@interface ArithmeticsViewController : UIViewController <UIPickerViewDelegate>
{
	// The model objects
	NSMutableArray *hiddenFields; // hidden text shown on the button
	NSMutableArray *answerFields; // matched text shown on button
	NSMutableArray *buttonState; // holds NSBool objects that indicate if a button is "active" - showing the answer
	NSMutableArray *buttonPressState;
	NSMutableArray *buttonMatchState;
	NSMutableArray *buttonOutlets; // reference to the grid outlets
	NSMutableDictionary *buttonPairMap;
	int numActiveButtons;
	int activeButtonLimit;
	int matchedButtons;
	int maxButtonValue;
	
	// The view objects
	IBOutlet UILabel *modeField;
	IBOutlet UILabel *scoreField;
	IBOutlet UILabel *timeField;
	IBOutlet UILabel *previewTimeField;
	IBOutlet UIPickerView *modePicker;
	
	// Available modes...
	NSArray *modes;
	ArithmeticsOptionsViewController* optionsController;
	
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
	IBOutlet UIButton *cheatButton_out;
	
	// Timer for the game (there is no time limit)
	NSTimer *previewTimer;
	NSTimer *gameTimer;
	NSTimer *cheatTimer;
	int gameTime;
	int previewTime;
	int	PREVIEW_TIME_LIMIT;
	int GAME_TIME_LIMIT;
	int score;
	
	// enum to specify the mode we're in
	GameMode currentGameMode;
}

//@property (strong, nonatomic) IBOutlet UIPickerView *modePicker;

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
- (IBAction)cheatButtonDown:(id)sender;
- (IBAction)cheatButtonUp:(id)sender;
- (IBAction)optionsButton:(id)sender;

//

@end

