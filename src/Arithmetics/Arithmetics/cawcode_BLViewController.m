//
//  cawcode_BLViewController.m
//  Arithmetics
//
//  Created by Christopher Wood on 11/10/12.
//  Copyright (c) 2012 CAWCODE. All rights reserved.
//

#import "cawcode_BLViewController.h"

@interface cawcode_BLViewController ()

@end

@implementation cawcode_BLViewController

/* Compiler creates the following code:
 * (NSString*)userName
 * (void)setUserName:(NSString*)newUserName
 */
@synthesize userName = _userName; // _userName tells the compiler to generate this instance variable too... since it's not already there

// Instance variables for the buttons...
@synthesize button1 = _button1;
@synthesize button2 = _button2;
@synthesize button3 = _button3;

// Instance variable for the button text label
@synthesize lastButtonLabel = _lastButtonLabel;

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

/**
 * Handler for the first button
 */
- (IBAction)buttonPress1:(id)sender {
	[self showButton:1];
}

- (IBAction)buttonPress2:(id)sender {
	[self showButton:2];
}

- (IBAction)buttonPress3:(id)sender {
	[self showButton:3];
}

- (void)showButton:(int)buttonId {
	NSString *text;
	switch (buttonId)
	{
		case 1:
			text = @"one";
			//[self.button1 setTitle gah...]
			self.lastButtonLabel.text = @"one";
			break;
			
		case 2:
			text = @"two";
			//[self.button2 setTitle:@"two" forState:UIControlStateNormal];
			self.lastButtonLabel.text = @"two";
			break;
			
		case 3:
			text = @"three";
			//[self.button1 setTitle:@"three" forState:UIControlStateNormal];
			self.lastButtonLabel.text = @"three";
			break;
	}
}

- (IBAction)changeGreeting:(id)sender {
	// This is the action handler for pressing the hello button...
	self.userName = self.textField.text;
	NSString *nameString = self.userName;
	if ([nameString length] == 0) {
		nameString = @"World";
	}
	NSString *greeting = [[NSString alloc] initWithFormat:@"Hello, %@!", nameString];
	self.nameLabel.text = greeting;
}
@end
