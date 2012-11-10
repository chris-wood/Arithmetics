//
//  cawcode_BLViewController.h
//  Arithmetics
//
//  Created by Christopher Wood on 11/10/12.
//  Copyright (c) 2012 CAWCODE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface cawcode_BLViewController : UIViewController
- (IBAction)changeGreeting:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

// Property for the user's name...
@property (weak, nonatomic) NSString *userName; 

@end
