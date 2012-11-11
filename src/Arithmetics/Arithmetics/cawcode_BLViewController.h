//
//  cawcode_BLViewController.h
//  Arithmetics
//
//  Created by Christopher Wood on 11/10/12.
//  Copyright (c) 2012 CAWCODE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface cawcode_BLViewController : UIViewController {
	// Instance variables represent an implementation detail,
	// and should typically not be accessed outside of the class
	// itself. Moreover, you can declare them in the implementation
	// block or synthesize them using declared properties. Typically
	// you should not, therefore, declare instance variables in the
	// public interface and so you should omit the braces.
}
@property (weak, nonatomic) IBOutlet UILabel *lastButtonLabel;
// Outlet properties for the three buttons...
@property (weak, nonatomic) IBOutlet UIButton *button3;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIButton *button1;

// For the three buttons on the screen...
- (IBAction)buttonPress3:(id)sender;
- (IBAction)buttonPress2:(id)sender;
- (IBAction)buttonPress1:(id)sender;

// For the old hello button...
- (IBAction)changeGreeting:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

// Property for the user's name...
@property (weak, nonatomic) NSString *userName; 

@end
