//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Jorge Salcedo on 11/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"

@interface CalculatorViewController ()
//Private properties :) 
@property (nonatomic) BOOL userIsInTheMiddleOfEnteringANumber;
@property (nonatomic) BOOL periodEntered;
@property (nonatomic, strong) CalculatorBrain *brain;

@end

@implementation CalculatorViewController

@synthesize display = _display; 
@synthesize userIsInTheMiddleOfEnteringANumber =_userIsInTheMiddleOfEnteringANumber;
@synthesize periodEntered = _periodEntered;
@synthesize brain = _brain;

// Personalized Getter 
-(CalculatorBrain *)brain
{
    if(!_brain) _brain = [[CalculatorBrain alloc] init]; 
    return _brain;
}
   
- (IBAction)digitPressed:(UIButton *)sender 
{
    NSString *digit = [sender currentTitle];
    NSLog(@"digit pressed = %@", digit);
    
    if ( self.userIsInTheMiddleOfEnteringANumber ) {
        self.display.text = [self.display.text stringByAppendingString:digit];       
    } else {
        self.display.text = digit;
        self.userIsInTheMiddleOfEnteringANumber = YES;
    }
    
}
- (IBAction)periodPressed 
{
    NSString *period = @"."; 
    if( !self.periodEntered ) {
        self.display.text = [self.display.text stringByAppendingString:period];
        self.periodEntered = YES;
    }
}
- (IBAction)clearPressed 
{
    self.display.text = [[NSNumber numberWithInt:0] stringValue]; 
    self.userIsInTheMiddleOfEnteringANumber = NO;
    [self.brain clearOperation];
}

- (IBAction)operationPressed:(UIButton *)sender 
{
    if (self.userIsInTheMiddleOfEnteringANumber) {
        [self enterPressed]; 
    }
    NSString *operation = [sender currentTitle]; 
    double result = [self.brain performOperation:operation];
    self.display.text = [NSString stringWithFormat:@"%.2f", result];
}

- (IBAction)piPressed:(UIButton *)sender 
{
    self.display.text = [NSString stringWithFormat:@"%.2f", 3.14]; 
    [self enterPressed];
}

- (IBAction)enterPressed 
{
    [self.brain pushOperand:[self.display.text doubleValue]];
    self.userIsInTheMiddleOfEnteringANumber = NO; 
    self.periodEntered = NO; 
}


@end
