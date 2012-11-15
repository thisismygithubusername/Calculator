//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Jorge Salcedo on 11/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
extern const double PI;
@interface CalculatorBrain : NSObject

-(void)pushOperand:(double)operand;
-(double)performOperation:(NSString *)operation;
-(void)clearOperation;

@property (readonly) id program;
+(double)runProgram:(id) program; 
+(NSString *)descriptionOfProgram:(id)program;


@end
