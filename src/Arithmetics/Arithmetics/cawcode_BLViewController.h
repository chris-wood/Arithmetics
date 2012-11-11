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
- (IBAction)changeGreeting:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

// Property for the user's name...
@property (weak, nonatomic) NSString *userName; 

@end
