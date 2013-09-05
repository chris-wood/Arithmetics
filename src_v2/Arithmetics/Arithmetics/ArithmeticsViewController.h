//
//  ArithmeticsViewController.h
//  Arithmetics
//
//  Created by Christopher Wood on 8/14/13.
//  Copyright (c) 2013 Christopher Wood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArithmeticsOptionsViewController.h"
#import "GradientButton.h"

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
//	IBOutlet GradientButton *button1_out;
//	IBOutlet GradientButton *button2_out;
//	IBOutlet GradientButton *button3_out;
//	IBOutlet GradientButton *button4_out;
//	IBOutlet GradientButton *button5_out;
//	IBOutlet GradientButton *button6_out;
//	IBOutlet GradientButton *button7_out;
//	IBOutlet GradientButton *button8_out;
//	IBOutlet GradientButton *button9_out;
//	IBOutlet GradientButton *button10_out;
//	IBOutlet GradientButton *button11_out;
//	IBOutlet GradientButton *button12_out;
//	IBOutlet GradientButton *cheatButton_out;
	
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

@property (nonatomic, strong) IBOutlet GradientButton *button1_out;
@property (nonatomic, strong) IBOutlet GradientButton *button2_out;
@property (nonatomic, strong) IBOutlet GradientButton *button3_out;
@property (nonatomic, strong) IBOutlet GradientButton *button4_out;
@property (nonatomic, strong) IBOutlet GradientButton *button5_out;
@property (nonatomic, strong) IBOutlet GradientButton *button6_out;
@property (nonatomic, strong) IBOutlet GradientButton *button7_out;
@property (nonatomic, strong) IBOutlet GradientButton *button8_out;
@property (nonatomic, strong) IBOutlet GradientButton *button9_out;
@property (nonatomic, strong) IBOutlet GradientButton *button10_out;
@property (nonatomic, strong) IBOutlet GradientButton *button11_out;
@property (nonatomic, strong) IBOutlet GradientButton *button12_out;
@property (nonatomic, strong) IBOutlet GradientButton *cheatButton_out;

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

