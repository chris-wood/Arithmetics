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
